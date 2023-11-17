import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/presentation/core/services/user_service.dart';

import '../../../domain/constants/language_constants.dart';
import '../../features/auth/pages/auth_no_internet_screen.dart';
import '../../features/bloc/status/bloc_status_text.dart';
import '../services/navigation_service.dart';
import 'validator_handler.dart';

class HandlerInternetConnection extends ValidatorHandler {
  @override
  Future<void> handleRequest(BuildContext context) async {
    final blocStatusText = BlocProvider.of<BlocStatusText>(context);
    await Future.delayed(const Duration(milliseconds: 50));
    await checkConnectivity().then((value) {
      Future.delayed(const Duration(milliseconds: 50),(){
        if (value) {
          blocStatusText.changeStatus(translation(context)!.internet_connection_successful);
          //cargar usuario de api
        } else {
          blocStatusText.changeStatus(translation(context)!.network_error);
          //cargar usuario de sharedpreferences
        }
        UserService(context).loadGeneralData().then((value) {
          if (value) {
            blocStatusText.changeStatus(translation(context)!.user_data_loaded);
            handleNext(context);
          }else{
            NavigationService().navigateToAndRemoveUntil(context,const AuthNoInternetScreen());
          }
        });

      });

    });

  }
  Future<bool> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

}