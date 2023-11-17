import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/models/user/person.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';
import 'package:qrcash/domain/usecases/use_case_user.dart';

void main(){
  group('uploadPerson',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String password = 'q123456@';
      await UseCaseAuth(isOnline: true).login(phoneNumber, password).then((value){
        print(value);
      });
      print("--------------------------------");
      await UseCaseUser(isOnline: true).loadGeneralData().then((value){
        print(value);
        print(User.getInstance());
      });
      print("--------------------------------");
      Person person = Person(
        code: '9326882326',
        language: 'en',
        name: 'tito jesús Yánac Saldaña',
        uIDUPI: '6549868',
        uMobileID: '9326882326',
        uPan: 'ABCTY1234K',
        uPinCode: '56856856t',
        uVehicle: 'bus'
      );

      await UseCaseUser(isOnline: true).updateUserData(person).then((value){
        print(value);
        print(User.getInstance());
      });

    });
  });
}