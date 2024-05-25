import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_save_scan/presentation/widgets/organisms/custom_sliver_appbar.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../bloc/bloc_business.dart';
import '../molecules/tab_bar_qr_list.dart';

class ReportTemplate extends StatefulWidget {
  const ReportTemplate({super.key, required this.handleIndexTabBar});
  final Function(int) handleIndexTabBar;

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
      child: CustomScrollView(
        slivers: [
          CustomSliverAppbar(
            title: translation(context)!.general_report,
            leading: false,
          ),
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: translation(context)!.today),
                  Tab(text: translation(context)!.all),
                  Tab(text: translation(context)!.offline),
                ],
                onTap: widget.handleIndexTabBar,
              ),
            )),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverFillRemaining(
              child: BlocBuilder<BlocBusiness, BlocBusinessState>(
                builder: (context, state) {
                  return TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      TabBarQrList(
                          keyword: 'today', listQr: state.listAcceptedQR),
                      TabBarQrList(
                          keyword: 'all', listQr: state.listAcceptedQR),
                      TabBarQrList(
                          keyword: 'offline', listQr: state.listPendingQR),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
