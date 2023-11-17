
import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/usecases/use_case_business.dart';

void main(){
  group('scanQRManual',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String codeCamera = 'L0PW-3E22-VUFE';
      await UseCaseBusiness(isOnline: true).validateQrCodeManual(codeCamera).then((value){
        print(value?.toJson());
      });

    });
  });
}