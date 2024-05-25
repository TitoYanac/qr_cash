import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/constants/language_constants.dart';
import '../../../../widgets/atoms/text_atom.dart';
import '../../bloc/bloc_business.dart';

class TitlePaymentPopUp extends StatefulWidget {
  const TitlePaymentPopUp({super.key});

  @override
  State<TitlePaymentPopUp> createState() => _TitlePaymentPopUpState();
}

class _TitlePaymentPopUpState extends State<TitlePaymentPopUp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<BlocBusiness, BlocBusinessState>(
            builder: (context, state) {
              return TextAtom(
                text: "${translation(context)!.available_balance}: ${state.loaded}",
                align: TextAlign.center,
                size: 18.0,
                color: Theme.of(context).colorScheme.primary,
              );
            }),
      ],
    );
  }
}
