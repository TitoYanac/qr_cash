

abstract class BusinessDao {
  Future<List<dynamic>> loadVideos(String path, String jsonString);

  Future<List<dynamic>> loadContacts(String path, String jsonString);

  Future<List<dynamic>> loadBanks(String path, String jsonString);

  Future<Map<String, dynamic>> registerQR(String path, String jsonString);

  Future<List<dynamic>> registerListQR(String path, String jsonString);

  Future<List<dynamic>> scanQrCamera(String path, String jsonString);

  Future<List<dynamic>> scanQrManual(String path, String jsonString);

  Future<List<dynamic>> loadDashboardToday(String path, String jsonString);

  Future<List<dynamic>> loadDashboardTotal(String path, String jsonString);

  Future<List<dynamic>> loadListTotalQR(String path, String jsonString);
  Future<List<dynamic>> loadAcceptedTotalQR(String path, String jsonString);
  Future<List<dynamic>> loadPendingTotalQR(String path, String jsonString);
  Future<List<dynamic>> loadRejectedTotalQR(String path, String jsonString);

  Future<Map<String,dynamic>> requestTransfer(String path, String jsonbody);

  Future<Map<String,dynamic>> getResumeStatusPay(String path, String jsonbody);

  Future<Map<String,dynamic>> getStatusAPay(String path, String jsonbody);
}
