import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../widgets/organisms/custom_sliver_appbar.dart';


class MyAppBarWithLeading {
  final String title;

  MyAppBarWithLeading({required this.title});

  AppBar getAppBar() {
    return AppBar(
      title: Text(title),
    );
  }
}

class VideoYoutubePage extends StatefulWidget {
  const VideoYoutubePage({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
  });

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
  bool showPlayIcon = true;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(widget.videoUrl) ?? '',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    )..setFullScreenListener(
          (_) async {
        if (!mounted) return;
        final BuildContext currentContext = context;

        final videoData = await _controller.videoData;
        final startSeconds = await _controller.currentTime;

        if (!mounted) return;

        final currentTime = await FullscreenYoutubePlayer.launch(
          currentContext,
          videoId: videoData.videoId,
          startSeconds: startSeconds,
        );

        if (!mounted) return;

        if (currentTime != null) {
          _controller.seekTo(seconds: currentTime);
        }
      },
    );

    // Escucha los cambios en el estado del reproductor
    _controller.listen((value) {
      if (value.playerState == PlayerState.playing) {
        if (showPlayIcon) {
          setState(() {
            showPlayIcon = false;
          });
        }
      } else if (value.playerState == PlayerState.paused ||
          value.playerState == PlayerState.unknown ||
          value.playerState == PlayerState.unStarted) {
        if (!showPlayIcon) {
          setState(() {
            showPlayIcon = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: widget.title,
              leading: true,
            ),
            SliverFillRemaining(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: YoutubePlayer(
                        key: ObjectKey(_controller),
                        aspectRatio: 16 / 9,
                        enableFullScreenOnVerticalDrag: false,
                        controller: _controller,
                      ),
                    ),
                  ),
                  if (showPlayIcon)
                    GestureDetector(
                      onTap:(){
                        _controller.playVideo();
                        setState(() {
                          showPlayIcon = false;
                        });
                      },
                      child: const Center(
                        child: Icon(Icons.play_arrow, color: Colors.white, size: 36),
                      ),
                    )
                ],
              ),

            )
          ]
        ),
      ),
    );
  }
}