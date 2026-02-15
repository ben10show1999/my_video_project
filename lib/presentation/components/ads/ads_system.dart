import 'dart:async';
import 'dart:js_interop'; // FIX: Required for .toJS conversion
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Task 24: Web Script Banner (Iframe Sandbox)
class WebAdBanner extends StatefulWidget {
  final String adScript;
  final double width;
  final double height;
  final VoidCallback onClose;

  const WebAdBanner({
    super.key, 
    required this.adScript, 
    required this.width, 
    required this.height,
    required this.onClose,
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
    
    // Task 22: Auto-Resume on Reconnect
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
      <body style="margin:0;padding:0;overflow:hidden;display:flex;justify-content:center;align-items:center;height:100%;">
        ${widget.adScript}
      </body>
      </html>
    """;

    ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.style.border = 'none';
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      
      // FIX 1: Convert Dart String to JSString using .toJS
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
    // Task 23: Geometric Isolation
    return Container(
      // FIX 2: Use withValues(alpha: ...) instead of deprecated withOpacity
      color: Colors.black.withValues(alpha: 0.8), 
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: _isConnected 
                ? HtmlElementView(key: _key, viewType: _viewId)
                : const Center(child: CircularProgressIndicator(color: Colors.amber)),
            ),
          ),
          Positioned(
            top: 8, right: 8,
            child: InkWell(
              onTap: widget.onClose,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: const Text("Close AD ×", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
