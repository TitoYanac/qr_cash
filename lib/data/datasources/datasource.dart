import 'package:http/http.dart' as http;

abstract class Datasource {
  Future<http.Response> createRowData(String locationData, String jsonBody);
  Future<http.Response> readRowData(String locationData, String jsonBody);
  Future<http.Response> updateRowData(String locationData, String jsonBody);
  Future<http.Response> deleteRowData(String locationData, String jsonBody);
  Future<http.Response> createListData(String locationData, String jsonBody);
  Future<http.Response> readListData(String locationData, String jsonBody);
  Future<http.Response> updateListData(String locationData, String jsonBody);
  Future<http.Response> deleteListData(String locationData, String jsonBody);
}