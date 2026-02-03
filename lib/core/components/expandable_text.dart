import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget { 
  final String text; final int maxLines; 
  const ExpandableText({super.key, required this.text, this.maxLines = 3}); 
  @override State<ExpandableText> createState() => _ExpandableTextState(); 
}

class _ExpandableTextState extends State<ExpandableText> { 
  bool _expanded = false; 
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    final span = TextSpan(text: widget.text, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5));
    final tp = TextPainter(text: span, maxLines: widget.maxLines, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 48); // Approx padding
    if (tp.didExceedMaxLines) {
      setState(() => _isOverflowing = true);
    }
  }

  @override 
  Widget build(BuildContext context) { 
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.text, 
        maxLines: _expanded ? null : widget.maxLines, 
        overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis, 
        style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5)
      ), 
      if (_isOverflowing) ...[
        const SizedBox(height: 4), 
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded), 
          child: Text(_expanded ? "Show Less" : "Show More", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12))
        )
      ]
    ]); 
  } 
}
