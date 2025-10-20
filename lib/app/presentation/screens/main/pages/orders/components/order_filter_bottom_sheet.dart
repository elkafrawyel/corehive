import 'package:corehive_store/app/config/theme/color_extension.dart';
import '../../../../../widgets/app_text.dart';
import 'package:flutter/material.dart';

class OrderFilterBottomSheet extends StatelessWidget {
  final String? selectedStatus;
  final int? selectedYear;
  final List<String> statuses;
  final List<int> years;
  final ValueChanged<String?> onStatusSelected;
  final ValueChanged<int?> onYearSelected;

  const OrderFilterBottomSheet({
    super.key,
    required this.selectedStatus,
    required this.selectedYear,
    required this.statuses,
    required this.years,
    required this.onStatusSelected,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.kBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText(
                  text: 'Filter Orders',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: context.kTextColor,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: context.kHintTextColor),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppText(
              text: 'Status',
              fontWeight: FontWeight.w600,
              color: context.kPrimaryColor,
            ),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: selectedStatus == null,
                  onSelected: (_) {
                    onStatusSelected(null);
                    Navigator.pop(context);
                  },
                ),
                ...statuses.map(
                  (status) => ChoiceChip(
                    label: Text(status),
                    selected: selectedStatus == status,
                    onSelected: (_) {
                      onStatusSelected(status);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppText(
              text: 'Year',
              fontWeight: FontWeight.w600,
              color: context.kPrimaryColor,
            ),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: selectedYear == null,
                  onSelected: (_) {
                    onYearSelected(null);
                    Navigator.pop(context);
                  },
                ),
                ...years.map(
                  (year) => ChoiceChip(
                    label: Text(year.toString()),
                    selected: selectedYear == year,
                    onSelected: (_) {
                      onYearSelected(year);
                      Navigator.pop(context);
                    },
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
