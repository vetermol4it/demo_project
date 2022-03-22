import 'package:hive_flutter/hive_flutter.dart';

import 'package:demo_project/domain/models/user/user.dart';

class StorageUtil {
  Box? _usersBox;

  StorageUtil(){
    _init();
  }

  Future<void> _init() async {
    if (_usersBox == null) {
      await Hive.initFlutter();
      _usersBox = await Hive.openBox('users');
    }
  }

  Future<List<User>> loadUsers() async {
    await _init();
    final List<User> result = [];
    for(Map userJson in _usersBox!.values) {
      result.add(User.fromJson(Map<String, dynamic>.from(userJson)));
    }
    return result;
  }

  Future<void> addUser(User user) async {
    await _init();
    _usersBox!.add(user.toJson());
  }
}