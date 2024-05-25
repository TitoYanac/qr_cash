import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/constants/language_constants.dart';

class HomeDisclaimerBody extends StatefulWidget {
  const HomeDisclaimerBody({super.key});

  @override
  State<HomeDisclaimerBody> createState() => _HomeDisclaimerBodyState();
}

class _HomeDisclaimerBodyState extends State<HomeDisclaimerBody> {
  @override
  Widget build(BuildContext context) {
    Widget iconCard = Expanded(
      flex: 1,
      child: Container(
        height: 120,
        color: Theme.of(context).colorScheme.primary,
        alignment: Alignment.center,
        child: const Icon(
          Icons.warning,
          color: Colors.amber,
        ),
      ),
    );
    Widget textCard = Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          translation(context)!
              .t_c_b_you_are_responsible_for_configuring_your_information_technology_computer_programmes_and_platform_to_access_the_qr_save_scan_app_you_should_use_your_virus_protection_software,
          style: GoogleFonts.roboto(
            textStyle:
            const TextStyle(overflow: TextOverflow.ellipsis),
          ),
          maxLines: 3,
        ),
      ),
    );
    Decoration decorationCard = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius:  3,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
    BoxConstraints boxConstraints = const BoxConstraints(
      maxWidth: 400.0,
      minHeight: 100.0,
    );
    double widthCard = MediaQuery.of(context).size.width * 0.92;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          width: widthCard,
          constraints: boxConstraints,
          decoration: decorationCard,
          child: Row(
            children: [
              iconCard,
              textCard,
            ],
          ),
        ),
      ],
    );
  }
}
