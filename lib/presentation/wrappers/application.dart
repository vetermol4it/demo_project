import 'package:demo_project/presentation/wrappers/auth_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:demo_project/main.dart';
import 'package:demo_project/presentation/wrappers/router.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final router = locator.get<AppRouter>().router;
        return AuthWrapper(
          child: MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
          ),
        );
      }
    );
  }
}