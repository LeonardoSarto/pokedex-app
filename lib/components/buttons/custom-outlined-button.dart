import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  VoidCallback onPressed;

  CustomOutlinedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: const Text("teste")
    );
  }
}
