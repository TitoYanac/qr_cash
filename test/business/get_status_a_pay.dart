import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';
import 'package:qrcash/domain/usecases/use_case_business.dart';

void main(){
  group('getStatusAPay',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String password = 'q123456@';
      await UseCaseAuth(isOnline: true).login(phoneNumber, password).then((value){
        print(value);
        print(User.getInstance().toFullJson());
      });
      String line = '5';
      await UseCaseBusiness(isOnline: true).getStatusAPay(line).then((value){
        print(value?.toStatusPayEntity().toJson());
      });
    });
  });
}