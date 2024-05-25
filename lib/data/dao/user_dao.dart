abstract class UserDao {
  Future<Map<String, dynamic>> loadUserData(String path, String jsonString);

  Future<Map<String, dynamic>> updateUser(String path, String jsonString);

  Future<Map<String, dynamic>> updateBank(String path, String jsonString);

  Future<Map<String, dynamic>> validateISFC(String path, String jsonString);

  Future<Map<String, dynamic>> updateUserImage(String path, String jsonString);
}
