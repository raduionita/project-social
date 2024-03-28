import 'package:flutter/widgets.dart';
import 'package:project_social/app/constants.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/image/logo_black.jpg', width: kLogoWidth, height: kLogoHeight);
  }
}
