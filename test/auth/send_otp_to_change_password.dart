import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';

void main(){
  group('sendOtpTochangePass',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      await UseCaseAuth(isOnline: true).sendForgotPassOtp(phoneNumber).then((value){
        print("el value : $value");
      });
    });
  });
}