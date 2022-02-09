import 'package:flutter/material.dart';
import 'package:notebooks/presentation/screens/all_notebooks_screen/all_notebooks_screen.dart';
import 'package:notebooks/presentation/screens/favorite_notes/favorite_notes.dart';
import 'package:notebooks/presentation/screens/settings_screen/settings_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  var screens = [
    // const MyHomePage(title: 'Hi'),
    const AllNotebooksScreen(),
    const FavoriteNotes(),
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
