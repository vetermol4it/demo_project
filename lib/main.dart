import 'package:demo_project/data/repository/auth_data_repository.dart';
import 'package:demo_project/data/repository/search_data_repository.dart';
import 'package:demo_project/data/utils/api_util/api_util.dart';
import 'package:demo_project/data/utils/storage_util/storage_util.dart';
import 'package:demo_project/domain/bloc/auth_bloc.dart';
import 'package:demo_project/domain/bloc/serach_bloc.dart';
import 'package:demo_project/domain/repository/auth_repository.dart';
import 'package:demo_project/domain/repository/search_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:demo_project/presentation/wrappers/application.dart';
import 'package:demo_project/presentation/wrappers/router.dart';
import 'package:logger/logger.dart';

final locator = GetIt.instance;

void main() {
  _registerDependencies();
  runApp(const Application());
}


void _registerDependencies() async {
  ///Router
  locator.registerLazySingleton<AuthNavigationState>(
    () => AuthNavigationState()
  );
  locator.registerLazySingleton<AppRouter>(() => AppRouter(locator.get()));

  ///Logger
  locator.registerLazySingleton<Logger>(() => Logger(level: Level.debug));

  ///Search
  locator.registerLazySingleton<SearchRepository>(
    () => SearchDataRepository(ApiUtil(Dio())),
  );
  locator.registerFactory<SearchBloc>(() => SearchBloc(locator.get()));

  ///Authorization
  locator.registerLazySingleton<AuthRepository>(
    () => AuthDataRepository(StorageUtil())
  );
  locator.registerLazySingleton(() => AuthBloc(locator.get()));
}