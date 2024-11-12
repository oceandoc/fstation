import 'package:flutter/material.dart';
import 'package:fstation/util/extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GlobalFooter extends StatelessWidget {
  const GlobalFooter({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBreakpoints.of(context).isMobile
          ? navigationShell
          : Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: VerticalNavBar(navigationShell: navigationShell),
                ),
                Expanded(child: navigationShell),
              ],
            ),
      bottomNavigationBar: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ResponsiveBreakpoints.of(context).isMobile
                ? HorizontalNavBar(navigationShell: navigationShell)
                : const Wrap(),
          ),
        ],
      )),
    );
  }
} // GlobalFooter

class VerticalNavBar extends StatelessWidget {
  const VerticalNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      //  backgroundColor: Default_Theme.themeColor.withOpacity(0.3),
      destinations: const [
        NavigationRailDestination(
            icon: Icon(MingCute.home_4_fill), label: Text('Home')),
        NavigationRailDestination(
            icon: Icon(MingCute.book_5_fill), label: Text('Library')),
        NavigationRailDestination(
            icon: Icon(MingCute.search_2_fill), label: Text('Search')),
        NavigationRailDestination(
            icon: Icon(MingCute.folder_download_fill), label: Text('Offline')),
      ],
      selectedIndex: navigationShell.currentIndex,
      minWidth: 65,

      onDestinationSelected: navigationShell.goBranch,
      groupAlignment: 0,
      // selectedIconTheme: IconThemeData(color: Default_Theme.accentColor),
      // unselectedIconTheme:
      //     const IconThemeData(color: primaryColor),
      // indicatorColor: accentColor,
      indicatorShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
}

class HorizontalNavBar extends StatelessWidget {
  const HorizontalNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 7,
      color: const Color(0xFF0A040C),
      activeColor: context.getChosenColor(),
      textStyle: TextStyle(color: context.getAccentColor(), fontSize: 18),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      backgroundColor: context.getPrimaryColor().withOpacity(0.3),
      tabs: const [
        GButton(
          icon: MingCute.home_4_fill,
          text: 'Home',
        ),
        GButton(
          icon: MingCute.book_5_fill,
          text: 'Library',
        ),
      ],
      selectedIndex: navigationShell.currentIndex,
      onTabChange: navigationShell.goBranch,
    );
  }
}
