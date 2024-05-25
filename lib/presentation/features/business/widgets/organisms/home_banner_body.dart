import 'package:flutter/material.dart';
import '../../../../../domain/models/business/business.dart';
import '../molecules/total_loaded_info.dart';
import '../molecules/total_redeemed_info.dart';

class HomeBannerBody extends StatefulWidget {
  const HomeBannerBody({super.key});

  @override
  State<HomeBannerBody> createState() => _HomeBannerBodyState();
}

class _HomeBannerBodyState extends State<HomeBannerBody> {
  static const double widthOriginalBanner = 1080;
  static const double initialBannerHeight = 550;
  static const double dividerLineHeight = 40;

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    double ratio = pageSize.width / widthOriginalBanner;
    double heightPageBanner = initialBannerHeight * ratio;

    Widget dividerLine = Container(
      width: 1,
      height: dividerLineHeight,
      color: Theme.of(context).colorScheme.secondary,
    );

    return SliverToBoxAdapter(
      child: SizedBox(
        width: pageSize.width,
        height: heightPageBanner,
        child: Stack(
          children: [
            Container(
              width: pageSize.width,
              height: heightPageBanner,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner_body.jpg'),
                  fit: BoxFit.cover,
                ),
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  TotalRedeemedInfo(
                      redeemed: Business.getInstance()
                          .dashboardTotal!
                          .entry
                          .last
                          .amount),
                  dividerLine,
                  TotalLoadedInfo(
                    loaded: Business.getInstance()
                        .dashboardTotal!
                        .entry
                        .first
                        .amount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
