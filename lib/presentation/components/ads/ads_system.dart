import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// --- Fullscreen Viewer (Restored) ---
class FullscreenAdViewer extends StatelessWidget {
  final String adScript;
  final double width;
  final double height;
  final String? externalUrl;

  const FullscreenAdViewer({
    super.key, 
    required this.adScript, 
    required this.width, 
    required this.height,
    this.externalUrl
  });

  Future<void> _openBrowser() async {
    // FIX: Open in external browser (Chrome/Safari) not inside WebView
    const url = "https://google.com"; // Replace with dynamic URL if available
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // The Ad Content (Centered & Scaled)
          Center(
            child: WebAdBanner(
              adScript: adScript,
              width: width,
              height: height,
              onClose: () {}, // No close button inside the banner here
              isInternal: true, // Hide expand button in fullscreen
            ),
          ),
          
          // Top Bar (Close X | Gap | Browser Icon)
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
                  // Close Icon
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                  
                  // The Gap
                  Container(
                    height: 20, width: 1, 
                    color: Colors.white38, 
                    margin: const EdgeInsets.symmetric(horizontal: 16)
                  ),

                  // Open in Browser Icon
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

// --- Main Banner Widget ---
class WebAdBanner extends StatefulWidget {
  final String adScript;
  final double width;
  final double height;
  final VoidCallback onClose;
  final bool isInternal; // To hide expand button if already fullscreen

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

  @override
  void initState() {
    super.initState();
    _viewId = 'ad_banner_${DateTime.now().millisecondsSinceEpoch}';
    _registerFactory();
    
    _sub = Connectivity().onConnectivityChanged.listen((res) {
      bool connected = !res.contains(ConnectivityResult.none);
      if (connected && !_isConnected) {
        setState(() { 
          _isConnected = true; 
          _key = UniqueKey(); 
        });
      } else if (!connected) {
        setState(() => _isConnected = false);
      }
    });
  }

  void _registerFactory() {
    final content = """
      <html>
      <body style="margin:0;padding:0;overflow:hidden;display:flex;justify-content:center;align-items:center;height:100%;background-color:transparent;">
        ${widget.adScript}
      </body>
      </html>
    """;

    ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.style.border = 'none';
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      iframe.srcdoc = content.toJS;
      return iframe;
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FIX: Tight Fit Logic
    // We constrain the container to the EXACT ad size.
    // FittedBox ensures it scales down ONLY if screen is smaller.
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown, // Only shrink, never stretch
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.width,   // Exact width (e.g. 300)
          height: widget.height, // Exact height (e.g. 250)
          child: Stack(
            children: [
              // 1. The Ad Iframe
              _isConnected 
                  ? HtmlElementView(key: _key, viewType: _viewId)
                  : Container(
                      color: Colors.black,
                      child: const Center(child: CircularProgressIndicator(color: Colors.amber)),
                    ),
              
              // 2. Close Button (Restored: Transparent & Centered/Top)
              if (!widget.isInternal)
                Positioned(
                  top: 0, right: 0,
                  child: InkWell(
                    onTap: widget.onClose,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12)),
                      ),
                      child: const Row(
                        children: [
                          Text("Close", style: TextStyle(color: Colors.white, fontSize: 10)),
                          Icon(Icons.close, color: Colors.white, size: 12)
                        ],
                      ),
                    ),
                  ),
                ),

              // 3. Expand Button (Restored: Bottom Left ↗️)
              if (!widget.isInternal)
                Positioned(
                  bottom: 4, left: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => FullscreenAdViewer(
                        adScript: widget.adScript,
                        width: widget.width,
                        height: widget.height,
                      )));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30, width: 1)
                      ),
                      child: const Icon(Icons.north_east, color: Colors.white, size: 14),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
