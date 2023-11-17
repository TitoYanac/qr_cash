
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/data/dao/remote/api/api_auth_dao.dart';

import '../../../domain/constants/language_constants.dart';
import '../../features/auth/pages/auth_no_internet_screen.dart';
import '../../features/auth/pages/user_human_validator_page.dart';
import '../../features/bloc/status/bloc_status_text.dart';
import '../services/navigation_service.dart';
import 'validator_handler.dart';

class HandlerServerConnection extends ValidatorHandler {
  @override
  Future<void> handleRequest(BuildContext context) async {
    final blocStatusText = BlocProvider.of<BlocStatusText>(context);
    await ApiAuthDao().checkServerConnectivity().then((value){

      Future.delayed(const Duration(milliseconds: 400),(){
        blocStatusText.changeStatusOnline(value);
        if (value) {
          blocStatusText.changeStatus(translation(context)!.server_connection_successful);
          NavigationService().navigateToAndRemoveUntil(context,const UserHumanValidatorPage());
        } else {
          blocStatusText.changeStatus(translation(context)!.unable_to_connect_server);
          (blocStatusText.state.userLogged)?
          NavigationService().navigateToAndRemoveUntil(context,const UserHumanValidatorPage())
              : NavigationService().navigateToAndRemoveUntil(context,const AuthNoInternetScreen());
          }
      });
    });

  }


}
