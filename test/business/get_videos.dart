import 'package:flutter_test/flutter_test.dart';
import 'package:qrcash/domain/usecases/use_case_business.dart';

void main(){
  group('getVideos',(){
    test('online', () async{
      String result = await UseCaseBusiness(isOnline: true).loadVideos();
      print(result);
    });
  });
}