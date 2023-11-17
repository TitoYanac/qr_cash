import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/presentation/core/services/navigation_service.dart';
import 'package:qrcash/presentation/features/business/pages/composite_terms_and_conditions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../data/entities/bank_response_entity.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/business/bank_manager.dart';
import '../../../../../domain/models/business/business.dart';
import '../../../../../splash_screen.dart';
import '../../../../atoms/paragraph_component.dart';
import '../../../../atoms/title_component.dart';
import '../../../auth/components/molecules/my_button_submit.dart';
import '../../../auth/components/widgets/card_body_user_profile.dart';
import '../../../bloc/btn/bloc_btn_state.dart';
import '../../../bloc/btn/bloc_btn.dart';
import '../../../user/pages/bank_account_information.dart';
import '../../../user/pages/composite_faqs.dart';
import '../../../user/pages/custom_care_page.dart';
import '../../../user/pages/home_rating_app_page.dart';
import '../../../user/pages/qr_entry_manual_page.dart';
import '../../../user/pages/user_profile_information.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/my_bloc_bottom_navigation_bar.dart';


class AccountTemplate extends StatefulWidget {
  const AccountTemplate({
    Key? key,
  }) : super(key: key);
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
        'description': translation(context)!.update_your_personal_information,
        'leadingPage':const UserProfileInformation(),
      },
      {
        'index': 1,
        'title': AppLocalizations.of(context)!.bank_details,
        'description': translation(context)!.update_your_bank_information,
        'leadingPage': BankAccountInformation(banks: manager),
      },
      {
        'index': 2,
        'title': AppLocalizations.of(context)!.ranking,
        'description': translation(context)!.rate_our_app,
        'leadingPage': const HomeRatingAppPage(),
      },
      {
        'index': 3,
        'title': translation(context)!.manual_qr_entry,
        'description': translation(context)!.manually_enter_the_qr_code,
        'leadingPage': const QrEntryManualPage(),
      },
      {
        'index': 4,
        'title': AppLocalizations.of(context)!.faqs,
        'description': translation(context)!
            .concise_and_clear_answers_to_your_most_frequently_asked_questions,
        'leadingPage': const CompositeFaqs(),
      },
      {
        'index': 5,
        'title': AppLocalizations.of(context)!.customer_support,
        'description': translation(context)!.contact_us_if_you_have_any_issues,
        'leadingPage': const CustomCarePage(),
      },
      {
        'index': 6,
        'title': AppLocalizations.of(context)!.terms_and_conditions[0].toUpperCase() + AppLocalizations.of(context)!.terms_and_conditions.substring(1),
        'description': translation(context)!.t_c__agreement_to_our_legal_terms_.toLowerCase()[0].toUpperCase() + translation(context)!.t_c__agreement_to_our_legal_terms_.toLowerCase().substring(1),
        'leadingPage': const CompositeTermsAndConditionsScreen(),
      }
    ];
    return ListView(
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 50),
      children: [
        const CardBodyUserProfile(),
        const SizedBox(
          height: 12,
        ),
        const Divider(color: Colors.grey),
        for (Map<String, Object> opcion in opciones)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: UserOptionAccount(
              titleOption: opcion["title"] as String,
              optionDescription: opcion["description"] as String,
              leadingPage: opcion["leadingPage"] as Widget,
              index: opcion["index"] as int,
            ),
          ),
        const SizedBox(
          height: 40,
        ),
        BlocBuilder<MyBlocBtn, MyStateBtn>(
          builder: (context, state) {
            return MyButtonSubmit(
              onButtonPressed: () async {
                BlocProvider.of<MyBlocBtn>(context).fetchData();

                await SharedPreferences.getInstance().then((value) {
                  value.remove("phone");
                  BlocProvider.of<MyBlocBottomNavigationBar>(context).toPage(0);
                  BlocProvider.of<MyBlocBtn>(context).cancelFetch();
                  NavigationService().navigateToAndRemoveUntil(context, const SplashScreen());
                });
              },
              label: translation(context)!.logout,
              imagenIcon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          },
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

class UserOptionAccount extends StatefulWidget {
  const UserOptionAccount(
      {Key? key,
      required this.titleOption,
      required this.optionDescription,
      required this.leadingPage,
      required this.index})
      : super(key: key);

  final String titleOption;
  final String optionDescription;
  final Widget leadingPage;
  final int index;
  @override
  State<UserOptionAccount> createState() => _UserOptionAccountState();
}

class _UserOptionAccountState extends State<UserOptionAccount> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        child:
            const Icon(Icons.arrow_circle_right_rounded, color: Colors.white),
      ),
      title: TitleComponent(widget.titleOption).render(),
      subtitle: ParagraphComponent(widget.optionDescription).render(),
      onTap: () {
        if (widget.index != 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.leadingPage,
            ),
          );
        } else {
          //Uri url = Uri.parse('https://play.google.com/store/apps/details?id=tu.package.id');
          Uri url = Uri.parse(
              'https://play.google.com/store/apps/details?id=com.vistony.qrcash.qrcash&hl=en-US&ah=aIPT7nCM9pHUZC2Kxhv-qU2QALI');
          _launchInBrowser(url);
        }
      },
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
