import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/presentation/screens/search/controller/search_controller.dart'
    as ch;
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Filter Products',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Category',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            CategoryChips(),
            const SizedBox(height: 20),
            Text(
              'Price Range',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            PriceSlider(),
            const SizedBox(height: 20),
            Text(
              'Minimum Rating',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            RatingChips(),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.find<ch.SearchController>().clearFilters();
                      Navigator.pop(context);
                    },
                    child: const Text('Clear'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final controller = Get.find<ch.SearchController>();
                      controller.fetchResults();
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<ch.SearchController>();
      final categories = controller.categories;
      final selectedCategories = controller.selectedCategories;
      return Wrap(
        spacing: 8,
        children: categories.map((cat) {
          final selected = selectedCategories.contains(cat);
          return FilterChip(
            label: Text(
              cat,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            selected: selected,
            selectedColor: context.kPrimaryColor,
            backgroundColor: Colors.grey.shade200,
            checkmarkColor: Colors.white,
            onSelected: (val) => controller.toggleCategory(cat),
          );
        }).toList(),
      );
    });
  }
}

class PriceSlider extends StatelessWidget {
  const PriceSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<ch.SearchController>();
      double min = controller.minPrice;
      double max = controller.maxPrice;
      double start = controller.selectedMinPrice;
      double end = controller.selectedMaxPrice;
      RangeValues values = RangeValues(start, end);
      return Column(
        children: [
          RangeSlider(
            min: min,
            max: max,
            values: values,
            divisions: 20,
            labels: RangeLabels(
              '\u0024${values.start.round()}',
              '\u0024${values.end.round()}',
            ),
            onChanged: (v) => controller.setPriceRange(v.start, v.end),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\u0024${values.start.round()}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '\u0024${values.end.round()}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      );
    });
  }
}

class RatingChips extends StatelessWidget {
  const RatingChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<ch.SearchController>();
      final ratings = controller.ratings;
      final selectedRating = controller.selectedRating;
      return Wrap(
        spacing: 8,
        children: ratings.map((r) {
          final selected = selectedRating == r.toDouble();
          return ChoiceChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: selected ? Colors.white : Colors.amber,
                  size: 16,
                ),
                Text(
                  '$r+',
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black87,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            selected: selected,
            selectedColor: context.kPrimaryColor,
            checkmarkColor: Colors.white,
            backgroundColor: Colors.grey.shade200,
            onSelected: (val) => controller.setRating(r.toDouble()),
          );
        }).toList(),
      );
    });
  }
}

class PriceFilter extends StatelessWidget {
  final ch.SearchController controller;
  const PriceFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Min Price'),
            keyboardType: TextInputType.number,
            onChanged: (val) => controller.setFilter('minPrice', val),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Max Price'),
            keyboardType: TextInputType.number,
            onChanged: (val) => controller.setFilter('maxPrice', val),
          ),
        ),
      ],
    );
  }
}

class RatingFilter extends StatelessWidget {
  final ch.SearchController controller;
  const RatingFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<double>(
      decoration: const InputDecoration(labelText: 'Minimum Rating'),
      items: [5, 4, 3, 2, 1]
          .map((r) => DropdownMenuItem(value: r.toDouble(), child: Text('$r+')))
          .toList(),
      onChanged: (value) {
        if (value != null) controller.setFilter('minRating', value);
      },
    );
  }
}
