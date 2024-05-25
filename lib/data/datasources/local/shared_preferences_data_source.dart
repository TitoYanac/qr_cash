import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/dashboard/qr_response_manager.dart';
import '../datasource.dart';

class SharedPreferencesDataSource implements Datasource {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }


  Future<QrResponseManager?> getQrManagerFromSharedPreferences(
      String key) async {
    final jsonString = _prefs?.getString(key);
    if (jsonString != null) {
      return QrResponseManager.fromJson(jsonDecode(jsonString));
    }
    return QrResponseManager(data: []);
  }

  Future<bool> saveString(String key, String value) async {
    if (_prefs == null) {
      await init();
    }
    try {
      await _prefs!.setString(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> loadString(String key) async {
    if (_prefs == null) {
      await init();
    }
    return _prefs?.getString(key) ?? '';
  }

  Future<void> dropKey(String key) async {
    if (_prefs == null) {
      await init();
    }
    _prefs?.remove(key);
  }

  @override
  Future<http.Response> createListData(
      String locationData, String jsonBody) async {
    return await postData(locationData, jsonBody);
  }

  @override
  Future<http.Response> createRowData(
      String locationData, String jsonBody) async {
    return await postData(locationData, jsonBody);
  }

  @override
  Future<http.Response> deleteListData(
      String locationData, String jsonBody) async {
    const responseBody = 'Contenido de la respuesta';
    const statusCode = 200; // Código de estado HTTP (200 para éxito)
    final response = http.Response(responseBody, statusCode);
    return response;
  }

  @override
  Future<http.Response> deleteRowData(
      String locationData, String jsonBody) async {
    const responseBody = 'Contenido de la respuesta';
    const statusCode = 200; // Código de estado HTTP (200 para éxito)
    final response = http.Response(responseBody, statusCode);
    return response;
  }

  @override
  Future<http.Response> readListData(
      String locationData, String jsonBody) async {
    return await fetchData(locationData, '');
  }

  @override
  Future<http.Response> readRowData(
      String locationData, String key) async {

    return await fetchData(locationData, key);
  }

  @override
  Future<http.Response> updateListData(
      String locationData, String jsonBody) async {
    const responseBody = 'Contenido de la respuesta';
    const statusCode = 200; // Código de estado HTTP (200 para éxito)
    final response = http.Response(responseBody, statusCode);
    return response;
  }

  @override
  Future<http.Response> updateRowData(
      String locationData, String jsonBody) async {
    const responseBody = 'Contenido de la respuesta';
    const statusCode = 200; // Código de estado HTTP (200 para éxito)
    final response = http.Response(responseBody, statusCode);
    return response;
  }

  Future<http.Response> fetchData(String locationData, String key) async {


    final jsonData = await loadString('$locationData$key');


    final statusCode = (jsonData == '') ? 404 : 200;
    final response = http.Response(jsonData, statusCode);
    return response;
  }

  Future<http.Response> postData(String locationData, String jsonBody) {
    return saveString(locationData, jsonBody).then((success) {
      final statusCode = success ? 200 : 404;
      final response = http.Response(jsonBody, statusCode);
      return response;
    });
  }


  SharedPreferences getPreferences() {
    return _prefs!;
  }


}
