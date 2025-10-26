import 'package:flutter/material.dart';
import 'package:storekeeperapp/theme/custom_light_theme.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({
    super.key,
    required this.title,
    required this.textStyle,
  });

  final String title;
  
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle
    );
  }

  
}


extension AppTextStyle on TextTheme {
  TextStyle get welcomeTheme =>
      headlineMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 24);
  TextStyle get subTitle =>
      headlineMedium!.copyWith(fontWeight: FontWeight.normal, fontSize: 20, color: lightTheme.colorScheme.onPrimary);
}
