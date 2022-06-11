import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notebooks/features/note/presentation/pages/edit_note_page.dart';
import 'package:notebooks/features/note/presentation/pages/view_note_screen/view_note_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/all_notebooks_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/create_notebook_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/edit_notebook_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/notebook_page.dart';
import 'package:notebooks/features/settings/presentation/pages/introduction_screen.dart';
import 'package:notebooks/features/settings/presentation/pages/loading_screen.dart';
import 'package:notebooks/features/settings/presentation/pages/note_settings_page.dart';
import 'package:notebooks/features/settings/presentation/pages/settings_page.dart';

import '../../features/note/presentation/pages/create_note_page.dart';
import '../../features/note/presentation/pages/view_note_screen/view_note_full_screen.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';

class AppRouters {
  static const String homePage = '/';
  static const String notebooksPage = 'notebooks';
  static const String notebookPage = 'notebook';
  static const String createNotebookPage = 'create-notebook';
  static const String createNotePage = 'create-note';
  static const String editNotebookPage = 'edit-notebook';

  static const String favoritesPage = 'favorites';
  static const String allNotes = 'notes';
  static const String notePage = 'note';
  static const String viewNoteFullScreenPage = 'fullscreen';
  static const String editNotePage = 'edit-note';
  static const String settingsPage = 'settings';
  static const String noteSettingsPage = 'note-settings';
  static const String introScreen = 'intro-screen';
}

class RouterParams {
  static const String notebookId = 'notebookId';
  static const String noteId = 'noteId';
}
// AppRouter._();

final router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: AppRouters.homePage,
  routes: [
    GoRoute(
      name: AppRouters.homePage,
      path: AppRouters.homePage,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              context.read<SettingsBloc>().add(const CheckIntroWatchedEvent());

              if (state is IntroNotWatchedState) {
                return const IntroductionScreenPage();
              } else if (state is IntroWatchedState ||
                  state is AllSettingsFetchedState) {
                return const AllNotebooksPage();
              } else {
                return const LoadingScreen();
              }
            },
          ),
        );
      },
    ),
    GoRoute(
      name: AppRouters.introScreen,
      path: '${AppRouters.homePage}${AppRouters.introScreen}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const IntroductionScreenPage(),
        );
      },
    ),
    GoRoute(
      name: AppRouters.notebooksPage,
      path: '/${AppRouters.notebooksPage}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const AllNotebooksPage(),
        );
      },
      routes: [
        GoRoute(
          name: AppRouters.notebookPage,
          path: ':notebookId',
          pageBuilder: (context, state) {
            final notebookId = state.params['notebookId'];

            return MaterialPage(
              key: state.pageKey,
              child: NoteBookPage(notebookId: int.parse(notebookId.toString())),
            );
          },
        ),
      ],
    ),
    GoRoute(
      name: AppRouters.notePage,
      path: '/${AppRouters.allNotes}/:${RouterParams.noteId}',
      pageBuilder: (context, state) {
        final noteId = state.params[RouterParams.noteId];
        return MaterialPage(
          child: ViewNotePage(noteId: int.parse(noteId.toString())),
        );
      },
    ),
    GoRoute(
      name: AppRouters.editNotePage,
      path:
          '/${AppRouters.allNotes}/:${RouterParams.noteId}/${AppRouters.editNotePage}',
      pageBuilder: (context, state) {
        final noteId = state.params[RouterParams.noteId];
        return MaterialPage(
          child: EditNotePage(noteId: int.parse(noteId.toString())),
        );
      },
    ),
    GoRoute(
      name: AppRouters.viewNoteFullScreenPage,
      path:
          '/${AppRouters.allNotes}/:${RouterParams.noteId}/${AppRouters.viewNoteFullScreenPage}',
      pageBuilder: (context, state) {
        final noteId = state.params[RouterParams.noteId];
        return MaterialPage(
          child: ViewNoteFullScreen(noteId: int.parse(noteId.toString())),
        );
      },
    ),
    GoRoute(
      name: AppRouters.createNotebookPage,
      path: '/${AppRouters.createNotebookPage}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const CreateNotebookPage(),
        );
      },
    ),
    GoRoute(
      name: AppRouters.createNotePage,
      path: '/:notebookId/${AppRouters.createNotePage}',
      pageBuilder: (context, state) {
        final notebookId = state.params['notebookId'];

        return MaterialPage(
          key: state.pageKey,
          child: CreateNotePage(notebookId: int.parse(notebookId.toString())),
        );
      },
    ),
    GoRoute(
      name: AppRouters.editNotebookPage,
      path: '/${AppRouters.editNotebookPage}/:notebookId',
      pageBuilder: (context, state) {
        final notebookId = state.params['notebookId'];

        return MaterialPage(
          key: state.pageKey,
          child: EditNotebookPage(notebookId: int.parse(notebookId.toString())),
        );
      },
    ),
    GoRoute(
      name: AppRouters.settingsPage,
      path: '/${AppRouters.settingsPage}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SettingsPage(),
        );
      },
    ),
    GoRoute(
      name: AppRouters.noteSettingsPage,
      path: '/${AppRouters.settingsPage}/${AppRouters.noteSettingsPage}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const NoteSettingsPage(),
        );
      },
    ),
  ],
);

// NotebookEntity _notebook(String? param) {
//  return notebooks
// }
