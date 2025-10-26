import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.iconColor,
  });

  final IconData icon;
  final Color color;
  final Color? iconColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 30, color: iconColor),
      ),
    );
  }
}
