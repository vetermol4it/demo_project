import 'package:demo_project/data/utils/storage_util/storage_util.dart';
import 'package:demo_project/domain/repository/auth_repository.dart';
import 'package:demo_project/domain/models/user/user.dart';

class AuthDataRepository implements AuthRepository {
  final StorageUtil _storageUtil;

  AuthDataRepository(this._storageUtil);

  @override
  Future<bool> register(User user) async {
    final registeredUsers = await _storageUtil.loadUsers();
    if (registeredUsers.contains(user)){
      throw RegisterError.userExist;
    }
    await _storageUtil.addUser(user);
    return true;
  }

  @override
  Future<User> signIn(String login, String password) async {
    final registeredUsers = await _storageUtil.loadUsers();
    final user = registeredUsers.firstWhere(
      (element) => element.login == login && element.password == password,
      orElse: () => throw AuthError.userNotExist,
    );
    return user;
  }
}

enum RegisterError{userExist, invalid}
enum AuthError{userNotExist, invalid}