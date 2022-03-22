import 'package:demo_project/domain/models/user/user.dart';

abstract class AuthRepository {
  Future<User> signIn(String login, String password,);
  Future<void> signOut();
  Future<bool> register(User user);
  Future<User?> getLastAuthenticatedUser();
}