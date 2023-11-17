
import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/usecases/use_case_business.dart';

void main(){
  group('scanQR',(){
    test('online', () async{
      String phoneNumber = '9326882326';
      String codeCamera = '2851F636-E610-44FA-B57F-81DC1A8A694A';
      await UseCaseBusiness(isOnline: true).validateQrCodeCamera(codeCamera).then((value){
        print(value?.toJson());
      });

    });
  });
}