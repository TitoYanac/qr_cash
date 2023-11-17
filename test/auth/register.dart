import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';

void main(){
  group('login',(){
    test('online', () async{
      String phoneNumber = '9326882106';
      String password = 'q123456@';
      await UseCaseAuth(isOnline: true).createUser(phoneNumber, password).then((value){
        print(value);
      });
    });
  });
}