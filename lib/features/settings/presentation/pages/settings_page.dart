import 'package:flutter/material.dart';
import 'package:notebooks/core/constants/colors.dart';
import 'package:notebooks/core/router/app_router.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../core/widgets/k_appbar.dart';
import '../../../../core/widgets/k_snackbar.dart';
import '../../../../data/repositories/data_repository.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final dbClose = DataRepository.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            KAppbar(
              label: 'Settings',
              context: context,
              onPressed: () {
                router.pop();
              },
            ),
            Expanded(
              child: SettingsList(
                lightTheme: const SettingsThemeData(
                  settingsListBackground: Colors.white,
                  leadingIconsColor: KColors.primary,
                  dividerColor: KColors.primary,
                ),
                sections: [
                  SettingsSection(
                    title: const Text('General'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        title: const Text('Language'),
                        value: const Text('English'),
                        onPressed: (context) {
                          KSnackBar(
                            context: context,
                            message: 'More languages coming soon!',
                          );
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: const Text('Notes'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.grid_view_outlined),
                        title: const Text('Display'),
                        value: const Text('Grid view'),
                        onPressed: (context) {
                          router.pushNamed(AppRouters.noteSettingsPage);
                        },
                      ),
                      SettingsTile.switchTile(
                        leading: const Icon(Icons.border_horizontal_rounded),
                        initialValue: false,
                        title: const Text('Hide note body in list page'),
                        onToggle: (val) {},
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: const Text('Account'),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.playlist_remove_rounded),
                        title: const Text(
                          'Delete Database',
                          style: TextStyle(
                            color: KColors.danger,
                          ),
                        ),
                        // value: const Text('Grid view'),
                        onPressed: (context) {
                          KSnackBar(
                            context: context,
                            message: 'More languages coming soon!',
                          );
                        },
                      ),
                    ],
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
