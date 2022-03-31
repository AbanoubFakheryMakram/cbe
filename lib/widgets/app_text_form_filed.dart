
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import 'custom_scroll_behavior.dart';

class AppTextFormField extends StatelessWidget {
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String input)? onChanged;
  final Function(String input)? onSubmit;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String input)? validator;
  final TextAlign? textAlign;
  final String? initialValue;
  final int ?maxLines;
  final TextInputType? keyboardType;
  final double? height;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? color;
  final OutlineInputBorder? inputBorder;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool enable;

  const AppTextFormField({
    Key? key,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onSubmit,
    this.validator,
    this.hintText,
    this.textAlign,
    this.controller,
    this.initialValue,
    this.maxLines = 1,
    this.keyboardType,
    this.height,
    this.color,
    this.contentPadding,
    this.inputBorder, this.focusNode,
    this.maxLength,
    this.hintStyle,
    this.enable = true,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        onChanged: onChanged,
        initialValue: initialValue,
        onFieldSubmitted: onSubmit,
        controller: controller,
        textAlign: TextAlign.end,
        keyboardType: keyboardType,
        focusNode: focusNode,
        maxLines: maxLines,
        maxLength: maxLength,
        obscureText: obscureText || keyboardType == TextInputType.visiblePassword,
        scrollPhysics: bouncingScrollPhysics,
        style: textStyle ?? const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? '',
          suffixIcon: suffixIcon,
          alignLabelWithHint: true,
          enabled: enable,
          contentPadding: contentPadding,
          prefixIcon: prefixIcon,
          hintStyle: hintStyle ?? const TextStyle(fontSize: 11, color: AppColors.textGrey),
          enabledBorder: inputBorder ?? OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: inputBorder ?? OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: inputBorder ?? OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      height: height ?? 60,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
