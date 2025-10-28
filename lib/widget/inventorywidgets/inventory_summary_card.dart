import 'package:flutter/material.dart';

class InventorySummaryCard extends StatelessWidget {
  const InventorySummaryCard({
    super.key,
    required this.icon,
    required this.color,
    required this.value,
    required this.title,
    required this.boxColor,
    required this.totalColor,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String title;
  final Color boxColor;
  final Color totalColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Spacer(),
                  Icon(icon, color: color, size: 26),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: totalColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
