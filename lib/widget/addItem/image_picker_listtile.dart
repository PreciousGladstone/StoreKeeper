import 'package:flutter/material.dart';

class ImagePickerListtile extends StatelessWidget {
  const ImagePickerListtile({super.key, required this.onTap, required this.icon, required this.text});

  final IconData icon;
  final String text;
  final void Function() onTap;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
