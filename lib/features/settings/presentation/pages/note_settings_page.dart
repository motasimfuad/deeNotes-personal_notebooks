import 'package:flutter/material.dart';
import 'package:notebooks/core/constants/constants.dart';
import 'package:notebooks/core/widgets/k_radio_tile.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/k_appbar.dart';

class NoteSettingsPage extends StatefulWidget {
  const NoteSettingsPage({Key? key}) : super(key: key);

  @override
  State<NoteSettingsPage> createState() => _NoteSettingsPageState();
}

class _NoteSettingsPageState extends State<NoteSettingsPage> {
  int selectedView = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            KAppbar(
              label: 'Note Display Settings',
              context: context,
              onPressed: () {
                router.pop();
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 15.h,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 15.h,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20.w)),
              child: Column(
                children: [
                  KRadioTile(
                    value: 1,
                    groupValue: selectedView,
                    title: 'Grid View',
                    subtitle: 'Show notes in grid view',
                    icon: Icons.grid_view_rounded,
                    onChanged: (value) {
                      setState(() {
                        selectedView = value as int;
                      });
                    },
                  ),
                  KRadioTile(
                    value: 2,
                    groupValue: selectedView,
                    title: 'List View',
                    subtitle: 'Show notes in list view',
                    icon: Icons.list_rounded,
                    onChanged: (value) {
                      setState(() {
                        selectedView = value as int;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
