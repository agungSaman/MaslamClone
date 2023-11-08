import '../../../shared/user/data/models/user.dart';
import '../../../shared/user/data/models/user_requirement.dart';

abstract class AuthDatasource {
  Future<User?> signIn(
      String username, String password, String token, String deviceId);

  Future<String> signUp(String? nama, String? username, String telepon,
      String password, String token, String deviceId);

  Future<User?> signGmail(
      String? nama, String? username, String token, String deviceId);

  Future<UserRequirement?> getDataWarga(String? userId);

  Future<String?> getToken();

  User? getUserInfo();

  void clearUserInfo();

  void saveUserInfo(User? user);

  Future<bool> isUserSignedIn();
}
