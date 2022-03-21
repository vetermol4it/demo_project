import 'package:demo_project/presentation/constants/strings.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_project/main.dart';
import 'package:demo_project/domain/bloc/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthBloc _bloc = locator.get();

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _bloc,
        buildWhen: (_, state) => state is AuthBlocAuthorizedState,
        builder: (_, state) {
          if (state is AuthBlocAuthorizedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _InfoText(
                    title: userNameString,
                    info: state.user.name,
                  ),
                  _InfoText(
                    title: userRegisterDateString,
                    info: state.user.formattedRegisterDate,
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String title;
  final String info;

  const _InfoText({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title + ': ',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: info,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ]
      ),
    );
  }
}
