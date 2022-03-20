import 'package:demo_project/presentation/constants/strings.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String? error;
  const ErrorView({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_sharp,
            color: Colors.redAccent,
            size: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              error ?? searchErrorString,
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
