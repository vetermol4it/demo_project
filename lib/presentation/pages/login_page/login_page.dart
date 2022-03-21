import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:demo_project/main.dart';
import 'package:demo_project/domain/bloc/auth_bloc.dart';
import 'package:demo_project/presentation/constants/routes.dart';
import 'package:demo_project/presentation/constants/strings.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthBloc _bloc = locator.get();

  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _loginController,
                  decoration: const InputDecoration(
                    hintText: loginFieldHintText
                  ),
                  validator: (value){
                    if (value == null || value.length < 8) {
                      return loginFieldShortErrorString;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        hintText: passwordFieldHintText
                    ),
                    validator: (value){
                      if (value == null || value.length < 8) {
                        return passwordFieldShortErrorString;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BlocConsumer(
                    bloc: _bloc,
                    listener: (_, state) {
                      if (state is AuthBlocErrorState) {
                        String error = state.error ?? authErrorString;
                        final snackBar = SnackBar(
                          content: Text(error),
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    builder: (_, state) {
                      if (state is AuthBlocLoadingState) {
                        return const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        );
                      }
                      return TextButton(
                        child: const Text(loginButtonText),
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            _bloc.add(AuthBlocSignInEvent(
                              _loginController.text,
                              _passwordController.text,
                            ));
                          }
                        },
                      );
                    }
                  ),
                ),
                TextButton(
                  child: const Text(registerButtonText),
                  onPressed: (){
                    context.goNamed(createAccountRoute);
                  },
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
