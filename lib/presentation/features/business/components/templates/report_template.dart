import 'package:flutter/material.dart';
import 'package:qrcash/domain/models/business/business.dart';
import 'package:qrcash/presentation/atoms/title_component.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../molecules/tab_bar_qr_list.dart';

class ReportTemplate extends StatefulWidget {
  const ReportTemplate(
      {super.key, required this.handleIndexTabBar, required this.business});
  final Function(int) handleIndexTabBar;
  final Business business;

  @override
  State<ReportTemplate> createState() => _ReportTemplateState();
}

class _ReportTemplateState extends State<ReportTemplate>
    with SingleTickerProviderStateMixin {
  // Controlador para el TabBar y el TabBarView
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Center(child: TitleComponent(translation(context)!.general_report).render()), // Título de la barra de aplicaciones
              pinned: true, // Esto hará que el AppBar permanezca visible en la parte superior
              floating: true, // Esto permite que el AppBar aparezca incluso con un pequeño desplazamiento hacia arriba
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: translation(context)!.today),
                  Tab(text: translation(context)!.all),
                  Tab(text: translation(context)!.offline),
                ],
                onTap: widget.handleIndexTabBar,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            TabBarQrList(keyword: 'today', business: widget.business),
            TabBarQrList(keyword: 'all', business: widget.business),
            TabBarQrList(keyword: 'offline', business: widget.business),
          ],
        ),
      ),
    );
  }
}