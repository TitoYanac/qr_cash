
import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';

void main(){
  group('registerQRManual',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String password = 'q123456@';
      await UseCaseAuth(isOnline: true).login(phoneNumber, password).then((value){
        print(value);
        print(User.getInstance().toFullJson());

      });
      String qr = 'L0PW3E22VUFE';
User user = User.getInstance();
print(user.toFullJson());/*
    UseCaseBusiness(isOnline: true).registerQrManual(qr).then((value){
        print(value);
      });*/

    });
  });
}