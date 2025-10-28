import 'package:flutter/material.dart';

class ProductTextHeading extends StatelessWidget {
  const ProductTextHeading({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 24,
      ),
    );
  }
}
