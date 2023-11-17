import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';
import 'package:qrcash/domain/usecases/use_case_business.dart';

void main(){
  group('getResumeStatusPay',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String password = 'q123456@';
      await UseCaseAuth(isOnline: true).login(phoneNumber, password).then((value){
        print(value);
        print(User.getInstance().toFullJson());
      });
      await UseCaseBusiness(isOnline: true).getResumeStatusPay().then((value){
        print(value?.toStatusPayEntity().toJson());
      });
    });
  });
}