import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/feature/presentaion/pages/home_page/asset_screen.dart';
import 'package:suja_shoie_app/feature/presentaion/pages/home_page/message_screen.dart';
import 'package:suja_shoie_app/feature/presentaion/pages/home_page/more_screen.dart';
import 'package:suja_shoie_app/feature/presentaion/pages/home_page/workorde_screen.dart';
import 'package:suja_shoie_app/feature/presentaion/pages/widget/home_page_widget/workorder_widget/user_details.dart';

import '../../../../main.dart';
import '../../providers/bottom_tap_provider.dart';
import '../../providers/theme_providers.dart';
import '../../../../constant/utils/theme_styles.dart';

class MainScreen extends StatefulWidget {
  // ignore: prefer_final_fields
  static List<Widget> _bottomWidgets = <Widget>[
    WorkOrdersScreen(),
    // DummyDashboard(),
    const AssetsScreen(),
    const MessagesScreen(),
    const MoreScreen(),
  ];

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final tabProvider = Provider.of<TabProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          // backgroundColor: primaryColor,

          automaticallyImplyLeading: false,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Headings (subHeading: 'Hello, Sivabala!',),

              UserDetails(),
              SizedBox(
                width: defaultPadding * 2,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        themeProvider.setDarkTheme(!themeProvider.isDarkTheme);
                      });
                    },
                    child: Icon(
                      themeProvider.isDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      color: themeProvider.isDarkTheme
                          ? Colors.white
                          : const Color(0xFFFFFFFF),
                    ),
                  ),
                  const Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          flexibleSpace: const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maintenance',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: defaultPadding * 2),
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: MainScreen._bottomWidgets[tabProvider.selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.extension),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
        currentIndex: tabProvider.selectedIndex,
        selectedItemColor:
            themeProvider.isDarkTheme ? Colors.white : const Color(0xFF25476A),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) => tabProvider.setSelectedIndex(index),
      ),
    );
  }
}
