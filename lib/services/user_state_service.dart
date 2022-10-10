import '../models/user.dart';
import 'database_service.dart';
import 'local_storage_service.dart';

class UserStateUpdateService {
  static Future<void> updateUser(Users user, bool shouldUpdateOnline) async {
    LocalStorageService.setUser(user);
    if (shouldUpdateOnline) {
      await DatabaseService.updateUserData(user);
    }
  }
}
