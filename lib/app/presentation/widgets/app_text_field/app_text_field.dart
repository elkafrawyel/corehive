import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:vibration/vibration.dart';

import '../../../config/clients/storage/storage_client.dart';
import '../../../config/constants.dart';
import '../../../config/helpers/time_debuncer.dart';
import '../app_text.dart';
import 'auth_form_rules.dart';
import 'custom_shake_widget.dart';

enum AppFieldType { text, name, email, password, confirmPassword, phone }

class AppTextFormField extends StatefulWidget {
  final String? hintText;
  final String? text;
  final String? validateEmptyText;
  final TextEditingController controller;

  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? labelText;
  final String? suffixText;
  final bool required;
  final IconData? suffixIcon;
  final String? prefixIcon;
  final Color? suffixIconColor;
  final bool enabled;
  final List<String>? autoFillHints;
  final double? radius;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final AppFieldType appFieldType;
  final bool checkRulesOnTyping;
  final bool alwaysShowRules;
  final List<AuthFormRule>? rules;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onFocusLost;

  const AppTextFormField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.text,
    this.validateEmptyText,
    this.maxLines,
    this.maxLength,
    this.labelText,
    this.suffixText,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.autoFillHints,
    this.suffixIcon,
    this.prefixIcon,
    this.radius = 8,
    this.suffixIconColor,
    this.textInputAction,
    this.appFieldType = AppFieldType.text,
    this.checkRulesOnTyping = true,
    this.required = true,
    this.alwaysShowRules = false,
    this.rules,
    this.inputFormatters,
    this.onFocusLost,
  });

  @override
  AppTextFormFieldState createState() => AppTextFormFieldState();
}

class AppTextFormFieldState extends State<AppTextFormField> {
  bool _isSecure = false;
  bool _isPasswordField = false;
  String? _apiErrorText;
  final GlobalKey<CustomShakeWidgetState> _shakerKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  bool hasError = false;
  final String _emptyValidationText = StorageClient().isAr()
      ? 'هذا الحقل مطلوب'
      : 'This field is Required';

  List<Widget> _errors = [];
  AppTimeDebuncer debuncer = AppTimeDebuncer.instance;

  @override
  void initState() {
    super.initState();
    _isPasswordField =
        widget.appFieldType == AppFieldType.password ||
        widget.appFieldType == AppFieldType.confirmPassword;
    _isSecure = _isPasswordField;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && widget.onFocusLost != null) {
        widget.onFocusLost!();
      }
    });
  }

  @override
  void dispose() {
    debuncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError
        ? const Color.fromRGBO(229, 57, 53, 1)
        : const Color(0xffE2E8F0);
    final fillErrorColor = const Color.fromRGBO(255, 0, 0, 0.06);

    return CustomShakeWidget(
      key: _shakerKey,
      shakeCount: 4,
      shakeOffset: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            focusNode: _focusNode,
            obscureText: _isSecure,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff6C7E8E),
              fontWeight: FontWeight.w400,
            ),
            controller: widget.controller,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            onChanged: (value) {
              if (!widget.checkRulesOnTyping) clearApiError();
              debuncer.debounce(
                const Duration(milliseconds: 800),
                () => _validateRules(
                  checkRulesOnTyping: widget.checkRulesOnTyping,
                ),
              );
              widget.onChanged?.call(value);
            },
            textInputAction: widget.textInputAction,
            onFieldSubmitted: (value) {
              widget.onFieldSubmitted?.call(value);
              if (widget.checkRulesOnTyping) validate(withFocus: false);
            },
            inputFormatters: widget.inputFormatters,
            autofillHints: widget.autoFillHints,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.center,
            maxLines: _isPasswordField ? 1 : widget.maxLines,
            maxLength: widget.maxLength,
            cursorColor: context.kPrimaryColor,
            cursorWidth: 2,
            decoration: InputDecoration(
              helper: (_apiErrorText?.isEmpty ?? true)
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.error, color: context.kErrorColor),
                          10.pw,
                          Flexible(
                            child: AppText(
                              text: _apiErrorText ?? '',
                              color: context.kErrorColor,
                              fontSize: 12,
                              maxLines: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
              helperMaxLines: 4,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: context.kTextColor,
                fontFamily: StorageClient().isAr()
                    ? Constants.arFontFamily
                    : Constants.fontFamily,
                fontSize: 18,
              ),
              hintText: widget.hintText ?? '',
              fillColor: hasError ? fillErrorColor : context.kBackgroundColor,
              filled: true,
              hintStyle: TextStyle(
                fontSize: 11,
                color: context.kHintTextColor,
                fontFamily: StorageClient().isAr()
                    ? Constants.arFontFamily
                    : Constants.fontFamily,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 15,
                        end: 8,
                        top: 15,
                        bottom: 15,
                      ),
                      child: SvgPicture.asset(
                        widget.prefixIcon!,
                        fit: BoxFit.fitHeight,
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          context.kHintTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : null,
              suffixText: widget.suffixText ?? '',
              suffixIcon: widget.suffixIcon != null || _isPasswordField
                  ? GestureDetector(
                      onTap: _isPasswordField ? _toggle : null,
                      child: Icon(
                        _isPasswordField
                            ? (_isSecure
                                  ? Icons.visibility_off
                                  : Icons.remove_red_eye)
                            : widget.suffixIcon,
                        size: 20,
                        color: context.kHintTextColor,
                      ),
                    )
                  : null,
              enabled: widget.enabled,
              errorStyle: TextStyle(
                fontSize: 12,
                color: context.kErrorColor,
                fontFamily: StorageClient().isAr()
                    ? Constants.arFontFamily
                    : Constants.fontFamily,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? kRadius),
                borderSide: BorderSide(width: kBorderWidth, color: borderColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? kRadius),
                borderSide: BorderSide(width: kBorderWidth, color: borderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? kRadius),
                borderSide: BorderSide(
                  width: kSelectedBorderWidth,
                  color: context.kErrorColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? kRadius),
                borderSide: BorderSide(
                  width: kSelectedBorderWidth,
                  color: hasError ? context.kErrorColor : context.kPrimaryColor,
                ),
              ),
            ),
          ),

          /// 🔥 Animated error/rules view
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: _errors.isEmpty
                ? const SizedBox(key: ValueKey("no_errors"))
                : Padding(
                    key: const ValueKey("errors"),
                    padding: const EdgeInsetsDirectional.only(start: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _errors,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  bool validate({bool withFocus = true}) {
    final validated = _validateRules(checkRulesOnTyping: true);
    if (validated) {
      shake(withFocus: withFocus);
      return false;
    }
    return true;
  }

  void _toggle() => setState(() => _isSecure = !_isSecure);

  void addApiError(String text) {
    setState(() {
      _apiErrorText = text;
      hasError = true;
    });
  }

  void clearApiError() {
    setState(() {
      _apiErrorText = null;
      hasError = false;
      _errors = [];
    });
  }

  Future shake({bool withFocus = true}) async {
    _shakerKey.currentState?.shake();
    if (withFocus) _focusNode.requestFocus();
    if ((await Vibration.hasVibrator())) {
      Vibration.vibrate();
    }
  }

  bool _validateRules({bool? checkRulesOnTyping}) {
    if (!widget.required || !(checkRulesOnTyping ?? true)) return false;

    final input = widget.controller.text;
    final errors = <Widget>[];
    final passedRules = <Widget>[];

    if (input.isEmpty) {
      errors.add(singleError(widget.validateEmptyText ?? _emptyValidationText));
    } else if (widget.rules != null) {
      for (final rule in widget.rules!) {
        final passed = rule.condition(input);
        (passed ? passedRules : errors).add(
          singleError(rule.ruleText, isError: !passed),
        );
      }
    }

    setState(() {
      hasError = errors.isNotEmpty;
      _errors = [...errors, if (widget.alwaysShowRules) ...passedRules];
    });

    return hasError;
  }

  Widget singleError(String text, {bool isError = true}) => Row(
    children: [
      Icon(
        isError ? Icons.clear : Icons.done,
        color: isError ? context.kErrorColor : context.kSuccessColor,
        size: 15,
      ),
      5.pw,
      Expanded(
        child: AppText(
          text: text,
          color: isError ? context.kErrorColor : context.kSuccessColor,
          fontSize: 12,
          maxLines: 2,
        ),
      ),
    ],
  );
}
