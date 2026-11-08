import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../l10n/app_strings.dart';
import '../widgets/language_button.dart';

/// Un solo video de rutina para todas las categorías.
/// (Validado con el endpoint oEmbed de YouTube: responde 200, se puede incrustar.)
const routineVideoUrl = 'https://www.youtube.com/watch?v=gC_L9qAHVJ8';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final YoutubePlayerController _controller =
      YoutubePlayerController.fromVideoId(
    videoId: YoutubePlayerController.convertUrlToId(routineVideoUrl)!,
    autoPlay: true,
    params: const YoutubePlayerParams(mute: false, strictRelatedVideos: true),
  );

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = L10n.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.t('video_title')),
        actions: const [LanguageButton()],
      ),
      body: ListView(
        children: [
          YoutubePlayer(controller: _controller),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.directions_walk),
                title: Text(s.t('video_button')),
                subtitle: Text(s.t('video_desc')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
