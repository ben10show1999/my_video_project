import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// --- �1�0�1�9 �1�9�1�8�1�7�1�8�1�8�1�9�1�6 ---
class AdaptiveCloseAdButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AdaptiveCloseAdButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white54),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Close AD", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
            Icon(Icons.close, color: Colors.white, size: 14),
          ],
        ),
      ),
    );
  }
}

// --- �1�7�1�9�1�9�1�4 �1�9�1�8�1�2�1�9�1�2�1�1 �1�9�1�8�1�7�1�9�1�9�1�8�1�1 ---
class FullscreenAdViewer extends StatelessWidget {
  final Widget adContent;
  final String? externalAdUrl;
  const FullscreenAdViewer({super.key, required this.adContent, this.externalAdUrl});

  Future<void> _openInBrowser() async {
    if (externalAdUrl != null) {
      final Uri uri = Uri.parse(externalAdUrl!);
      if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          InteractiveViewer(minScale: 0.5, maxScale: 4.0, child: Center(child: adContent)),
          Positioned(
            top: 20, left: 20,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  children: [
                    InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: Colors.white)),
                    if (externalAdUrl != null) ...[
                      Container(height: 18, width: 1, color: Colors.white38, margin: const EdgeInsets.symmetric(horizontal: 12)),
                      InkWell(onTap: _openInBrowser, child: const Icon(Icons.open_in_browser_rounded, color: Colors.amber)),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- �1�9�1�5�1�9�1�8 �1�9�1�8�1�7�1�7�1�8�1�9�1�0�1�9�1�2 �1�9�1�8�1�9�1�2�1�3�1�2�1�6 (Retry Logic Fixed) ---
class ReliableAdLoader extends StatefulWidget {
  final String adUrl;
  final Widget Function(BuildContext, String) adBuilder;
  const ReliableAdLoader({super.key, required this.adUrl, required this.adBuilder});
  @override
  State<ReliableAdLoader> createState() => ReliableAdLoaderState();
}

class ReliableAdLoaderState extends State<ReliableAdLoader> {
  bool _hasError = false;
  Key _adKey = UniqueKey();
  StreamSubscription? _connSub;

  @override
  void initState() {
    super.initState();
    _connSub = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // �1�9�1�8�1�2�1�5�1�6�1�6 �1�9�1�0 �1�7�1�2�1�7�1�1 �1�9�1�8�1�7�1�0�1�2�1�9�1�0�1�2 (�1�9�1�8�1�6�1�9�1�8�1�9�1�1 �1�8�1�9 �1�2�1�5�1�2�1�2�1�4 �1�7�1�8�1�3 none)
      if (_hasError && !results.contains(ConnectivityResult.none)) {
        _retry();
      }
    });
  }

  void _retry() { if (mounted) setState(() { _hasError = false; _adKey = UniqueKey(); }); }
  void triggerError() { if (mounted) setState(() => _hasError = true); }
  @override
  void dispose() { _connSub?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        color: Colors.black, width: double.infinity, height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, color: Colors.white54, size: 40),
            const SizedBox(height: 12),
            const Text("�1�8�1�6�1�7 �1�9�1�0�1�6�1�5�1�7 �1�9�1�2�1�3�1�9�1�8 �1�9�1�8�1�5�1�0�1�2�1�9�1�0�1�2", style: TextStyle(color: Colors.white)),
            TextButton.icon(onPressed: _retry, icon: const Icon(Icons.refresh), label: const Text("�1�7�1�7�1�9�1�7�1�1 �1�9�1�5�1�9�1�2�1�8�1�1")),
          ],
        ),
      );
    }
    return Builder(key: _adKey, builder: (ctx) => widget.adBuilder(ctx, widget.adUrl));
  }
}

// --- �1�9�1�8�1�5�1�9�1�2�1�4�1�1 �1�9�1�8�1�8�1�7�1�4�1�1 ---
class SmartAdContainer extends StatelessWidget {
  final Widget adContent;
  final VoidCallback onClose;
  final String? externalUrl;
  final double adAspectRatio;

  const SmartAdContainer({super.key, required this.adContent, required this.onClose, this.externalUrl, this.adAspectRatio = 16 / 9});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: adAspectRatio,
      child: Container(
        decoration: BoxDecoration(color: const Color(0xFF151515), border: Border.all(color: Colors.white10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Positioned.fill(child: FittedBox(fit: BoxFit.cover, child: adContent)),
              Positioned(top: 8, left: 0, right: 0, child: Center(child: AdaptiveCloseAdButton(onPressed: onClose))),
              Positioned(
                bottom: 8, left: 8,
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FullscreenAdViewer(adContent: adContent, externalAdUrl: externalUrl))),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle, border: Border.all(color: Colors.white30)),
                    child: const Icon(Icons.north_east_rounded, color: Colors.white, size: 16),
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
