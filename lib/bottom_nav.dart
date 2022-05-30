import 'package:flutter/material.dart';
import 'package:notebooks/features/note/presentation/pages/favorite_notes_page.dart';
import 'package:notebooks/features/settings/presentation/pages/settings_screen.dart';

import 'features/notebook/presentation/pages/all_notebooks_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  var screens = [
    // const MyHomePage(title: 'Hi'),
    const AllNotebooksPage(),
    const FavoriteNotesPage(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: Container(
            // color: const Color(0xfff6f8ff),
            child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              elevation: 10,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xfff6f8ff),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor:
                  Theme.of(context).primaryColor.withAlpha(130),
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
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_added_outlined),
                  label: 'Favorite notes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tune_outlined),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        )));
  }
}
