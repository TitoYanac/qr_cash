abstract class AuthDao {
  Future<Map<String,dynamic>> login(String path, String jsonString);

  Future<Map<String,dynamic>> createNewUser(String path, String jsonString);

  Future<Map<String,dynamic>> sendOTP(String path, String jsonString);

  Future<Map<String,dynamic>> validateOtp(String path, String jsonString);

  Future<Map<String,dynamic>> sendForgotPassOtp(String path, String jsonString);

  Future<Map<String,dynamic>> changePassWord(String path, String jsonString);
}
