import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';

import '../../../data/dao/local/preferences/preferences_auth_dao.dart';
import '../../../domain/constants/language_constants.dart';
import '../../features/bloc/status/bloc_status_text.dart';
import 'validator_handler.dart';

class HandlerUserLogged extends ValidatorHandler {
  @override
  Future<void> handleRequest(BuildContext context) async {
    final blocStatusText = BlocProvider.of<BlocStatusText>(context);
    await Future.delayed(const Duration(milliseconds: 600));
    await checkUserLogged().then((value){
      if (value!='') {
        blocStatusText.changeStatus(translation(context)!.searching_network);
        blocStatusText.changeUserLogged(true);
        UseCaseAuth(isOnline: false).login(value, '').then((value){
          if(value=='success') {


            handleNext(context);
          }else{

          }
        });
      } else {
        blocStatusText.changeStatus(translation(context)!.searching_network);
        blocStatusText.changeUserLogged(false);
        handleNext(context);
      }
    });

  }

  Future<String> checkUserLogged() async {
    String? phoneNumber =  await PreferencesAuthDao().loadString('phone');

    return phoneNumber??'';
  }







}
