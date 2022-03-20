import 'package:demo_project/domain/models/user/user.dart';

abstract class AuthRepository {
  Future<User> signIn(String login, String password,);
  Future<bool> register(User user);
}