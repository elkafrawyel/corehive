import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import '../../widgets/app_text.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;
  final List<String> subCategories;

  const CategoryDetailsScreen({
    super.key,
    required this.categoryName,
    required this.subCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: categoryName,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: context.kTextColor,
        ),
        centerTitle: true,
        backgroundColor: context.kBackgroundColor,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: subCategories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: context.kTextFieldColor,
            child: ListTile(
              title: AppText(
                text: subCategories[index],
                fontWeight: FontWeight.w600,
                color: context.kTextColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: context.kPrimaryColor,
              ),
              onTap: () {
                // TODO: Navigate to subcategory page
              },
            ),
          );
        },
      ),
    );
  }
}
