import 'package:flutter/material.dart';
import 'package:qr_save_scan/presentation/core/services/navigation_service.dart';
import 'package:qr_save_scan/presentation/widgets/atoms/text_atom.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../pages/video_youtube_page.dart';

class VideoCardOrganism extends StatefulWidget {
  const VideoCardOrganism({
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
  State<VideoCardOrganism> createState() => _VideoCardOrganismState();
}

class _VideoCardOrganismState extends State<VideoCardOrganism> {
  @override
  Widget build(BuildContext context) {
    Uri toLaunch = Uri(
        scheme: 'https', host: 'www.facebook.com', path: '/vistony/videos/');
    if (widget.videoUrl.contains("www.facebook.com")) {
      toLaunch = Uri(
          scheme: 'https',
          host: 'www.facebook.com',
          path: widget.videoUrl.split("www.facebook.com").last);
    }
    if (widget.videoUrl.contains("fb.watch")) {
      toLaunch = Uri(
          scheme: 'https',
          host: 'fb.watch',
          path: widget.videoUrl.split("fb.watch").last);
    }
    return GestureDetector(
      onTap: () {
        if (widget.videoUrl.contains("youtube.com") ||
            widget.videoUrl.contains("youtu.be")) {
          NavigationService().navigateTo(
            context,
            VideoYoutubePage(
                id: widget.id,
                title: widget.title,
                description: widget.description,
                imageUrl: widget.imageUrl,
                videoUrl: widget.videoUrl),
          );
        } else {
          _launchInBrowser(toLaunch);
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.3,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.5),
                    bottomLeft: Radius.circular(8.5),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    (widget.videoUrl.contains("youtube.com") ||
                            widget.videoUrl.contains("youtu.be"))
                        ? Image.network(
                            "http://img.youtube.com/vi/${widget.videoUrl.split("?v=").last}/0.jpg",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.wifi_off,size: MediaQuery.of(context).size.width * 0.15,color: Theme.of(context).colorScheme.shadow,);
                            }
                          )
                        : Image.asset(
                            "assets/images/banner_body.jpg",
                          ),
                    Center(
                      child: Image.asset(
                        "assets/icons/play_icon.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.3,
                padding: const EdgeInsets.all(12.0),
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextAtom(
                          text: widget.title,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.description,
                              overflow: TextOverflow.ellipsis, maxLines: 3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
