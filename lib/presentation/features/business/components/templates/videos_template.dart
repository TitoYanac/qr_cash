import 'package:flutter/material.dart';
import '../../../../../data/entities/video_entity.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/business/business.dart';
import '../organisms/video_card_organism.dart';

class VideosTemplate extends StatefulWidget {
  const VideosTemplate({super.key});

  @override
  State<VideosTemplate> createState() => _VideosTemplateState();
}

class _VideosTemplateState extends State<VideosTemplate> {
  late List<VideoEntity> videos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    videos = Business.getInstance().videos?.videos??[];
  }

  Widget buildNoVideosWidget() {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(40),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(
              Icons.sentiment_dissatisfied,
              size: 60,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              translation(context)!.there_are_no_videos_to_show,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideoCard(int index) {
    final video = videos[index];
    return VideoCardOrganism(
      id: "${video.Code}",
      title: "${video.Name}",
      description: "${video.Type}",
      imageUrl: "assets/images/banner_body.jpg",
      videoUrl: "${video.Url}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Center(
              child: Image.asset("assets/icons/video_icon_header.png"),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (videos.isEmpty) {
                return buildNoVideosWidget();
              } else {
                return buildVideoCard(index);
              }
            },
            childCount: isLoading ? 1 : (videos.isEmpty ? 1 : videos.length),
          ),
        ),
      ],
    );
  }
}
