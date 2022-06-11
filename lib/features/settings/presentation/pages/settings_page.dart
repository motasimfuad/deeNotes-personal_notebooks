import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebooks/core/constants/colors.dart';
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
                  KSnackBar(
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

                  KSnackBar(
                    context: context,
                    message: 'Database Deleted',
                  );
                }
              },
              builder: (context, state) {
                if (state is AllSettingsFetchedState) {
                  displayName = state.selectedView!.name;
                  isNoteContentHidden = state.isNoteContentHidden!;
                  print(
                      "AllSettings >> noteViewType: $displayName, isNoteContentHidden: $isNoteContentHidden");
                } else if (state is NoteViewSettingsChangedState) {
                  displayName = state.selectedView.name;
                  print(
                      "NoteViewSettingsChanged >> noteViewType: $displayName, isNoteContentHidden: $isNoteContentHidden");
                } else if (state is NoteContentViewToggledState) {
                  isNoteContentHidden = state.isNoteContentHidden;
                  print(
                      "NoteContent >> noteViewType: $displayName, isNoteContentHidden: $isNoteContentHidden");
                } else if (state is DatabaseClearedState) {
                  // context
                  //     .read<NotebookBloc>()
                  //     .add(const GetAllNotebooksEvent());
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

  Column _buildCustomPage(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          value: isNoteContentHidden,
          onChanged: (val) {
            setState(() {
              context.read<SettingsBloc>().add(
                    ToggleNoteContentViewEvent(toggleView: val),
                  );
              isNoteContentHidden = val;
            });
            print(isNoteContentHidden);
          },
        ),
        StatefulBuilder(
          builder: (context, setState) => SwitchListTile(
            value: isNoteContentHidden,
            onChanged: (val) {
              setState(() {
                context.read<SettingsBloc>().add(
                      ToggleNoteContentViewEvent(toggleView: val),
                    );
                isNoteContentHidden = val;
              });
              print(isNoteContentHidden);
            },
          ),
        )
      ],
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
          title: const Text('UI'),
          tiles: [
            SettingsTile.navigation(
              leading: const Icon(Icons.grid_view_outlined),
              title: const Text('Notes View'),
              value: Text(displayName),
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
              title: const Text('Hide note content'),
              description: const Text('Hide note content in list page'),
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
                ),
              ),
              onPressed: (context) {
                KDialog(
                  context: context,
                  title: 'Delete Database?',
                  barrierColor: Colors.red.withOpacity(0.85),
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
