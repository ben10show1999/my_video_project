import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';

// --- Fullscreen Viewer with External Browser ---
class FullscreenAdViewer extends StatelessWidget {
  final String adScript;
  const FullscreenAdViewer({super.key, required this.adScript, required double width, required double height});

  Future<void> _openBrowser() async {
    const url = "https://google.com"; // Placeholder
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
              width: double.infinity,
              height: double.infinity,
              onClose: () {}, 
              isInternal: true,
            ),
          ),
          
          // Top Bar
          Positioned(
            top: 40, left: 20,
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
          )
        ],
      ),
    );
  }
}

// --- Main Banner Widget (Elastic Stretch + Anti-Freeze + Click Shield) ---
class WebAdBanner extends StatefulWidget {
  final String adScript;
  final double width;
  final double height;
  final VoidCallback onClose;
  final bool isInternal;

  const WebAdBanner({
    super.key, 
    required this.adScript, 
    required this.width, 
    required this.height,
    required this.onClose,
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
  // Task 1: Anti-Freeze Cool-down Timer
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    _viewId = 'ad_banner_${DateTime.now().millisecondsSinceEpoch}';
    _registerFactory();
    
    _sub = Connectivity().onConnectivityChanged.listen((res) {
      bool connected = !res.contains(ConnectivityResult.none);
      if (connected && !_isConnected && !_isReloading) {
        // Enforce 5s cool-down to prevent freeze loop
        setState(() => _isReloading = true);
        _cooldownTimer?.cancel();
        _cooldownTimer = Timer(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() { 
              _isConnected = true; 
              _isReloading = false;
              _key = UniqueKey(); // Refresh Iframe
            });
          }
        });
      } else if (!connected) {
        setState(() => _isConnected = false);
      }
    });
  }

  void _registerFactory() {
    // Task 3: CSS to force content to STRETCH and fill container (Elasticity)
    final content = """
      <html>
      <head>
        <style>
          body { margin: 0; padding: 0; overflow: hidden; width: 100%; height: 100%; display: flex; }
          iframe { width: 100%; height: 100%; border: none; object-fit: cover; }
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
    // Task 3: Use SizedBox.expand to FORCE Fill/Stretch instead of shrinking
    return SizedBox.expand(
      child: Stack(
        children: [
          // 1. The Ad Iframe
          Positioned.fill(
            child: _isConnected && !_isReloading
                ? HtmlElementView(key: _key, viewType: _viewId)
                : Container(
                    color: Colors.black,
                    child: const Center(child: CircularProgressIndicator(color: Colors.amber)),
                  ),
          ),
          
          // Task 2: Click Shielding - Ensure buttons catch events over iframe
          
          // 2. Close Button (Centered Top)
          if (!widget.isInternal)
            Positioned(
              top: 0, left: 0, right: 0,
              child: Center(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque, // FORCE CATCH
                    onTap: widget.onClose,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.8), // Darker for contrast
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)
                        ),
                        border: Border.all(color: Colors.white12)
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

          // 3. Expand Button (Bottom Left)
          if (!widget.isInternal)
            Positioned(
              bottom: 8, left: 8,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque, // FORCE CATCH
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => FullscreenAdViewer(
                      adScript: widget.adScript,
                      width: widget.width,
                      height: widget.height,
                    )));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white30, width: 1.5)
                    ),
                    child: const Icon(Icons.north_east, color: Colors.amber, size: 18),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
