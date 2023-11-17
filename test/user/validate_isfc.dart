
import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/usecases/use_case_user.dart';

void main(){
  group('validateISFC',(){
    test('online', () async{
      String codeISFC = 'KJSB0KUB254';
      await UseCaseUser(isOnline: true).validateISFC(codeISFC).then((value){
        print(value);
      });

    });
  });
}