import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, this.onPressed, this.icon, this.label});

  final VoidCallback? onPressed;
  final Icon? icon;
  final Text? label;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(240),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
        child: IntrinsicHeight(
            child: Row(children: [
          icon ?? const Icon(Icons.login_outlined),
          const VerticalDivider(color: Colors.black, width: 28),
          label ?? const Text(" Sign-in"),
        ])),
      );
}
