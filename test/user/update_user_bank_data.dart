import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/models/user/bank.dart';
import 'package:qrcash/domain/models/user/user.dart';
import 'package:qrcash/domain/usecases/use_case_auth.dart';
import 'package:qrcash/domain/usecases/use_case_user.dart';

void main(){
  group('uploadbBank',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String password = 'q123456@';
      await UseCaseAuth(isOnline: true).login(phoneNumber, password).then((value){
        print("$value auth");
      });
      print("--------------------------------");
      await UseCaseUser(isOnline: true).loadGeneralData().then((value){
        print("$value load general data");
        print(User.getInstance());
      });
      print("--------------------------------");
      Bank bankdata = Bank(
        uSwift: '6546511',
        uIFSCCode: '6548498',
        uBenfName: 'Tito Jesús Yánac Saldaña',
        uBank: 'SBI',
        uAccount: '64898765489'
      );

      await UseCaseUser(isOnline: true).updateBankData(bankdata).then((value){
        print("$value update bank data");
        print(User.getInstance());
      });

    });
  });
}