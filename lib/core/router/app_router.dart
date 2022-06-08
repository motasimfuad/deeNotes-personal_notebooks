import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notebooks/bottom_nav.dart';
import 'package:notebooks/features/note/presentation/pages/view_note_screen/view_note_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/all_notebooks_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/create_notebook_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/edit_notebook_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/notebook_page.dart';

import '../../features/note/presentation/pages/create_note_page.dart';

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
  static const String viewNoteFullScreenPage = 'viewNoteFullScreen';
  static const String editNotePage = 'editNote';
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
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const BottomNav(),
      ),
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
  ],
);

// NotebookEntity _notebook(String? param) {
//  return notebooks
// }
