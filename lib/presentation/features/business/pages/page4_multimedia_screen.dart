import 'package:flutter/material.dart';

import '../widgets/templates/videos_template.dart';
class MultimediaScreen extends StatefulWidget {
  const MultimediaScreen({super.key});

  @override
  State<MultimediaScreen> createState() => _MultimediaScreenState();
}

class _MultimediaScreenState extends State<MultimediaScreen> {
  @override
  Widget build(BuildContext context) {
    return const VideosTemplate();
  }
}
