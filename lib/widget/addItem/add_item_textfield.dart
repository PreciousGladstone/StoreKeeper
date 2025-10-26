import 'package:flutter/material.dart';

class AddItemTextfield extends StatelessWidget {
  const AddItemTextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType, this.prefixIcon, this.suffixIcon,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      
      decoration: InputDecoration(
        prefixIcon: prefixIcon ,
        suffixIcon: suffixIcon,
        hintText: hint,
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color.fromARGB(255, 123, 168, 230), width: 1.5),
        ),
      ),
    );
  }
}
