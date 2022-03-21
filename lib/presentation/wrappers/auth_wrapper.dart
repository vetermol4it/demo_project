import 'package:demo_project/presentation/wrappers/router.dart';
import 'package:flutter/material.dart';

import 'package:demo_project/domain/bloc/auth_bloc.dart';
import 'package:demo_project/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatefulWidget {
  final Widget child;

  const AuthWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final AuthBloc _bloc = locator.get();
  final AuthNavigationState _navigationState = locator.get();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (_, state){
        if (state is AuthBlocNotAuthorizedState) {
          _navigationState.loggedIn = false;
        } else if (state is AuthBlocAuthorizedState) {
          _navigationState.loggedIn = true;
        }
      },
      child: widget.child,
    );
  }
}
