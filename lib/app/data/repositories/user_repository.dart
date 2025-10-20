import 'package:corehive_store/app/data/models/user_model.dart';
import 'package:corehive_store/app/config/clients/storage/storage_client.dart';

class UserRepository {
  final StorageClient _storageClient = StorageClient();

  Future<void> saveUser(UserModel user) async {
    await _storageClient.saveUserModel(user.toJson());
  }

  Future<void> removeUser() async {
    await _storageClient.removeUserModel();
  }

  UserModel? getUser() {
    final json = _storageClient.getUserModel();
    if (json != null) {
      return UserModel.fromJson(json);
    }
    return null;
  }
}
