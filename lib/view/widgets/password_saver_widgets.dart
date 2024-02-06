import 'package:flutter/material.dart';

class PasswordDisplayWidget extends StatelessWidget {
  final String password;
  final bool isPasswordVisible;

  const PasswordDisplayWidget({
    Key? key,
    required this.password,
    required this.isPasswordVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maskedPassword = '*' * password.length;
    final displayedPassword = isPasswordVisible ? password : maskedPassword;

    return Text(displayedPassword);
  }
}

class PasswordVisibilityToggle extends StatelessWidget {
  final bool isPasswordVisible;
  final VoidCallback onToggle;

  const PasswordVisibilityToggle({
    Key? key,
    required this.isPasswordVisible,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
      onPressed: onToggle,
    );
  }
}
