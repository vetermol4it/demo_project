import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:demo_project/domain/models/user/user.dart';

class StorageUtil {
  Box? _usersBox;
  final _secureStorage = const FlutterSecureStorage();

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

  Future<User?> loadLastAuthenticatedUser() async {
    final encodedJson = await _secureStorage.read(key: 'user');
    if (encodedJson == null) {
      return null;
    } else {
      return User.fromJson(jsonDecode(encodedJson));
    }
  }

  Future<void> saveLastAuthenticatedUser(User? user) {
    if (user == null) {
      return _secureStorage.delete(key: 'user');
    } else {
      return _secureStorage.write(
        key: 'user',
        value: jsonEncode(user.toJson()),
      );
    }
  }
}