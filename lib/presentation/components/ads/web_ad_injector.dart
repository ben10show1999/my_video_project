import 'dart:js_interop'; // Essential for .toJS
import 'dart:ui_web' as ui_web; 
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class WebAdInjector extends StatelessWidget {
  final String scriptContent;
  const WebAdInjector({super.key, required this.scriptContent});

  @override
  Widget build(BuildContext context) {
    final String viewType = 'ad-view-${DateTime.now().millisecondsSinceEpoch}-${scriptContent.hashCode}';
    
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      
      // FIX: Converted Dart String to JSString using .toJS
      iframe.srcdoc = '<html><body style="margin:0;padding:0;overflow:hidden;">$scriptContent</body></html>'.toJS;
      
      iframe.style.border = 'none';
      iframe.style.width = '300px';
      iframe.style.height = '250px';
      return iframe;
    });

    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: 300,
        height: 250,
        child: HtmlElementView(viewType: viewType),
      ),
    );
  }
}
