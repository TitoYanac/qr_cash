import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../widgets/appbar_with_leading.dart';

///
class VideoYoutubePage extends StatefulWidget {
  const VideoYoutubePage({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
  }) : super(key: key);
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String videoUrl;
  @override
  State<VideoYoutubePage> createState() => _VideoYoutubePageState();
}

class _VideoYoutubePageState extends State<VideoYoutubePage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.videoUrl) ?? '',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    )..setFullScreenListener(
          (_) async {
            // Save the current build context before the async gap.

            if (!mounted) return;
            final BuildContext currentContext = context;

            final videoData = await _controller.videoData;
            final startSeconds = await _controller.currentTime;

            // Check if the widget is still mounted before using the context.
            if (!mounted) return;

            final currentTime = await FullscreenYoutubePlayer.launch(
              currentContext, // Use the saved context
              videoId: videoData.videoId,
              startSeconds: startSeconds,
            );

            // Check again because another async gap happened.
            if (!mounted) return;

            if (currentTime != null) {
              _controller.seekTo(seconds: currentTime);
            }
      },
    );
  }


  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithLeading(title: translation(context)!.video).getAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: YoutubePlayer(
          key: ObjectKey(_controller),
          aspectRatio: 16 / 9,
          enableFullScreenOnVerticalDrag: false,
          controller: _controller,
        ),
      ),
    );
  }
}
