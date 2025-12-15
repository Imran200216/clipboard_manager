import 'package:clipboard_manager/commons/widgets/widgets.dart';
import 'package:clipboard_manager/core/themes/app_color_themes.dart';
import 'package:flutter/material.dart';
import 'package:clipboard_manager/core/utils/utils.dart';

class KTextFormField extends StatelessWidget {
  final bool readOnly;
  final String? labelText;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final int? maxLines;

  final int? maxLength; // 👈 NEW optional parameter

  final Widget? prefixIcon;
  final Function(String)? onChanged;

  const KTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.labelText,
    this.maxLines,
    this.readOnly = false,
    this.prefixIcon,
    this.onChanged,
    this.maxLength, // 👈 include in constructor
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = AppResponsiveUtils.isTablet(context);
    final isMobile = AppResponsiveUtils.isMobile(context);
    final isDesktop = AppResponsiveUtils.isDesktop(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null && labelText!.isNotEmpty) ...[
          KText(
            textAlign: TextAlign.start,
            text: labelText!,
            fontSize: isDesktop
                ? 14
                : isTablet
                ? 12
                : 20,
            fontWeight: FontWeight.w500,
            color: AppColorThemes.whiteColor,
          ),

          const SizedBox(height: 10),
        ],

        TextFormField(
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          // 👈 ADDED HERE
          style: TextStyle(
            fontSize: isDesktop
                ? 13
                : isTablet
                ? 11
                : 10,
            fontWeight: FontWeight.w400,
            color: AppColorThemes.whiteColor,
          ),
          onChanged: onChanged,

          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: AppColorThemes.sideBarBgColor,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColorThemes.secondaryColor,
                width: 1,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: isDesktop
                  ? 13
                  : isTablet
                  ? 11
                  : 10,
              fontWeight: FontWeight.w400,
              color: AppColorThemes.dashboardUnSelectedColor,
            ),
          ),
        ),
      ],
    );
  }
}
