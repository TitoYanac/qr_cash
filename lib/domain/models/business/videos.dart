
import '../../../data/entities/video_entity.dart';

class Videos {
  final List<VideoEntity> videos;

  Videos({
    required this.videos,
  });

  void addVideo(VideoEntity video){
    videos.add(video);
  }
}
