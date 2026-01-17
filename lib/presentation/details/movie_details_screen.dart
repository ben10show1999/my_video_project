import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../data/models/movie_models.dart';
import '../components/buttons/action_icon_button.dart';
import '../components/player/smart_media_kit_player.dart';
import 'components/playlist_sidebar.dart';
import 'components/lazy_horizontal_section.dart';

class MovieDetailsScreen extends StatefulWidget { const MovieDetailsScreen({super.key}); @override State<MovieDetailsScreen> createState() => _MovieDetailsScreenState(); }

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late ScrollController _mainScrollController;
  late MovieModel _movie; late SeasonModel _currentSeason; late EpisodeModel _currentEpisode;
  bool _isAutoplay = true; final bool _isLoadingList = false;

  @override
  void initState() {
    super.initState();
    _mainScrollController = ScrollController();
    _loadFakeData();
  }

  void _loadFakeData() {
      _movie = MovieModel(id: 1, title: "Flutter Mastery Series", overview: "An epic journey into Dart & Flutter development. This series covers everything from basics to advanced patterns.", posterPath: "", seasons: [
          SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(15, (i) => EpisodeModel(id: "e$i", title: "Episode ${i+1}", duration: "24:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoSourceModel(label: "Auto", url: "https://user-images.githubusercontent.com/28053651/202696586-48e7996a-7485-414f-8484-a5416297ea42.mp4")])))
      ]);
      _currentSeason = _movie.seasons.first;
      _currentEpisode = _currentSeason.episodes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(builder: (ctx, constraints) {
          bool isDesktop = constraints.maxWidth > 900;
          return isDesktop ? _buildDesktop(constraints) : _buildMobile();
      }),
    );
  }

  Widget _buildMobile() {
      return SingleChildScrollView(controller: _mainScrollController, child: Column(children: [
          SmartMediaKitPlayer(sources: _currentEpisode.sources, thumbnailUrl: _currentEpisode.thumbnailUrl),
          Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
             _buildHeaderInfo(isMobile: true),
             const SizedBox(height: 24),
             _buildOverview(),
             const SizedBox(height: 24), const Divider(color: Colors.white10), const SizedBox(height: 24),
             const Text("Episodes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12),
             PlaylistSidebar(isDesktop: false, seasons: _movie.seasons, currentSeason: _currentSeason, currentEpisode: _currentEpisode, onSeasonChanged: (s) => setState(() => _currentSeason = s), onEpisodeTap: (e) => setState(() => _currentEpisode = e), isAutoplayEnabled: _isAutoplay, onAutoplayChanged: (v) => setState(() => _isAutoplay = v), isLoadingMore: _isLoadingList, onLoadMore: () {}),
             const SizedBox(height: 32),
             _buildRecs(),
          ])),
      ]));
  }

  Widget _buildDesktop(BoxConstraints c) {
      return SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(24), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 3, child: Column(children: [SmartMediaKitPlayer(sources: _currentEpisode.sources), const SizedBox(height: 20), _buildHeaderInfo(isMobile: false)])),
          const SizedBox(width: 24),
          Expanded(flex: 1, child: Column(children: [
             PlaylistSidebar(isDesktop: true, seasons: _movie.seasons, currentSeason: _currentSeason, currentEpisode: _currentEpisode, onSeasonChanged: (s) => setState(() => _currentSeason = s), onEpisodeTap: (e) => setState(() => _currentEpisode = e), isAutoplayEnabled: _isAutoplay, onAutoplayChanged: (v) => setState(() => _isAutoplay = v), isLoadingMore: _isLoadingList, onLoadMore: () {}),
             const SizedBox(height: 24), _buildOverview()
          ])),
      ])));
  }

  Widget _buildHeaderInfo({required bool isMobile}) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_movie.title, style: isMobile ? AppStyles.headlineMedium : AppStyles.headlineLarge),
          const SizedBox(height: 12),
          Row(children: [_tag("2024"), const SizedBox(width: 8), _tag("PG-13"), const SizedBox(width: 8), const Icon(Icons.star_rounded, color: AppColors.primary, size: 18), const Text("9.8", style: TextStyle(color: AppColors.success))]),
          const SizedBox(height: 20),
          SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
              ActionIconButton(icon: Icons.add, label: "My List", onTap: () {}), const SizedBox(width: 16),
              ActionIconButton(icon: Icons.thumb_up_off_alt, label: "Rate", onTap: () {}), const SizedBox(width: 16),
              ActionIconButton(icon: Icons.share_outlined, label: "Share", onTap: () {}),
          ])),
      ]);
  }

  Widget _buildOverview() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_movie.overview, style: const TextStyle(color: Colors.white70, height: 1.5)),
          const SizedBox(height: 16),
          const Text("Cast", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(height: 60, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: 5, separatorBuilder: (_,__) => const SizedBox(width: 12), itemBuilder: (_,i) => CircleAvatar(backgroundColor: Colors.white10, child: Text("${i+1}"))))
      ]);
  }

  Widget _buildRecs() {
      return LazyHorizontalSection(title: "Recommendations", initialMovies: List.generate(5, (i) => MovieSnippet(id: "$i", imageUrl: "https://via.placeholder.com/150x220", title: "Movie $i")), onLoadMore: () async => []);
  }

  Widget _tag(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(4)), child: Text(t, style: AppStyles.tagText));
}
