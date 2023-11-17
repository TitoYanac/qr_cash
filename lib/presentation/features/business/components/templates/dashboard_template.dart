import 'package:flutter/material.dart';
import '../organisms/home_banner_body.dart';
import '../organisms/home_dashboard_body.dart';

class DashboardTemplate extends StatefulWidget {
  const DashboardTemplate({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardTemplate> createState() => _DashboardTemplateState();
}

class _DashboardTemplateState extends State<DashboardTemplate> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        HomeBannerBody(),
        HomeDashboardBody(),
      ],
    );
  }
}
