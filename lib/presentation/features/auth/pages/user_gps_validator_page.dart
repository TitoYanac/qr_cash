import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../atoms/label_link_component.dart';
import '../../../atoms/paragraph_component.dart';
import '../../../atoms/title_component.dart';
import '../../../core/validators/handler_gps_connection.dart';
import '../../../core/validators/handler_internet_connection.dart';
import '../../../core/validators/validator_handler.dart';
import '../../bloc/status/bloc_status_text.dart';
import '../../bloc/status/bloc_status_text_state.dart';

class UserGpsValidator extends StatefulWidget {
  const UserGpsValidator({Key? key}) : super(key: key);

  @override
  State<UserGpsValidator> createState() => _UserGpsValidatorState();
}

class _UserGpsValidatorState extends State<UserGpsValidator> {

  @override
  void initState() {
    ValidatorHandler validatorInternet = HandlerInternetConnection();
    ValidatorHandler validatorGps = HandlerGPSConnection();
    validatorInternet.setNextHandler(validatorGps);
    validatorInternet.handleRequest(context);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset("assets/icons/gps_icon.png",width: MediaQuery.of(context).size.width*0.2,),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 44),
            child: TitleComponent(translation(context)!.checking_gps_version).render()),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: LinearProgressIndicator(
              value: 20,
              backgroundColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 12),child: ParagraphComponent(translation(context)!.loading_data).render()),
          BlocBuilder<BlocStatusText, StatusTextState>(
            bloc: BlocProvider.of<BlocStatusText>(context),
            builder: (context, StatusTextState state) {
              return LabelLinkComponent(state.statusText).render();
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/icons/detalle.png",width: MediaQuery.of(context).size.width*0.5,),
            ],
          ),
        ],
      ),
    );
  }
}
