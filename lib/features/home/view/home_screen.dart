import 'package:clipboard_manager/core/constants/constants.dart';
import 'package:clipboard_manager/core/themes/app_color_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clipboard_manager/features/home/home.dart';
import 'package:clipboard_manager/core/utils/utils.dart';
import 'package:clipboard_manager/features/clips/clips.dart';
import 'package:clipboard_manager/features/favorites/favorites.dart';
import 'package:clipboard_manager/features/trash/trash.dart';
import 'package:clipboard_manager/commons/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Screens
  final List<Widget> _screens = const [
    AllClipsScreen(),
    FavoritesScreen(),
    TrashScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Responsive Utils
    final isMobileOrTablet =
        AppResponsiveUtils.isMobile(context) ||
        AppResponsiveUtils.isTablet(context);

    return BlocProvider(
      create: (_) => SideBarCubit(),
      child: BlocBuilder<SideBarCubit, SideBarState>(
        builder: (context, state) {
          int selectedIndex = 0;
          if (state is SideBarChanged) {
            selectedIndex = state.selectedIndex;
          }

          return Scaffold(
            appBar: isMobileOrTablet
                ? AppBar(
                    backgroundColor: AppColorThemes.sideBarBgColor,
                    leading: Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: AppColorThemes.whiteColor,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    title: const Text("Clip Manager"),
                  )
                : null,

            drawer: isMobileOrTablet
                ? Drawer(child: _buildSidebarContent(context, selectedIndex))
                : null,

            body: Row(
              children: [
                // Sidebar for large screens
                if (!isMobileOrTablet)
                  Container(
                    width: 220,
                    color: AppColorThemes.sideBarBgColor,
                    child: _buildSidebarContent(context, selectedIndex),
                  ),

                // Content Area
                Expanded(
                  child: Container(
                    color: AppColorThemes.secondaryColor,
                    alignment: Alignment.topLeft, // 🔥 IMPORTANT
                    child: _screens[selectedIndex],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSidebarContent(BuildContext context, int selectedIndex) {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Logo
        Row(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssetsConstants.logo,
              color: AppColorThemes.whiteColor,
              height: 26,
              width: 26,
              fit: BoxFit.cover,
            ),

            KText(
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              text: "Clip Manager",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColorThemes.whiteColor,
            ),
          ],
        ),
        const SizedBox(height: 35),

        SideBarItem(
          index: 0,
          icon: AppAssetsConstants.allClips,
          title: "All Clips",
          selectedIndex: selectedIndex,
        ),
        SideBarItem(
          index: 1,
          icon: AppAssetsConstants.favorites,
          title: "Favorites",
          selectedIndex: selectedIndex,
        ),
        SideBarItem(
          index: 2,
          icon: AppAssetsConstants.trash,
          title: "Trash",
          selectedIndex: selectedIndex,
        ),

        const Spacer(flex: 1),

        KText(
          softWrap: true,
          maxLines: 2,
          textAlign: TextAlign.center,
          text: "V 1.0.0",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColorThemes.whiteColor,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
