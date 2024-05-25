import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/entities/bank_response_entity.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/business/bank_manager.dart';
import '../../../../../domain/models/business/business.dart';
import '../../../../bloc/status/bloc_splash_screen.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../../../widgets/molecules/my_gradient_btn.dart';
import '../../../../widgets/organisms/custom_sliver_appbar.dart';
import '../../../auth/components/widgets/card_body_user_profile.dart';
import '../../../auth/pages/splash_screen.dart';
import '../../../user/bloc/bloc_user.dart';
import '../../../user/pages/bank_account_information.dart';
import '../../../user/pages/composite_faqs.dart';
import '../../../user/pages/custom_care_page.dart';
import '../../../user/pages/home_rating_app_page.dart';
import '../../../user/pages/qr_entry_manual_page.dart';
import '../../../user/pages/user_profile_information.dart';
import '../../bloc/bloc_business.dart';
import '../../bloc/my_bloc_bottom_navigation_bar.dart';
import '../../pages/composite_terms_and_conditions.dart';
import '../../pages/composite_use_terms.dart';

class AccountTemplate extends StatefulWidget {
  const AccountTemplate({
    super.key,
    required this.blocUser,
  });
  final BlocUser blocUser;
  @override
  State<AccountTemplate> createState() => _AccountTemplateState();
}

class _AccountTemplateState extends State<AccountTemplate> {
  BankManager manager = BankManager(banks: []);
  Future<List<BankResponseEntity>> fetchBanks() async {
    List<BankResponseEntity> banks = Business.getInstance().bankManager!.banks;
    return banks;
  }

  @override
  void initState() {
    super.initState();
    fetchAndSetBanks();
  }

  Future<void> fetchAndSetBanks() async {
    final fetchedBanks = await fetchBanks();
    setState(() {
      manager = BankManager(banks: fetchedBanks);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> opciones = [
      {
        'index': 0,
        'title': AppLocalizations.of(context)!.profile_details,
        'prefixIcon': "assets/icons/pencil.svg",
        'leadingPage': BlocProvider.value(
          value: BlocProvider.of<BlocUser>(context),
          child: const UserProfileInformation(),
        ),
        //'leadingPage': const NotLoggedScreen(),
      },
      {
        'index': 1,
        'title': AppLocalizations.of(context)!.bank_details,
        'prefixIcon': "assets/icons/bank.svg",
        'leadingPage': BlocProvider.value(
          value: BlocProvider.of<BlocUser>(context),
          child: BankAccountInformation(banks: manager),
        ),
      },
      {
        'index': 2,
        'title': AppLocalizations.of(context)!.ranking,
        'prefixIcon': "assets/icons/star.svg",
        'leadingPage': BlocProvider.value(
          value: BlocProvider.of<BlocUser>(context),
          child: const HomeRatingAppPage(),
        ),
      },
      {
        'index': 3,
        'title': translation(context)!.manual_qr_entry,
        'prefixIcon': "assets/icons/scanned.svg",
        'leadingPage': BlocProvider.value(
          value: BlocProvider.of<BlocBusiness>(context),
          child: const QrEntryManualPage(),
        ),
      },
      /*{
        'index': 5,
        'title': AppLocalizations.of(context)!.customer_support,
        'prefixIcon': "assets/icons/info.svg",
        'leadingPage': const CustomCarePage(),
      },*/
      {
        'index': 4,
        'title': AppLocalizations.of(context)!.faqs_support.toUpperCase().split("").first + AppLocalizations.of(context)!.faqs_support.substring(1).toLowerCase(),
        'prefixIcon': "assets/icons/faq.png",
        'leadingPage': CompositeFaqs(username: widget.blocUser.state.personData?.name??"<username>",),
      },
      {
        'index': 5,
        'title': AppLocalizations.of(context)!
            .terms_and_conditions[0]
            .toUpperCase() +
            AppLocalizations.of(context)!.terms_and_conditions.substring(1),
        'prefixIcon': "assets/icons/libro.svg",
        'leadingPage': const CompositeTermsAndConditionsScreen(),
      },
      {
        'index': 6,
        'title': AppLocalizations.of(context)!.terms_of_use,
        'prefixIcon': "assets/icons/libro.svg",
        'leadingPage': const CompositeUseTerms(),
      }
    ];
    return CustomScrollView(slivers: [
      CustomSliverAppbar(
        title: AppLocalizations.of(context)!.account,
        leading: false,
      ),
      SliverPadding(
        padding: const EdgeInsets.all(24.0),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
          const CardBodyUserProfile(),
          const SizedBox(height: 12),
          Divider(color: Theme.of(context).colorScheme.shadow),
          for (Map<String, Object> opcion in opciones)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: UserOptionAccount(
                titleOption: opcion["title"] as String,
                prefixIcon: opcion["prefixIcon"] as String,
                leadingPage: opcion["leadingPage"] as Widget,
                index: opcion["index"] as int,
              ),
            ),
          const SizedBox(
            height: 40,
          ),
          MyGradientBtn(
            onPressed: () async {
              await SharedPreferences.getInstance().then((value) {
                value.remove("phone");
                BlocProvider.of<MyBlocBottomNavigationBar>(context).toPage(0);
                NavigationService().navigateToAndRemoveUntil(
                    context,
                    BlocProvider(
                      create: (BuildContext context) =>
                          BlocSplashScreen(AuthenticationService(context)),
                      child: const SplashScreen(),
                    ));
              });
            },
            text: translation(context)!.logout,
            icon: "assets/icons/logout.svg",
          ),
          const SizedBox(
            height: 40,
          ),
        ])),
      ),
    ]);
  }
}

class UserOptionAccount extends StatefulWidget {
  const UserOptionAccount(
      {super.key,
      required this.titleOption,
      required this.prefixIcon,
      required this.leadingPage,
      required this.index});

  final String titleOption;
  final String prefixIcon;
  final Widget leadingPage;
  final int index;
  @override
  State<UserOptionAccount> createState() => _UserOptionAccountState();
}

class _UserOptionAccountState extends State<UserOptionAccount> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.index == 0){
          NavigationService().navigateTo(
            context,
            widget.leadingPage,
          );
        }else{
          NavigationService().navigateTo(
            context,
            widget.leadingPage,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            if(widget.prefixIcon.split(".").last == "svg")
              SvgPicture.asset(
                widget.prefixIcon,
                width: 24,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
            if(widget.prefixIcon.split(".").last == "png")
              Image.asset(
                widget.prefixIcon,
                width: 24,
                color: Theme.of(context).primaryColor,
              ),
            const SizedBox(
              width: 12,
            ),
            TextAtom(
              text: widget.titleOption,
            )
          ],
        ),
      ),
    );
  }

}
