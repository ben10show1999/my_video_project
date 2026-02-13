import 'dart:js_interop'; // 1. استيراد ضروري جداً للتحويل
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class WebIframeAd extends StatefulWidget {
  final String scriptContent;
  final double width;
  final double height;
  const WebIframeAd({super.key, required this.scriptContent, required this.width, required this.height});

  @override
  State<WebIframeAd> createState() => _WebIframeAdState();
}

class _WebIframeAdState extends State<WebIframeAd> {
  late String _viewId;
  
  @override
  void initState() {
    super.initState();
    _viewId = 'iframe-ad-${DateTime.now().millisecondsSinceEpoch}';
    
    final String fullHtml = """
      <html>
        <body style="margin:0;padding:0;overflow:hidden;background-color:black;display:flex;justify-content:center;align-items:center;">
          ${widget.scriptContent}
        </body>
      </html>
    """;

    ui.platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
      final iframe = web.HTMLIFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none'
        // 2. التصحيح هنا: إضافة .toJS
        ..srcdoc = fullHtml.toJS; 
      
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(viewType: _viewId),
    );
  }
}