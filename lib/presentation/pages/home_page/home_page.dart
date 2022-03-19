import 'package:demo_project/presentation/constants/routes.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(child: Text('gggg'),onPressed: ()=> context.goNamed(Routes.loginRoute),),
    );
  }
}
