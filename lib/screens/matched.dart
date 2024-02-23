import 'package:flutter/material.dart';

class MatchedScreen extends StatelessWidget {
  const MatchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('MatchedScreen::build()');

    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "stared",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
