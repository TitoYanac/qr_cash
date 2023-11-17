import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/constants/language_constants.dart';
import '../../../domain/models/user/bank.dart';
import '../../../domain/models/user/person.dart';
import '../../../domain/usecases/use_case_user.dart';
import '../../features/bloc/status/bloc_status_text.dart';
import 'util.dart';

class UserService extends Util {
  bool isOnline = false;
  UserService(super.context) {
  isOnline = BlocProvider.of<BlocStatusText>(context).state.statusOnline;
  }

  Future<bool> loadGeneralData() async {
    return await UseCaseUser(isOnline: isOnline).loadGeneralData().then((value) {
      if (value == 'success') {
        BlocProvider.of<BlocStatusText>(context).changeUserLogged(true);
        return true;
      }else{
        BlocProvider.of<BlocStatusText>(context).changeUserLogged(false);
        return false;
      }
    });
  }

  Future<void> updateUserData(Person person) async {
    String isAllOk = isValidPerfilForm(person.name, person.uPan);
    if (isAllOk == 'true') {
      await UseCaseUser(isOnline: isOnline).updateUserData(person).then((value){
        if (value == 'success') {
          SuccesfulResponseService(translation(context)!.changes_save_successfully);
        } else {
          ErrorResponseService(translation(context)!.error_updating_user_data);
        }
      });

    } else {
      ErrorResponseService(isAllOk);
    }
  }



  Future<bool> updateBankData(Bank formBank, bool isAgreed) async {
    if(isAgreed){

      await UseCaseUser(isOnline: isOnline).updateBankData(formBank).then((value){
        if (value == 'success') {
          SuccesfulResponseService(translation(context)!.changes_save_successfully);
          return true;
        } else {
          ErrorResponseService(translation(context)!.error_updating_bank_data);
          return false;
        }
      });
      return false;

    }else{
      ErrorResponseService(translation(context)!.accept_the_terms);
      return false;
    }
  }

  Future<bool> updateUserImage(String imageBase64,String phoneNumber)  async {
    if(imageBase64!=''){

      await UseCaseUser(isOnline: isOnline).updateUserImage(imageBase64).then((value){
        if (value == 'success') {
          SuccesfulResponseService(translation(context)!.changes_save_successfully);
          return true;
        } else {
          ErrorResponseService(translation(context)!.something_went_wrong);
          return false;
        }
      });
      return false;
    }else{
      ErrorResponseService(translation(context)!.no_changes_ocurred);
      return false;
    }
  }

}
