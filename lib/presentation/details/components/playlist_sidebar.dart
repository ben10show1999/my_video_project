import 'package:flutter/material.dart';
import '../../../core/components/universal_image.dart';
import '../../../data/models/movie_models.dart';
import '../../components/ads/ads_system.dart';

class PlaylistSidebar extends StatefulWidget {
  final List<SeasonModel> seasons;
  final SeasonModel currentSeason;
  final EpisodeModel currentEpisode;
  final Function(SeasonModel) onSeasonChanged;
  final Function(EpisodeModel) onEpisodeTap;
  final bool isDesktop;
  final bool isAutoplayEnabled;
  final ValueChanged<bool> onAutoplayChanged;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;

  const PlaylistSidebar({
    super.key, required this.seasons, required this.currentSeason, required this.currentEpisode,
    required this.onSeasonChanged, required this.onEpisodeTap, this.isDesktop = false,
    required this.isAutoplayEnabled, required this.onAutoplayChanged, required this.isLoadingMore, required this.onLoadMore,
  });

  @override
  State<PlaylistSidebar> createState() => _PlaylistSidebarState();
}

class _PlaylistSidebarState extends State<PlaylistSidebar> {
  bool _showAd = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.isDesktop) {
        _scrollController.addListener(() {
            if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) widget.onLoadMore();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10))), child: Column(children: [
            DropdownButton<SeasonModel>(value: widget.currentSeason, dropdownColor: const Color(0xFF202020), isExpanded: true, items: widget.seasons.map((s) => DropdownMenuItem(value: s, child: Text(s.title, style: const TextStyle(color: Colors.white)))).toList(), onChanged: (v) { if (v != null) widget.onSeasonChanged(v); }),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Autoplay", style: TextStyle(color: Colors.grey)), Switch(value: widget.isAutoplayEnabled, onChanged: widget.onAutoplayChanged, activeThumbColor: Colors.amber)]),
        ])),
        if (_showAd) Padding(padding: const EdgeInsets.all(8.0), child: SmartAdContainer(adAspectRatio: 320/100, onClose: () => setState(() => _showAd = false), externalUrl: "https://google.com", adContent: Image.network("https://via.placeholder.com/320x100", fit: BoxFit.cover))),
        widget.isDesktop ? Expanded(child: _buildList()) : _buildList(),
    ]);
  }

  Widget _buildList() {
      return ListView.builder(
          controller: widget.isDesktop ? _scrollController : null,
          shrinkWrap: !widget.isDesktop,
          physics: widget.isDesktop ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
          itemCount: widget.currentSeason.episodes.length + (widget.isLoadingMore ? 1 : 0),
          itemBuilder: (ctx, index) {
              if (index == widget.currentSeason.episodes.length) return const Center(child: CircularProgressIndicator(color: Colors.amber));
              final ep = widget.currentSeason.episodes[index];
              final isSelected = ep.id == widget.currentEpisode.id;
              return InkWell(onTap: () => widget.onEpisodeTap(ep), child: Container(padding: const EdgeInsets.all(8), color: isSelected ? Colors.white10 : Colors.transparent, child: Row(children: [
                  SizedBox(width: 100, height: 60, child: UniversalImage(path: ep.thumbnailUrl ?? "assets/images/placeholder.jpg")),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(ep.title, style: TextStyle(color: isSelected ? Colors.amber : Colors.white)), Text(ep.duration, style: const TextStyle(color: Colors.grey, fontSize: 12))]))
              ])));
          },
      );
  }
}
