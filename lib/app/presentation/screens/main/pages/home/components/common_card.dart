import 'package:flutter/material.dart';
import '../../../../../widgets/app_text.dart';

class CommonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const CommonCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          AppText(text: subtitle, color: Colors.white70),
        ],
      ),
    );
  }
}
