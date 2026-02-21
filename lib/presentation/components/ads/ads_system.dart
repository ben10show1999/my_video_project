import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart'; // CRITICAL: Fixes click-through in Floating Page
import 'package:my_video_project/core/logic/app_provider.dart';

// --- Fullscreen Viewer with External Browser (Floating Page) ---
class FullscreenAdViewer extends StatelessWidget {
  final String adScript;
  const FullscreenAdViewer({super.key, required this.adScript});

  Future<void> _openBrowser() async {
    const url = "https://google.com"; 
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
          // Content - Force Stretch
          Positioned.fill(
             child: WebAdBanner(
              adScript: adScript,
              isInternal: true, // Prevents nested floating pages
            ),
          ),
          
          // Top Bar with PointerInterceptor Shield
          Positioned(
            top: 40, left: 20,
            child: PointerInterceptor( 
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
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
                      onTap: _openBrowser,
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

// --- Main Banner Widget (Fluid Width & Glass Shield) ---
class WebAdBanner extends StatefulWidget {
  final String adScript;
  final VoidCallback? onClose;
  final bool isInternal;

  const WebAdBanner({
    super.key, 
    required this.adScript, 
    this.onClose,
    this.isInternal = false,
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

  @override
  void initState() {
    super.initState();
    _viewId = 'ad_banner_${DateTime.now().millisecondsSinceEpoch}';
    _registerFactory();
    
    _sub = Connectivity().onConnectivityChanged.listen((res) {
      bool connected = !res.contains(ConnectivityResult.none);
      if (connected && !_isConnected && !_isReloading) {
        // Anti-Freeze: 5s cool-down prevents crash loops
        setState(() => _isReloading = true);
        _cooldownTimer?.cancel();
        _cooldownTimer = Timer(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() { 
              _isConnected = true; 
              _isReloading = false;
              _key = UniqueKey(); 
            });
          }
        });
      } else if (!connected) {
        setState(() => _isConnected = false);
      }
    });
  }

  void _registerFactory() {
    // FLUID GEOMETRY FIX: width: 100vw, height: max-content (Auto Height)
    final content = """
      <html>
      <head>
        <style>
          body { margin: 0; padding: 0; overflow: hidden; width: 100vw; height: max-content; display: block; touch-action: none; }
          iframe { width: 100vw; height: max-content; border: none; display: block; }
        </style>
      </head>
      <body>
        ${widget.adScript}
      </body>
      </html>
    """;

    ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.style.border = 'none';
      iframe.scrolling = 'no'; // Prevent scroll trap
      iframe.srcdoc = content.toJS;
      return iframe;
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<AppProvider>(context);
    
    // FULL WIDTH WRAPPER
    return SizedBox(
      width: double.infinity,
      // We give it a dynamic constraints or default height in Flutter so the engine doesn't complain, 
      // but let the CSS manage the internal fluidity.
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // 1. The Ad Iframe (Removed if offline to stop freeze)
          _isConnected && !_isReloading
              ? ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 150, maxHeight: 400),
                  child: HtmlElementView(key: _key, viewType: _viewId)
                )
              : Container(
                  height: 150,
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
          
          // 2. GLASS SHIELD (Mobile Scroll + Click Hijack Prevention)
          if (!widget.isInternal)
            Positioned.fill(
              child: GestureDetector(
                 behavior: HitTestBehavior.translucent, // Allows drag to bubble up to ListView!
                 onTap: () {
                   // Route click to internal Floating Page EXCLUSIVELY
                   Navigator.push(context, MaterialPageRoute(builder: (_) => FullscreenAdViewer(
                      adScript: widget.adScript,
                    )));
                 },
                 child: Container(color: Colors.transparent),
              ),
            ),
          
          // 3. Close Button
          if (!widget.isInternal && widget.onClose != null)
            Positioned(
              top: 0, left: 0, right: 0,
              child: Center(
                child: PointerInterceptor( 
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque, 
                      onTap: widget.onClose,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.85),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)
                          ),
                          border: Border.all(color: Colors.white24)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(p.tr('close_ad'), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            const Icon(Icons.close, color: Colors.white, size: 14)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
