import 'package:flutter/material.dart';
import 'package:luma/app/config/theme/color_extension.dart';
import '../../../../../widgets/app_text.dart';

class ProfileTileToggle extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ProfileTileToggle({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  State<ProfileTileToggle> createState() => _ProfileTileToggleState();
}

class _ProfileTileToggleState extends State<ProfileTileToggle>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) => setState(() => _scale = 0.97);
  void _onTapUp(TapUpDetails details) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_scale),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: context.kPrimaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.kPrimaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.icon, color: context.kPrimaryColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppText(
                text: widget.title,
                color: context.kTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Custom Toggle
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 50,
              height: 28,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: widget.value
                    ? context.kPrimaryColor
                    : Colors.grey.shade300,
              ),
              child: Align(
                alignment:
                widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
