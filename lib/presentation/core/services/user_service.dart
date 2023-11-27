import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_auth/native_auth.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/models/user/bank.dart';
import '../../../domain/models/user/person.dart';
import '../../../domain/usecases/use_case_user.dart';
import '../../features/bloc/status/bloc_status_text.dart';
import 'util.dart';

class UserService extends Util {
  UserService(super.context);

  Future<bool> loadGeneralData() async {
    BlocStatusText blockStatusText = BlocProvider.of<BlocStatusText>(context);
    bool isOnline = await checkConnectivity();
    String response = await UseCaseUser(isOnline: isOnline).loadGeneralData();
    if (response != 'success') {
      blockStatusText.changeUserLogged(false);
      return false;
    }
    blockStatusText.changeUserLogged(true);
    return true;
  }

  Future<void> updateUserData(Person person) async {
    String changesSaved = translation(context)!.changes_save_successfully;
    String errorUpdating = translation(context)!.error_updating_user_data;

    bool isOnline = await checkConnectivity();

    String isAllOk = isValidPerfilForm(person.name, person.uPan);
    if(isAllOk != 'true'){
      ErrorResponseService(isAllOk);
      return;
    }
    String responseUpdate = await UseCaseUser(isOnline: isOnline).updateUserData(person);
    if (responseUpdate != 'success') {
      ErrorResponseService(errorUpdating);
      return;
    }
    SuccesfulResponseService(changesSaved);

  }



  Future<bool> updateBankData(Bank formBank, bool isAgreed) async {
    String acceptTerms = translation(context)!.accept_the_terms;
    String userAuth = translation(context)!.auth_in_to_unlock_your_device;
    String changesSaved = translation(context)!.changes_save_successfully;
    String errorUpdating = translation(context)!.error_updating_bank_data;

    final response = await Auth.isAuthenticate();
    print(response.isAuthenticated);
    if(!response.isAuthenticated){
      ErrorResponseService(userAuth);
      return false;
    }
    if(!isAgreed){
      ErrorResponseService(acceptTerms);
      return false;
    }

    bool isOnline = await checkConnectivity();
    String responseUpdate = await UseCaseUser(isOnline: isOnline).updateBankData(formBank);
    if (responseUpdate != 'success') {
      ErrorResponseService(errorUpdating);
      return false;
    }
    SuccesfulResponseService(changesSaved);
    return true;

  }

  Future<bool> updateUserImage(String imageBase64,String phoneNumber)  async {
    String changesSaved = translation(context)!.changes_save_successfully;
    String somethingWentWrong = translation(context)!.something_went_wrong;
    String noChanges = translation(context)!.no_changes_ocurred;
    bool isOnline = await checkConnectivity();

    if(imageBase64==''){
      ErrorResponseService(noChanges);
      return false;
    }
    String response = await UseCaseUser(isOnline: isOnline).updateUserImage(imageBase64);
    if (response != 'success') {
      ErrorResponseService(somethingWentWrong);
      return false;
    }
    SuccesfulResponseService(changesSaved);
    return true;

  }

}
