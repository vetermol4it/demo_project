import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:demo_project/presentation/wrappers/application.dart';
import 'package:demo_project/presentation/wrappers/router.dart';

final locator = GetIt.instance;

void main() {
  _registerDependencies();
  runApp(const Application());
}


void _registerDependencies(){
  locator.registerLazySingleton<AppRouter>(() => AppRouter());

}