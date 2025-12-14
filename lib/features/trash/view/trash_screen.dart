import 'package:clipboard_manager/core/themes/app_color_themes.dart';
import 'package:flutter/material.dart';
import 'package:clipboard_manager/commons/widgets/widgets.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorThemes.secondaryColor,
      child: Center(
        child: KText(
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 2,
          text: "Trash",
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColorThemes.whiteColor,
        ),
      ),
    );
  }
}
