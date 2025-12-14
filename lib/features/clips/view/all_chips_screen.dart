import 'package:clipboard_manager/commons/widgets/k_text.dart';
import 'package:clipboard_manager/core/themes/app_color_themes.dart';
import 'package:flutter/material.dart';

class AllClipsScreen extends StatelessWidget {
  const AllClipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorThemes.secondaryColor,
      child: Center(
        child: KText(
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 2,
          text: "All Clips",
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColorThemes.whiteColor,
        ),
      ),
    );
  }
}
