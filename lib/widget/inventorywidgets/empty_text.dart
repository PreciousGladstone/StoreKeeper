import 'package:flutter/material.dart';

class EmptyText extends StatelessWidget {
  const EmptyText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(color: Colors.grey)),
    );
  }
}
