import '../../data/dao/user_dao.dart';
import '../../data/dao/local/preferences/preferences_user_dao.dart';
import '../../data/dao/remote/api/api_user_dao.dart';
import '../../data/entities/bank_entity.dart';
import '../../data/entities/person_entity.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../models/user/bank.dart';
import '../models/user/person.dart';
import '../models/user/user.dart';
import '../repositories/user_repository.dart';

class UseCaseUser {
  final UserRepository userRepository = UserRepositoryImpl();
  final bool isOnline;

  UseCaseUser({required this.isOnline}) {
    UserDao userDao;
    if (isOnline) {
      userDao = ApiUserDao();

      userRepository.setStrategyUserDao(userDao);
    } else {
      userDao = PreferencesUserDao();

      userRepository.setStrategyUserDao(userDao);
    }
  }

  Future<String> loadGeneralData() async {
    return await userRepository.loadUserData();
  }

  Future<String> updateUserData(Person person) async{
    User user = User.getInstance();
    PersonEntity personEntity = person.toPersonEntity();
    return await userRepository.updateUser(user, personEntity);
  }

  Future<String> updateBankData(Bank formBank) async{
    User user = User.getInstance();
    BankEntity bankEntity = formBank.toBankEntity();
    return await userRepository.updateBank(user, bankEntity);
  }

  Future<String> updateUserImage(String imageBase64) async{
    User user = User.getInstance();
    return await userRepository.updateUserImage(user, imageBase64);
  }

  Future<String> validateISFC(String isfc) async{
    return await userRepository.validateISFC(isfc);
  }


}
