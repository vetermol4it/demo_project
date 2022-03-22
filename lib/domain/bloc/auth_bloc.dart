import 'dart:async';

import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_project/main.dart';
import 'package:demo_project/data/repository/auth_data_repository.dart';
import 'package:demo_project/domain/repository/auth_repository.dart';
import 'package:demo_project/domain/models/user/user.dart';
import 'package:demo_project/presentation/constants/strings.dart';

class AuthBloc extends Bloc<AuthBlocEvent,AuthBlocState> {
  final AuthRepository _repository;
  AuthBloc(this._repository) : super(AuthBlocNotAuthorizedState()) {
    on<AuthBlocSignInEvent>(_signInEventHandler);
    on<AuthBlocSignOutEvent>(_signOutEventHandler);
    on<AuthBlocRegisterEvent>(_registerEventHandler);
    on<_AuthBlocInitialEvent>(_initialEventHandler);
    add(_AuthBlocInitialEvent());
  }

  FutureOr<void> _signInEventHandler (AuthBlocSignInEvent event, emit) async {
    emit(AuthBlocLoadingState());
    try {
      final user = await _repository.signIn(event.login, event.password);
      emit(AuthBlocAuthorizedState(user));
    } catch (e) {
      locator<Logger>().e('Error', e.toString());
      String? error;
      if (e is AuthError && e == AuthError.userNotExist) {
        error = authErrorUserNotExistString;
      }
      emit(AuthBlocErrorState(error));
    }
  }

  FutureOr<void> _signOutEventHandler (AuthBlocSignOutEvent event, emit) async {
    _repository.signOut();
    emit(AuthBlocNotAuthorizedState());
  }

  FutureOr<void> _initialEventHandler (_AuthBlocInitialEvent event, emit) async {
    final user = await _repository.getLastAuthenticatedUser();
    if (user != null) {
      emit(AuthBlocAuthorizedState(user));
    } else {
      emit(AuthBlocNotAuthorizedState());
    }
  }

  FutureOr<void> _registerEventHandler (AuthBlocRegisterEvent event, emit) async {
    emit(AuthBlocLoadingState());
    try {
      await _repository.register(event.user);
      emit(AuthBlocAuthorizedState(event.user));
    } catch (e) {
      locator<Logger>().e('Error', e.toString());
      String? error;
      if (e is RegisterError && e == RegisterError.userExist) {
        error = authErrorUserExistString;
      }
      emit(AuthBlocErrorState(error));
    }
  }
}

abstract class AuthBlocEvent{}
class _AuthBlocInitialEvent extends AuthBlocEvent{}
class AuthBlocSignInEvent extends AuthBlocEvent{
  final String login;
  final String password;

  AuthBlocSignInEvent(this.login, this.password,);
}
class AuthBlocSignOutEvent extends AuthBlocEvent{}
class AuthBlocRegisterEvent extends AuthBlocEvent{
  final User user;

  AuthBlocRegisterEvent(this.user);
}

abstract class AuthBlocState{}
class AuthBlocLoadingState extends AuthBlocState{}
class AuthBlocErrorState extends AuthBlocState{
  final String? error;

  AuthBlocErrorState([this.error]);
}
class AuthBlocNotAuthorizedState extends AuthBlocState{}
class AuthBlocAuthorizedState extends AuthBlocState{
  final User user;

  AuthBlocAuthorizedState(this.user);
}