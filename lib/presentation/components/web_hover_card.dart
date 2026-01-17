import 'package:flutter/material.dart';

class WebHoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const WebHoverCard({super.key, required this.child, required this.onTap});

  @override
  State<WebHoverCard> createState() => _WebHoverCardState();
}

class _WebHoverCardState extends State<WebHoverCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) { setState(() => _isHovering = true); _controller.forward(); },
      onExit: (_) { setState(() => _isHovering = false); _controller.reverse(); },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: _isHovering ? [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 10, offset: const Offset(0, 4))] : [],
                border: _isHovering ? Border.all(color: Colors.white30, width: 2) : null,
              ),
              child: widget.child,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
