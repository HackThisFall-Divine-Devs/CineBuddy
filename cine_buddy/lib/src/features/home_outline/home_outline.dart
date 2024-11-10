import 'package:cine_buddy/src/features/authentication/signin.dart';
import 'package:cine_buddy/src/features/groups/groups_page.dart';
import 'package:cine_buddy/src/features/groups/my_groups_page.dart';
import 'package:cine_buddy/src/features/home/home_page.dart';
import 'package:cine_buddy/src/features/movies/SwipePage.dart';
import 'package:cine_buddy/src/features/notification/notification.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class HomeOutLine extends StatefulWidget {
  const HomeOutLine({super.key});

  @override
  State<HomeOutLine> createState() => _HomeOutLineState();
}

class _HomeOutLineState extends State<HomeOutLine> {
  final PageStorageBucket bucket = PageStorageBucket();
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomNavBarItems = [
      GroupsPage(
        key: PageStorageKey('homePage'),
      ),
      HomePage(),
      NotificationPage(),
      MyGroupsPage(),
    ];

    return Scaffold(
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        backgroundColor: ColorSys.kprimary,
        items: [
          FlashyTabBarItem(
            inactiveColor: ColorSys.kwhite,
            activeColor: ColorSys.ksecondary,
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            inactiveColor: ColorSys.kwhite,
            activeColor: ColorSys.ksecondary,
            icon: Icon(Icons.movie),
            title: Text('Movies'),
          ),
          FlashyTabBarItem(
            inactiveColor: ColorSys.kwhite,
            activeColor: ColorSys.ksecondary,
            icon: Icon(Icons.notifications),
            title: Text('Updates'),
          ),
          FlashyTabBarItem(
            inactiveColor: ColorSys.kwhite,
            activeColor: ColorSys.ksecondary,
            icon: Icon(Icons.person),
            title: Text('MyRooms'),
          ),
        ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: bottomNavBarItems.elementAt(_selectedIndex),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40.0,
          width: 100.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SwipePage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.card_giftcard),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Swipe",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 14.0),
                  )
                ],
              ),
            ),
            backgroundColor: ColorSys.ksecondary,
            tooltip: "Start Matchmaking",
            isExtended: true,
          ),
        ),
      ),
    );
  }
}
