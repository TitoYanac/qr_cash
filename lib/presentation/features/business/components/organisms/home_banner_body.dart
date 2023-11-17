import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/presentation/features/business/bloc/bloc_business.dart';
import 'package:qrcash/presentation/features/business/bloc/bloc_business_state.dart';
import '../../../../../data/entities/wallet_entity.dart';
import '../../../../atoms/text_atom.dart';
import '../molecules/row_text_molecule.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeBannerBody extends StatefulWidget {
  const HomeBannerBody({Key? key}) : super(key: key);

  @override
  State<HomeBannerBody> createState() => _HomeBannerBodyState();
}

class _HomeBannerBodyState extends State<HomeBannerBody> {

  @override
  Widget build(BuildContext context) {
    double widthOriginalBanner = 1080;
    Size pageSize = MediaQuery.of(context).size;
    double ratio = pageSize.width / widthOriginalBanner;
    double heightPageBanner = 550 * ratio;
    return BlocBuilder<BlocBusiness, BlocBusinessState>(
      bloc: BlocProvider.of<BlocBusiness>(context),
      builder: (context, BlocBusinessState state) {
        List<WalletEntity> wallet = state.business.dashboardTotal?.entry??[];
        String mytext = state.business.myText;
        return Row(
          children: [
            Container(
              width: pageSize.width,
              height: heightPageBanner,
              padding: EdgeInsets.all(50 * ratio),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/banner_body.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.help_outline,
                          color: Colors.red,
                          size: 60 * ratio,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CompositeTermsAndConditionsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),*/
                  Positioned.fill(
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 70 * ratio,
                            ),
                            TextAtom(
                              text: AppLocalizations.of(context)?.total_redeemed,
                              color: Colors.black,
                              weight: FontWeight.bold,
                            ),
                            RowTextMolecule(
                              firstText: "₹",
                              secondText: "${wallet.length > 1 ? wallet[1].Amount : 0}",
                              color: Colors.black,
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black,
                          width: 1,
                          height: 70 * ratio,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 80 * ratio,
                            ),
                            TextAtom(
                              text: AppLocalizations.of(context)?.total_loaded,
                              color: Colors.black,
                              weight: FontWeight.bold,
                            ),
                            RowTextMolecule(
                              firstText: "₹",
                              secondText: "${wallet.isNotEmpty?wallet[0].Amount: 0}",
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
