import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fstation/ui/themes.dart';

import '../util/app_update.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isUpdateChecked = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!isUpdateChecked) {
          updateDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
        ],
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
            },
            child: CustomScrollView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              slivers: [
                // customDiscoverBar(context), //AppBar
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // CaraouselWidget(),

                    ],
                  ),
                )
              ],
            ),
          ),
          backgroundColor: lightAccentColor,
        ),
      ),
    );
  }

  // Widget ytSection(Map<String, List<dynamic>> ytmData) {
  //   List<Widget> ytList = List.empty(growable: true);
  //   // log(ytmData.toString());
  //
  //   for (var value in (ytmData["body"]!)) {
  //     // log(value.toString());
  //     ytList.add(HorizontalCardView(data: value));
  //   }
  //   return ListView(
  //     shrinkWrap: true,
  //     itemExtent: 275,
  //     padding: const EdgeInsets.only(top: 0),
  //     physics: const NeverScrollableScrollPhysics(),
  //     children: ytList,
  //   );
  // }
  //
  // SliverAppBar customDiscoverBar(BuildContext context) {
  //   return SliverAppBar(
  //     floating: true,
  //     surfaceTintColor: Default_Theme.themeColor,
  //     backgroundColor: Default_Theme.themeColor,
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text("Discover",
  //             style: Default_Theme.primaryTextStyle.merge(const TextStyle(
  //                 fontSize: 34, color: Default_Theme.primaryColor1))),
  //         const Spacer(),
  //         BlocBuilder<NotificationCubit, NotificationState>(
  //           builder: (context, state) {
  //             if (state is NotificationInitial || state.notifications.isEmpty) {
  //               return IconButton(
  //                 padding: const EdgeInsets.all(5),
  //                 constraints: const BoxConstraints(),
  //                 style: const ButtonStyle(
  //                   tapTargetSize:
  //                   MaterialTapTargetSize.shrinkWrap, // the '2023' part
  //                 ),
  //                 onPressed: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => const NotificationView()));
  //                 },
  //                 icon: const Icon(MingCute.notification_line,
  //                     color: Default_Theme.primaryColor1, size: 30.0),
  //               );
  //             } else {
  //               return badges.Badge(
  //                 badgeContent: Padding(
  //                   padding: const EdgeInsets.all(1.5),
  //                   child: Text(
  //                     state.notifications.length.toString(),
  //                     style: Default_Theme.primaryTextStyle.merge(
  //                         const TextStyle(
  //                             fontSize: 11,
  //                             fontWeight: FontWeight.bold,
  //                             color: Default_Theme.primaryColor2)),
  //                   ),
  //                 ),
  //                 badgeStyle: const badges.BadgeStyle(
  //                   badgeColor: Default_Theme.accentColor2,
  //                   shape: badges.BadgeShape.circle,
  //                 ),
  //                 position: badges.BadgePosition.topEnd(top: -10, end: -5),
  //                 child: IconButton(
  //                   padding: const EdgeInsets.all(5),
  //                   constraints: const BoxConstraints(),
  //                   style: const ButtonStyle(
  //                     tapTargetSize:
  //                     MaterialTapTargetSize.shrinkWrap, // the '2023' part
  //                   ),
  //                   onPressed: () {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => const NotificationView()));
  //                   },
  //                   icon: const Icon(MingCute.notification_line,
  //                       color: Default_Theme.primaryColor1, size: 30.0),
  //                 ),
  //               );
  //             }
  //           },
  //         ),
  //         IconButton(
  //           padding: const EdgeInsets.all(5),
  //           constraints: const BoxConstraints(),
  //           style: const ButtonStyle(
  //             tapTargetSize:
  //             MaterialTapTargetSize.shrinkWrap, // the '2023' part
  //           ),
  //           onPressed: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => const TimerView()));
  //           },
  //           icon: const Icon(MingCute.stopwatch_line,
  //               color: Default_Theme.primaryColor1, size: 30.0),
  //         ),
  //         IconButton(
  //             padding: EdgeInsets.all(5),
  //             constraints: const BoxConstraints(),
  //             style: const ButtonStyle(
  //               tapTargetSize:
  //               MaterialTapTargetSize.shrinkWrap, // the '2023' part
  //             ),
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => const SettingsView()));
  //             },
  //             icon: const Icon(MingCute.settings_3_line,
  //                 color: Default_Theme.primaryColor1, size: 30.0)),
  //       ],
  //     ),
  //   );
  // }
}
