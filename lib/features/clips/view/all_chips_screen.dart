import 'package:clipboard_manager/commons/widgets/widgets.dart';
import 'package:clipboard_manager/core/constants/constants.dart';
import 'package:clipboard_manager/core/themes/app_color_themes.dart';
import 'package:flutter/material.dart';
import 'package:clipboard_manager/core/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllClipsScreen extends StatefulWidget {
  const AllClipsScreen({super.key});

  @override
  State<AllClipsScreen> createState() => _AllClipsScreenState();
}

class _AllClipsScreenState extends State<AllClipsScreen> {
  final TextEditingController searchChipsOrTagsController =
      TextEditingController();

  bool isGridSelected = true;

  final List<int> clips = List.generate(8, (index) => index);

  @override
  void dispose() {
    searchChipsOrTagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive
    final isMobile = AppResponsiveUtils.isMobile(context);
    final isTablet = AppResponsiveUtils.isTablet(context);
    final isDesktop = AppResponsiveUtils.isDesktop(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------- HEADER ----------
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      KText(
                        text: "Clip Manager",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColorThemes.whiteColor,
                      ),
                      SizedBox(height: 4),
                      KText(
                        text: "Most recent items captured",
                        fontSize: 14,
                        color: AppColorThemes.dashboardUnSelectedColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: KTextFormField(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColorThemes.dashboardUnSelectedColor,
                    ),
                    controller: searchChipsOrTagsController,
                    hintText: "Search clips or tags...",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// ---------- GRID / LIST TOGGLE ----------
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColorThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _viewToggleButton(
                      isSelected: isGridSelected,
                      iconPath: AppAssetsConstants.grid,
                      onTap: () => setState(() => isGridSelected = true),
                    ),
                    _viewToggleButton(
                      isSelected: !isGridSelected,
                      iconPath: AppAssetsConstants.list,
                      onTap: () => setState(() => isGridSelected = false),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Divider(
              color: AppColorThemes.dashboardUnSelectedColor.withOpacity(0.4),
            ),

            const SizedBox(height: 20),

            /// ---------- CONTENT ----------
            if (!isGridSelected || isMobile)
              ListView.builder(
                itemCount: clips.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: clipCard(isDesktop: false, isTablet: false),
                  );
                },
              )
            else
              GridView.builder(
                itemCount: clips.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 4 : 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return clipCard(isDesktop: isDesktop, isTablet: isTablet);
                },
              ),
          ],
        ),
      ),
    );
  }

  /// ---------- TOGGLE BUTTON ----------
  Widget _viewToggleButton({
    required bool isSelected,
    required VoidCallback onTap,
    required String iconPath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? AppColorThemes.gridAndListViewToggleSelectedBgColor
              : Colors.transparent,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            height: 20,
            color: isSelected
                ? AppColorThemes.whiteColor
                : AppColorThemes.dashboardUnSelectedColor,
          ),
        ),
      ),
    );
  }

  /// ---------- CLIP CARD ----------
  Widget clipCard({required bool isDesktop, required bool isTablet}) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColorThemes.sideBarBgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              KText(
                text: "Javascript",
                color: AppColorThemes.dashboardUnSelectedColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColorThemes.blackColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const KText(
                text: "Hi this is the first javascript theory should be taught",
                color: AppColorThemes.whiteColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              KText(
                text: "2 mins ago",
                color: AppColorThemes.dashboardUnSelectedColor,
              ),
              KText(
                text: "#devs",
                color: AppColorThemes.dashboardUnSelectedColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
