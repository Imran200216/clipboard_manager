import 'package:clipboard_manager/core/themes/app_color_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clipboard_manager/features/home/home.dart';

class SideBarItem extends StatelessWidget {
  final int index;
  final String icon;
  final String title;
  final int selectedIndex;

  const SideBarItem({
    super.key,
    required this.index,
    required this.icon,
    required this.title,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        context.read<SideBarCubit>().changeIndex(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColorThemes.selectedSideBarItemsBorderColor
                : AppColorThemes.transparentColor,
          ),
          color: isSelected
              ? AppColorThemes.selectedSideBarItemsBgColor
              : AppColorThemes.transparentColor,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              color: isSelected
                  ? AppColorThemes.selectedSideBarItemsTextColor
                  : AppColorThemes.dashboardUnSelectedColor,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColorThemes.selectedSideBarItemsTextColor
                    : AppColorThemes.dashboardUnSelectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
