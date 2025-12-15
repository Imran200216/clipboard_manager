import 'package:clipboard_manager/commons/widgets/widgets.dart';
import 'package:clipboard_manager/core/constants/constants.dart';
import 'package:clipboard_manager/core/themes/app_color_themes.dart';
import 'package:flutter/material.dart';
import 'package:clipboard_manager/core/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reorderables/reorderables.dart';

class AllClipsScreen extends StatefulWidget {
  const AllClipsScreen({super.key});

  @override
  State<AllClipsScreen> createState() => _AllClipsScreenState();
}

class _AllClipsScreenState extends State<AllClipsScreen> {
  // Controller
  final TextEditingController searchChipsOrTagsController =
      TextEditingController();

  // Grid Flag
  bool isGridSelected = true;

  List<int> clips = List.generate(8, (index) => index);

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
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title and SubTitle
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      KText(
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        text: "Clip Manager",
                        fontSize: isDesktop
                            ? 20
                            : isTablet
                            ? 18
                            : 16,
                        fontWeight: FontWeight.w500,
                        color: AppColorThemes.whiteColor,
                      ),

                      // SubTitle
                      KText(
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        text: "Most recent items captured",
                        fontSize: isDesktop
                            ? 15
                            : isTablet
                            ? 13
                            : 11,
                        fontWeight: FontWeight.w300,
                        color: AppColorThemes.dashboardUnSelectedColor,
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 1),

                // Search Bar
                Expanded(
                  flex: 1,
                  child: KTextFormField(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColorThemes.dashboardUnSelectedColor,
                      weight: 200,
                    ),
                    controller: searchChipsOrTagsController,
                    hintText: "Search chips or tags...",
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColorThemes.secondaryColor,
                    border: Border.all(
                      color: AppColorThemes.dashboardUnSelectedColor
                          .withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      // Grid button
                      _viewToggleButton(
                        isSelected: isGridSelected,
                        iconPath: AppAssetsConstants.grid,
                        iconSize: isDesktop
                            ? 22
                            : isTablet
                            ? 20
                            : 18,
                        onTap: () {
                          if (!isGridSelected) {
                            setState(() {
                              isGridSelected = true;
                            });
                          }
                        },
                      ),

                      // List button
                      _viewToggleButton(
                        isSelected: !isGridSelected,
                        iconPath: AppAssetsConstants.list,
                        iconSize: isDesktop
                            ? 22
                            : isTablet
                            ? 20
                            : 18,
                        onTap: () {
                          if (isGridSelected) {
                            setState(() {
                              isGridSelected = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Divider
            Divider(
              color: AppColorThemes.dashboardUnSelectedColor,
              height: 0.2,
              thickness: 0.4,
            ),

            if (isMobile)
              ReorderableListView.builder(
                itemCount: clips.length,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = clips.removeAt(oldIndex);
                  clips.insert(newIndex, item);
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Padding(
                    key: ValueKey(clips[index]),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: clipCard(isDesktop: false, isTablet: false),
                  );
                },
              )
            else if (isTablet || isDesktop)
              ReorderableWrap(
                spacing: 16,
                runSpacing: 16,
                onReorder: (oldIndex, newIndex) {
                  final item = clips.removeAt(oldIndex);
                  clips.insert(newIndex, item);
                  setState(() {});
                },
                children: clips.map((e) {
                  return clipCard(isDesktop: isDesktop, isTablet: isTablet);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _viewToggleButton({
    required bool isSelected,
    required VoidCallback onTap,
    required String iconPath,
    required double iconSize,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
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
              height: iconSize,
              color: isSelected
                  ? AppColorThemes.whiteColor
                  : AppColorThemes.dashboardUnSelectedColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget clipCard({required bool isDesktop, required bool isTablet}) {
    return Container(
      key: UniqueKey(),
      // 🔴 REQUIRED for reorder
      height: 300,
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColorThemes.sideBarBgColor,
      ),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ---- TITLE ROW ----
          Row(
            spacing: 12,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      AppColorThemes.gridOrListReorderableIconContainerBgColor,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssetsConstants.reorderable,
                    height: isDesktop
                        ? 20
                        : isTablet
                        ? 18
                        : 16,
                    color: AppColorThemes.primaryColor,
                  ),
                ),
              ),
              const Expanded(
                child: KText(
                  text: "Javascript",
                  color: AppColorThemes.dashboardUnSelectedColor,
                ),
              ),
            ],
          ),

          // ---- CONTENT ----
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColorThemes.blackColor,
              ),
              child: const KText(
                text: "Hi this is the first javascript theory should be taught",
                color: AppColorThemes.whiteColor,
              ),
            ),
          ),

          // ---- FOOTER ----
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
