import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ["Men", "Women", "Kids", "Shoes", "Accessories"];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: context.kPrimaryColor,
                child: Text(
                  categories[index][0],
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 6),
              Text(categories[index]),
            ],
          );
        },
      ),
    );
  }
}
