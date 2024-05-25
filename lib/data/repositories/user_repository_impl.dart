import 'dart:convert';

import '../../domain/models/user/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../dao/local/preferences/preferences_auth_dao.dart';
import '../dao/local/preferences/preferences_user_dao.dart';
import '../dao/user_dao.dart';
import '../entities/bank_entity.dart';
import '../entities/person_entity.dart';
import '../entities/user_entity.dart';

class UserRepositoryImpl implements UserRepository {
  UserDao? dao;

  @override
  void setStrategyUserDao(UserDao dao) {
    this.dao = dao;
  }

  @override
  Future<String> loadUserData () async {
    try {
      final String phone = await PreferencesAuthDao().loadString('phone');
      final String jsonbody = jsonEncode({"mobileID": phone});
      final Map<String,dynamic> responseData = await dao!.loadUserData('loadGeneralData', jsonbody);

      if ("${responseData['Code']??''}"== phone) {
        await UserEntity().saveModelFromApiData(responseData).then((value) {
          PreferencesUserDao().createRowData("user$phone", value.toFullJson());
          PreferencesUserDao().createRowData("phone", phone);
        });

        return 'success';
      }else{
        return responseData['Message'];
      }
    } catch (e) {
      //await PreferencesUserDao().loadUserData('loadGeneralData', phone);
      return 'Connection failed';
    }
  }

  @override
  Future<String> updateUser(User user, PersonEntity personEntity) async {
    try {
      final String jsonbody = personEntity.toJson();
      final responseData = await dao!.updateUser('updateGeneralData', jsonbody);
      if (responseData['Message'] == 'success') {
        user.personData = personEntity.toPerson();
        PreferencesAuthDao().createRowData('user${user.personData!.uMobileID}', user.toFullJson());
      }
      return responseData['Message'];
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> updateBank(User user, BankEntity bankEntity) async {
    try {
      final String jsonbody = bankEntity.toJson();
      final responseData = await dao!.updateBank('updateUserBankData', jsonbody);
      if (responseData['Message'] == 'success') {
        user.bankData = bankEntity.toBank();
        PreferencesAuthDao().createRowData('user${user.personData!.uMobileID}', user.toFullJson());
      }
      return responseData['Message'];
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> updateUserImage(User user, String imageBase64) async {
    try {
      final String jsonbody = jsonEncode({"code": user.personData!.uMobileID, "imagen": imageBase64});
      final responseData = await dao!.updateUserImage('updateImageUser', jsonbody);

      if (responseData['Message'] == 'success') {
        await loadUserData().then((value) => responseData['Message'] == 'success');
      }
      return responseData['Message'];
    } catch (e) {
      return 'Connection failed';
    }
  }

  @override
  Future<String> validateISFC(String isfc) async {
    try {
      final String jsonbody = jsonEncode({"code": isfc});
      final responseData = await dao!.validateISFC('validateIFSC', jsonbody);
      return jsonEncode(responseData);
    } catch (e) {
      return 'Connection failed';
    }
  }
}
