import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:demo_project/presentation/constants/routes.dart';
import 'package:demo_project/presentation/pages/create_account_page/create_account_page.dart';
import 'package:demo_project/presentation/pages/home_page/home_page.dart';
import 'package:demo_project/presentation/pages/login_page/login_page.dart';

class AppRouter {

  AppRouter();

  final router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: Routes.rootRoute,
        path: '/',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        name: Routes.loginRoute,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: Routes.createAccountRoute,
        path: '/create-account',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const CreateAccountPage(),
        ),
      ),
    ],
  );

}