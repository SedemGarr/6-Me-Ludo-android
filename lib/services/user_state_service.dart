import '../models/user.dart';
import 'database_service.dart';
import 'local_storage_service.dart';

class UserStateUpdateService {
  static void updateUser(Users user, bool shouldUpdateOnline) {
    LocalStorageService.setUser(user);
    if (shouldUpdateOnline) {
      DatabaseService.updateUserData(user);
    }
  }
}
