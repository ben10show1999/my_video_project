import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart'; 
import 'package:my_video_project/core/logic/app_provider.dart';

// --- Floating Fullscreen Ad Viewer ---
class FullscreenAdViewer extends StatelessWidget {
  final String adScript;
  const FullscreenAdViewer({super.key, required this.adScript});

  Future<void> _openExternalBrowser() async {
    const url = "https://google.com"; // External routing 
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fluid Expansion without AspectRatio
          Positioned.fill(
             child: WebAdBanner(
              adScript: adScript,
              isInternal: true, // Inside floating page
            ),
          ),
          
          // Strict Routing: ONLY place external browser is allowed
          Positioned(
            top: 40, left: 20,
            child: PointerInterceptor( 
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.white, size: 24),
                    ),
                    Container(height: 20, width: 1, color: Colors.white38, margin: const EdgeInsets.symmetric(horizontal: 16)),
                    InkWell(
                      onTap: _openExternalBrowser, 
                      child: const Icon(Icons.public, color: Colors.amber, size: 24),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// --- Dynamic Smart Banner Widget ---
class WebAdBanner extends StatefulWidget {
  final String adScript;
  final bool isInternal;
  final VoidCallback? onClose;

  const WebAdBanner({
    super.key, 
    required this.adScript, 
    this.isInternal = false,
    this.onClose,
  });

  @override
  State<WebAdBanner> createState() => _WebAdBannerState();
}

class _WebAdBannerState extends State<WebAdBanner> {
  late String _viewId;
  Key _key = UniqueKey();
  bool _isConnected = true;
  StreamSubscription? _sub;
  bool _isReloading = false;
  Timer? _cooldownTimer;
  
  // Smart Engine Dynamic Height State
  double _dynamicHeight = 250.0; // Initial fallback
  late JSFunction _msgListener;

  @override
  void initState() {
    super.initState();
    _viewId = 'ad_banner_${DateTime.now().millisecondsSinceEpoch}';
    _registerFluidFactory();
    
    // JS to Dart Communication Listener (ResizeObserver Bridge)
    _msgListener = (web.Event event) {
      try {
        final msgEvent = event as web.MessageEvent;
        // Parse the JSON string sent from postMessage
        final dataStr = (msgEvent.data as JSString).toDart;
        final data = jsonDecode(dataStr);
        if (data['type'] == 'ad_resize') {
          final h = (data['height'] as num).toDouble();
          if (h > 0 && h != _dynamicHeight && mounted) {
            setState(() => _dynamicHeight = h);
          }
        }
      } catch (e) {
        // Silently catch parsing errors for non-ad messages
      }
    }.toJS;
    
    web.window.addEventListener('message', _msgListener);

    _sub = Connectivity().onConnectivityChanged.listen((res) {
      bool connected = !res.contains(ConnectivityResult.none);
      if (connected && !_isConnected && !_isReloading) {
        setState(() => _isReloading = true);
        _cooldownTimer?.cancel();
        _cooldownTimer = Timer(const Duration(seconds: 5), () {
          if (mounted) setState(() { _isConnected = true; _isReloading = false; _key = UniqueKey(); });
        });
      } else if (!connected) {
        setState(() => _isConnected = false);
      }
    });
  }

  void _registerFluidFactory() {
    // 1. html, body -> 100vw, 100vh, margin: 0 (No white gaps)
    // 2. object-fit: contain (No edge cropping)
    // 3. ResizeObserver (Dynamic Height Engine)
    final content = """
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style>
          html, body { 
            margin: 0; padding: 0; width: 100vw; height: 100vh; overflow: hidden; 
            display: flex; align-items: center; justify-content: center; background-color: transparent;
          }
          iframe, div, img { max-width: 100%; max-height: 100%; object-fit: contain; }
        </style>
      </head>
      <body>
        <div id="ad-wrapper" style="width: 100%; height: auto; display: flex; justify-content: center; align-items: center;">
          ${widget.adScript}
        </div>
        <script>
          const wrapper = document.getElementById('ad-wrapper');
          const ro = new ResizeObserver(entries => {
            for (let entry of entries) {
              const h = entry.contentRect.height;
              // Send message to Dart listener
              window.parent.postMessage(JSON.stringify({ type: 'ad_resize', height: h }), '*');
            }
          });
          ro.observe(wrapper);
        </script>
      </body>
      </html>
    """;

    ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.style.border = 'none';
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      // STRICT SANDBOX: Removes allow-popups
      iframe.sandbox.add('allow-scripts');
      iframe.sandbox.add('allow-same-origin');
      iframe.srcdoc = content.toJS;
      return iframe;
    });
  }

  @override
  void dispose() {
    web.window.removeEventListener('message', _msgListener);
    _sub?.cancel();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<AppProvider>(context);
    
    // ANIMATED CONTAINER: Smooth expansion/contraction driven by ResizeObserver
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity, 
      height: widget.isInternal ? double.infinity : _dynamicHeight, 
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Smart Fluid Iframe
          if (_isConnected && !_isReloading)
             HtmlElementView(key: _key, viewType: _viewId)
          else
             Container(
               color: Colors.black,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const CircularProgressIndicator(color: Colors.amber),
                   if (!_isConnected) ...[
                     const SizedBox(height: 8),
                     Text(p.tr('connection_error'), style: const TextStyle(color: Colors.white, fontSize: 10))
                   ]
                 ],
               ),
             ),
             
          // 2. GLASS SHIELD (PointerInterceptor + translucent GestureDetector)
          // Allows drag bubbling to ListView & strict internal routing
          Positioned.fill(
            child: PointerInterceptor(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent, 
                onTap: () {
                  if (!widget.isInternal) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => FullscreenAdViewer(
                      adScript: widget.adScript,
                    )));
                  }
                },
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          
          // 3. CENTERED Close Button
          if (!widget.isInternal && widget.onClose != null)
            Positioned(
              top: 0, left: 0, right: 0, 
              child: Center(
                child: PointerInterceptor( 
                  child: GestureDetector(
                    onTap: widget.onClose,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.8),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        border: Border.all(color: Colors.white24)
                      ),
                      child: Text(p.tr('close_ad'), style: const TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
            
          // Expand Icon
          if (!widget.isInternal)
            Positioned(
              bottom: 8, right: 8,
              child: PointerInterceptor( 
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.8), shape: BoxShape.circle),
                  child: const Icon(Icons.fullscreen, color: Colors.white, size: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
