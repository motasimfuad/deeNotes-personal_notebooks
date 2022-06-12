import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebooks/core/constants/constants.dart';
import 'package:notebooks/core/widgets/k_radio_tile.dart';
import 'package:notebooks/core/widgets/k_snackbar.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/k_appbar.dart';
import '../bloc/settings_bloc.dart';

class NoteSettingsPage extends StatefulWidget {
  const NoteSettingsPage({Key? key}) : super(key: key);

  @override
  State<NoteSettingsPage> createState() => _NoteSettingsPageState();
}

class _NoteSettingsPageState extends State<NoteSettingsPage> {
  NoteViewType selectedView = NoteViewType.grid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            KAppbar(
              label: 'Note View Settings',
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
              child: BlocConsumer<SettingsBloc, SettingsState>(
                listener: (context, state) {
                  if (state is NoteViewSettingsChangedState) {
                    selectedView = state.selectedView;
                    kSnackBar(
                      context: context,
                      durationSeconds: 1,
                      message:
                          'Note View Settings Changed to ${selectedView.name}',
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AllSettingsFetchedState) {
                    selectedView = state.selectedView!;
                  }
                  if (state is NoteViewSettingsChangedState) {
                    selectedView = state.selectedView;
                  }

                  return Column(
                    children: [
                      KRadioTile(
                        value: NoteViewType.grid,
                        groupValue: selectedView,
                        title: 'Grid View',
                        subtitle: 'Show notes in grid view',
                        icon: Icons.grid_view_rounded,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                NoteViewSettingsChangedEvent(
                                    selectedView: value as NoteViewType),
                              );
                          // setState(() {
                          //   // selectedView = value as NoteViewType;
                          // });
                        },
                      ),
                      KRadioTile(
                        value: NoteViewType.list,
                        groupValue: selectedView,
                        title: 'List View',
                        subtitle: 'Show notes in list view',
                        icon: Icons.list_rounded,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                                NoteViewSettingsChangedEvent(
                                    selectedView: value as NoteViewType),
                              );
                          // setState(() {
                          //   selectedView = value as NoteViewType;
                          // });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
