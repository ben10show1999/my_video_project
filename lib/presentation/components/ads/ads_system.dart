import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart'; 
import 'package:my_video_project/core/logic/app_provider.dart';

// --- Fullscreen Viewer with External Browser ---
class FullscreenAdViewer extends StatelessWidget {
  final String adScript;
  const FullscreenAdViewer({super.key, required this.adScript});

  Future<void> _openBrowser() async {
    const url = "https://google.com"; // In real app, extract from script or pass directly
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
          // TASK 2 & 5: Content - Force Stretch with Expand, Interactive
          Positioned.fill(
             child: WebAdBanner(
              adScript: adScript,
              onClose: () {}, 
              isInternal: true,
              isInteractive: true, // Allow touch events inside Fullscreen
            ),
          ),
          
          // TASK 5: Top Bar - The ONLY way to open external browser
          Positioned(
            top: 40, left: 20,
            child: PointerInterceptor( // Shield UI
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
                      child: const Icon(Icons.public, color: Colors.amber, size: 24), // Globe Icon
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

// --- Main Banner Widget ---
class WebAdBanner extends StatefulWidget {
  final String adScript;
  final VoidCallback onClose;
  final bool isInternal;
  final bool isInteractive;

  const WebAdBanner({
    super.key, 
    required this.adScript, 
    required this.onClose,
    this.isInternal = false,
    this.isInteractive = false, // Default false for inline to allow scrolling
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
    // TASK 2 & 3: Gap removal (margin:0!important) + Scroll Paralysis fix (pointer-events)
    final pointerEvent = widget.isInteractive ? 'auto' : 'none';
    final content = """
      <html>
      <head>
        <style>
          body { margin: 0 !important; padding: 0 !important; overflow: hidden; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; background: transparent; }
          iframe { margin: 0 !important; padding: 0 !important; width: 100%; height: 100%; border: none; object-fit: cover; display: block; pointer-events: $pointerEvent; }
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
      iframe.scrolling = 'no'; 
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
    
    // TASK 2: Use double.infinity width for fluidity. (Height will be constrained by parent if needed)
    return SizedBox(
      width: double.infinity,
      child: Stack(
        fit: widget.isInternal ? StackFit.expand : StackFit.passthrough,
        children: [
          // 1. The Ad Iframe 
          Positioned.fill(
            child: _isConnected && !_isReloading
                ? HtmlElementView(key: _key, viewType: _viewId)
                : Container(
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
          ),
          
          // TASK 4: Glass Shield Overlay (Intercepts taps to open internally, allows scroll)
          if (!widget.isInteractive)
            Positioned.fill(
              child: GestureDetector(
                 behavior: HitTestBehavior.translucent, 
                 onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => FullscreenAdViewer(
                      adScript: widget.adScript,
                    )));
                 },
                 child: Container(color: Colors.transparent),
              ),
            ),
          
          // Close Button for player-level ad
          if (!widget.isInternal)
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
