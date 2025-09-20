import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final String? selectedStatus;
  final int? selectedYear;
  final VoidCallback? onClearStatus;
  final VoidCallback? onClearYear;
  const FilterChips({
    this.selectedStatus,
    this.selectedYear,
    this.onClearStatus,
    this.onClearYear,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedStatus == null && selectedYear == null) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (selectedStatus != null)
            Chip(
              label: Text('Status: $selectedStatus'),
              onDeleted: onClearStatus,
            ),
          if (selectedYear != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Chip(
                label: Text('Year: $selectedYear'),
                onDeleted: onClearYear,
              ),
            ),
        ],
      ),
    );
  }
}
