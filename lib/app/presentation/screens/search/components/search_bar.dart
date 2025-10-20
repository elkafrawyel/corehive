import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/config/helpers/time_debuncer.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/presentation/screens/search/controller/search_controller.dart'
    as ch;

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    AppTimeDebuncer.instance.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'search-bar-hero',
      child: Container(
        decoration: BoxDecoration(
          color: context.kTextFieldColor,
          borderRadius: BorderRadius.circular(32),
          // more rounded for pill shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: context.kHintTextColor.withValues(alpha: 0.7),
              size: 20,
            ),
            10.pw,
            Expanded(
              child: TextField(
                onTapOutside: (event) => _focusNode.unfocus(),
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Search products, brands...',
                  hintStyle: TextStyle(
                    color: context.kHintTextColor.withValues(alpha: 0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) => AppTimeDebuncer.instance.debounce(
                  Duration(milliseconds: 600),
                  () => ch.SearchController.to.search(value),
                ),
                style: TextStyle(
                  color: context.kTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
