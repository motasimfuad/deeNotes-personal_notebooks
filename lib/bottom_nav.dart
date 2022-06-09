import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/features/settings/presentation/pages/settings_screen.dart';

import 'core/constants/colors.dart';
import 'features/notebook/presentation/pages/all_notebooks_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  var screens = [
    const AllNotebooksPage(),
    // const FavoriteNotesPage(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBody: true,
        // body: IndexedStack(
        //   index: _selectedIndex,
        //   children: screens,
        // ),
        body: screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            // color: const Color(0xfff6f8ff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            // border: Border.all(
            //   color: KColors.primary,
            //   width: .5,
            // ),

            boxShadow: [
              BoxShadow(
                color: KColors.primary.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 3.5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            child: BottomNavigationBar(
              elevation: 10,
              type: BottomNavigationBarType.fixed,
              // backgroundColor: const Color(0xfff6f8ff),
              backgroundColor: KColors.primary.shade50,

              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: KColors.primary,
              unselectedItemColor: KColors.primary.shade200,
              currentIndex: _selectedIndex,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books_outlined),
                  label: 'Notebooks',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.bookmark_added_outlined),
                //   label: 'Favorite notes',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tune_outlined),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ));
  }
}
