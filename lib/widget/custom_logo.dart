import 'package:flutter/widgets.dart';
import 'package:project_social/framework/constants.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/logo_black.png', width: kLogoWidth, height: kLogoHeight);
  }
}
