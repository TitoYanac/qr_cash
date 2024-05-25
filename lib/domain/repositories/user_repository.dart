import '../../data/dao/user_dao.dart';
import '../../data/entities/bank_entity.dart';
import '../../data/entities/person_entity.dart';
import '../models/user/user.dart';

abstract class UserRepository {
  void setStrategyUserDao(UserDao dao);

  Future<String> loadUserData();

  Future<String> updateUser(User user, PersonEntity person);

  Future<String> updateBank(User user, BankEntity formBank);

  Future<String> updateUserImage(User user, String imageBase64);

  Future<String> validateISFC(String isfc);
}
