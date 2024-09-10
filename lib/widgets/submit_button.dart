import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key,required this.onPressed, required this.title});
  final Function()? onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
          height: 60.0,
          child: ElevatedButton(
            child: Text(title??'Login'),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.red.shade900,
              ),
            ),
            onPressed: onPressed));
  }
}