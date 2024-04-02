import 'package:flutter/material.dart';
import 'package:project/utilities/constants/smooth_rectangular_border.dart';
import 'package:project/utilities/theme/app_colors.dart';


typedef OnChanged =  void Function(String? value);
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.suffix,
    this.obscureText, this.prefix, this.fillColor, this.onChanged,
  });
  final Widget? suffix;
  final Widget? prefix;
  final OnChanged? onChanged;
  final bool? obscureText;
  final String hintText;
  final Color? fillColor;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: 10),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: 10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: 10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        suffixIcon: suffix,
        prefixIcon: prefix,
        fillColor: fillColor ?? AppColors.white,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.brightGrey),
      ),
      keyboardType: TextInputType.name,
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
    );
  }
}


class TestingTextField extends StatelessWidget {
  const TestingTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.suffix,
    this.obscureText, this.prefix,
  });
  final Widget? suffix;
  final Widget? prefix;
  final bool? obscureText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(

        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: 10),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: 10),
          borderSide: BorderSide.none,

        ),
        focusedBorder: OutlineInputBorder(

          borderRadius: SmoothBorderRadius(cornerRadius: 10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        suffixIcon: suffix,
        prefixIcon: prefix,
        fillColor: AppColors.alabaster,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.brightGrey),
      ),
      keyboardType: TextInputType.name,
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
    );
  }
}
