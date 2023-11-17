
import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/models/business/business.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';
import 'package:qrcash/domain/usecases/use_case_business.dart';

void main(){
  group('getDashboardTotal',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String password = 'q123456@';
      await UseCaseAuth(isOnline: true).login(phoneNumber, password).then((value){
        print(value);
        print(User.getInstance().toFullJson());
      });
      await UseCaseBusiness(isOnline: true).loadDashboardTotal().then((value){
        print(value);
        print(Business.getInstance().dashboardTotal!.entry[0].toJson());
        print(Business.getInstance().dashboardTotal!.entry[1].toJson());
      });
    });
  });
}