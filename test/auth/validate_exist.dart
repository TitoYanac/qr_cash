import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';

void main(){
  group('validateExist',(){
    test('online', () async{
      String phoneNumber = '9326882107';
      await UseCaseAuth(isOnline: true).sendOtp(phoneNumber).then((value){
        print(value);
      });
    });
  });
}