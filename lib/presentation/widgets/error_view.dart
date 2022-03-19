import 'package:demo_project/presentation/constants/strings.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String? error;
  const ErrorView({
    Key? key,
    this.error = searchErrorString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              error!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
