import 'package:flutter/cupertino.dart';
import 'package:native_auth/native_auth.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/models/user/bank.dart';
import '../../../domain/models/user/person.dart';
import '../../../domain/usecases/use_case_user.dart';

import 'util.dart';

class UserService extends Util {
  UserService(super.context);

  Future<bool> loadGeneralData() async {
    bool isOnline = await checkConnectivity();
    String response = await UseCaseUser(isOnline: isOnline).loadGeneralData();
    return (response == 'success');
  }

  Future<bool> updateUserData(Person person) async {
    String changesSaved = translation(context)!.changes_save_successfully;
    String errorUpdating = translation(context)!.error_updating_user_data;

    bool isOnline = await checkConnectivity();

    String isAllOk = isValidPerfilForm(person.name, person.uPan);
    if(isAllOk != 'true'){
      errorResponseService(isAllOk);
      return false;
    }
    String responseUpdate = await UseCaseUser(isOnline: isOnline).updateUserData(person);
    debugPrint("responseUpdate: $responseUpdate");
    if (responseUpdate != 'success') {
      errorResponseService(errorUpdating);
      return false;
    }
    succesfulResponseService(changesSaved);
    return true;
  }

  Future<bool> updateBankData(Bank? formBank) async {
    String acceptTerms = translation(context)!.accept_the_terms;
    String userAuth = translation(context)!.auth_in_to_unlock_your_device;
    String changesSaved = translation(context)!.changes_save_successfully;
    String errorUpdating = translation(context)!.error_updating_bank_data;
    if (formBank == null) {
      errorResponseService(errorUpdating);
      return false;
    }

    bool isAllOk = isValidBankForm(formBank);

    final response = await Auth.isAuthenticate();
    //print(response.isAuthenticated);
    if(!response.isAuthenticated){
      errorResponseService(userAuth);
      return false;
    }
    if(!isAllOk){
      errorResponseService(acceptTerms);
      return false;
    }

    bool isOnline = await checkConnectivity();
    String responseUpdate = await UseCaseUser(isOnline: isOnline).updateBankData(formBank);
    if (responseUpdate != 'success') {
      errorResponseService(errorUpdating);
      return false;
    }
    succesfulResponseService(changesSaved);
    return true;

  }

  Future<bool> updateUserImage(String imageBase64,String phoneNumber)  async {
    String changesSaved = translation(context)!.changes_save_successfully;
    String somethingWentWrong = translation(context)!.something_went_wrong;
    String noChanges = translation(context)!.no_changes_ocurred;
    bool isOnline = await checkConnectivity();

    if(imageBase64==''){
      errorResponseService(noChanges);
      return false;
    }
    String response = await UseCaseUser(isOnline: isOnline).updateUserImage(imageBase64);
    if (response != 'success') {
      errorResponseService(somethingWentWrong);
      return false;
    }
    succesfulResponseService(changesSaved);
    return true;

  }

  bool isValidBankForm(Bank formBank) {
    return true;
  }

}
