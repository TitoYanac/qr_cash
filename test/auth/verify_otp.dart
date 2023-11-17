import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';

void main(){
  group('verifyOtp',(){
    test('online', () async{
      String codeOtp = '888811';
      await UseCaseAuth(isOnline: true).validateOtp(codeOtp).then((value){
        print(value);
      });
    });
  });
}