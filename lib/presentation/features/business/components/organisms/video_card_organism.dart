import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../pages/video_youtube_page.dart';

class VideoCardOrganism extends StatefulWidget {
  const VideoCardOrganism({
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
  State<VideoCardOrganism> createState() => _VideoCardOrganismState();
}

class _VideoCardOrganismState extends State<VideoCardOrganism> {
  Future<void>? _launched;
  @override
  Widget build(BuildContext context) {
    Uri toLaunch =
    Uri(scheme: 'https', host: 'www.facebook.com', path: '/vistony/videos/');
    if(widget.videoUrl.contains("www.facebook.com")){
      toLaunch =
          Uri(scheme: 'https', host: 'www.facebook.com', path: widget.videoUrl.split("www.facebook.com").last);
    }
    if(widget.videoUrl.contains("fb.watch")){
      toLaunch =
          Uri(scheme: 'https', host: 'fb.watch', path: widget.videoUrl.split("fb.watch").last);
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          if(widget.videoUrl.contains("youtube.com")|| widget.videoUrl.contains("youtu.be")){

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoYoutubePage(
                    id: widget.id,
                    title: widget.title,
                    description: widget.description,
                    imageUrl: widget.imageUrl,
                    videoUrl: widget.videoUrl),
              ),
            );
          }else{
            setState(() {
              _launched = _launchInBrowser(toLaunch);
            });
          }
        },
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Icon(
            Icons.play_arrow,
            color: Theme.of(context).colorScheme.secondary,
            size: 32,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
