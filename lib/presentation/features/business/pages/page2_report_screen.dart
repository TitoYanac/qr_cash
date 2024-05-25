import 'package:flutter/material.dart';

import '../widgets/templates/report_template.dart';
class ReportScreen extends StatefulWidget {
  const ReportScreen(
      {super.key, required this.handleIndexTabBar});
  final Function(int) handleIndexTabBar;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return ReportTemplate(handleIndexTabBar: widget.handleIndexTabBar);
  }
}
