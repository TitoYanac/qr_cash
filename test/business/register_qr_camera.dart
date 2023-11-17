
import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';

void main(){
  group('registerQRCamera',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String password = 'q123456@';
      await UseCaseAuth(isOnline: true).login(phoneNumber, password).then((value){
        print(value);
        print(User.getInstance().toFullJson());
      });
      String qr = '39EC425E-351A-4685-A5AB-A901FDAA8BAC';
/*
      UseCaseBusiness(isOnline: true).registerQr(qr).then((value){
        print(value);

      });*/

    });
  });
}