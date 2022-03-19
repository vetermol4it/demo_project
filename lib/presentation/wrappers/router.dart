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
        name: rootRoute,
        path: '/',
        redirect: (state) =>
            state.namedLocation(homeRoute, params: {'tab': 'search'}),
      ),
      GoRoute(
        name: homeRoute,
        path: '/home/:tab(search|profile)',
        pageBuilder: (context, state) {
          final tab = state.params['tab']!;
          return MaterialPage<void>(
            key: state.pageKey,
            child: HomePage(tab: tab),
          );
        },
      ),
      GoRoute(
        name: searchRoute,
        path: '/search',
        redirect: (state) =>
            state.namedLocation(homeRoute, params: {'tab': 'search'}),
      ),
      GoRoute(
        name: profileRoute,
        path: '/profile',
        redirect: (state) =>
            state.namedLocation(homeRoute, params: {'tab': 'profile'}),
      ),
      GoRoute(
        name: loginRoute,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: createAccountRoute,
        path: '/create-account',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const CreateAccountPage(),
        ),
      ),
    ],
  );

}