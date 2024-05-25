import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../datasource.dart';
import 'socket_service.dart';

abstract class ApiDatasource  implements Datasource {
  String? baseUrl;
  String? domain;

  final int port = 91;
  final SocketService _socketService = SocketService();

  ApiDatasource() {
    if(kDebugMode){
      domain = '192.168.254.20';
    }else{
      domain = '190.12.79.132';
    }
    debugPrint(domain);
    baseUrl = 'http://$domain:91/api/User';
    debugPrint(baseUrl);
  }
  Future<void> initializeConnection() async {
    await _socketService.connect(domain!, port);
  }

  Future<void> closeConnection() async {
    _socketService.close();
  }

  Future<bool> checkServerConnectivity() async {
    try {
      initializeConnection();
      await _socketService.connect(domain!, 91);
      closeConnection();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<http.Response> postSocket(String path, String jsonString) async {
    try {
      final request = 'POST /api/User$path HTTP/1.1\r\n'
          'Host: $domain:$port\r\n'
          'Content-Type: application/json\r\n'
          'Content-Length: ${jsonString.length}\r\n\r\n'
          '$jsonString';
      String response = await _socketService.sendRequest(request);
      return http.Response(response.split("\n").last, 200);
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> post(String path, String jsonString) async{
    final url = Uri.parse('$baseUrl$path');

    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(url, headers: headers, body: jsonString);
    return response;
  }

  @override
  Future<http.Response> createListData(String locationData, String jsonBody) {
    return post(locationData, jsonBody);
  }

  @override
  Future<http.Response> createRowData(String locationData, String jsonBody) {
    return post(locationData, jsonBody);
  }

  @override
  Future<http.Response> deleteListData(String locationData, String jsonBody) {
    return post(locationData, jsonBody);
  }

  @override
  Future<http.Response> deleteRowData(String locationData, String jsonBody) {
    return post(locationData, jsonBody);
  }

  @override
  Future<http.Response> readListData(String locationData, String jsonBody) {
    return post(locationData, jsonBody);
  }

  @override
  Future<http.Response> readRowData(String locationData, String jsonBody) {
    return post(locationData, jsonBody);
  }

  @override
  Future<http.Response> updateListData(String locationData, String jsonBody) {
    return post(locationData, jsonBody);
  }

  @override
  Future<http.Response> updateRowData(String locationData, String jsonBody) {
    return post(locationData, jsonBody);
  }

}
