import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebooks/core/constants/constants.dart';
import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/core/widgets/k_dialog.dart';
import 'package:notebooks/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../core/widgets/k_appbar.dart';
import '../../../../core/widgets/k_snackbar.dart';
import '../../../../data/repositories/data_repository.dart';
import '../../../notebook/presentation/bloc/notebook_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final dbClose = DataRepository.instance;
  var displayName = '';
  var isNoteContentHidden = false;

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
            BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is DatabaseClearingState) {
                  kSnackBar(
                    context: context,
                    message: 'Database Deleting...',
                  );
                }
                if (state is DatabaseClearedState) {
                  Navigator.pop(context);
                  BlocProvider.of<SettingsBloc>(context)
                      .add(UpdateSettingsEvent());
                  context
                      .read<NotebookBloc>()
                      .add(const GetAllNotebooksEvent());

                  router.goNamed(AppRouters.notebooksPage);

                  kSnackBar(
                    context: context,
                    message: 'Database Deleted',
                  );
                }
              },
              builder: (context, state) {
                if (state is AllSettingsFetchedState) {
                  displayName = state.selectedView!.name;
                  isNoteContentHidden = state.isNoteContentHidden!;
                } else if (state is NoteViewSettingsChangedState) {
                  displayName = state.selectedView.name;
                } else if (state is NoteContentViewToggledState) {
                  isNoteContentHidden = state.isNoteContentHidden;
                }

                return Expanded(
                  child: _buildSettingsList(context),
                  // child: _buildCustomPage(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  SettingsList _buildSettingsList(BuildContext context) {
    return SettingsList(
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
              value: Text(
                'English'.toUpperCase(),
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              onPressed: (context) {
                kSnackBar(
                  context: context,
                  message: 'More languages coming soon!',
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text('UI'),
          tiles: [
            SettingsTile.navigation(
              leading: const Icon(Icons.grid_view_outlined),
              title: const Text('Notes View'),
              value: Text(
                displayName.toUpperCase(),
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              onPressed: (context) {
                router.pushNamed(AppRouters.noteSettingsPage);
              },
            ),
            SettingsTile.switchTile(
              onPressed: (context) {
                context.read<SettingsBloc>().add(
                      ToggleNoteContentViewEvent(
                          toggleView:
                              isNoteContentHidden == true ? false : true),
                    );
              },
              leading: const Icon(Icons.border_horizontal_rounded),
              initialValue: isNoteContentHidden,
              title: const Text('Hide Note Content'),
              description: Text(
                'Hide note content in list page',
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
              onToggle: (val) {
                context.read<SettingsBloc>().add(
                      ToggleNoteContentViewEvent(toggleView: val),
                    );
              },
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
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: (context) {
                kDialog(
                  context: context,
                  title: 'Delete Database?',
                  barrierColor: Colors.red.withOpacity(0.85),
                  yesButtonText: 'Yes, Delete Everything!',
                  bodyText:
                      'Are you sure you want to delete the database? Everything will be lost!\n\nThis action cannot be undone.',
                  yesBtnPressed: () {
                    context.read<SettingsBloc>().add(ClearDatabaseEvent());
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
