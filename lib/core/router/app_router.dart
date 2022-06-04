import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notebooks/bottom_nav.dart';
import 'package:notebooks/features/notebook/presentation/pages/all_notebooks_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/create_notebook_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/notebook_page.dart';

class AppRouters {
  static const String homePage = '/';
  static const String notebooksPage = 'notebooks';
  static const String favoritesPage = 'favorites';
  static const String notebookPage = 'notebook';
  static const String createNotePage = 'create-note';
  static const String createNotebookPage = 'create-notebook';
  static const String viewNotePage = 'viewNote';
  static const String viewNoteFullScreenPage = 'viewNoteFullScreen';
  static const String editNotePage = 'editNote';
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
          child: AllNotebooksPage(),
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
      name: AppRouters.createNotebookPage,
      path: '/${AppRouters.createNotebookPage}',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const CreateNotebookPage(),
        );
      },
    ),
  ],
);

// NotebookEntity _notebook(String? param) {
//  return notebooks
// }

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case home:
  //       return MaterialPageRoute(
  //         builder: (_) => const BottomNav(),
  //       );
  //     case notebooks:
  //       return MaterialPageRoute(
  //         builder: (_) => AllNotebooksPage(),
  //       );

  //     case createNotebook:
  //       return MaterialPageRoute(
  //         builder: (_) => const CreateNotebookPage(),
  //       );
  //     case favorites:
  //       return MaterialPageRoute(
  //         builder: (_) => const FavoriteNotesPage(),
  //       );
  //     // case createNote:
  //     //   return MaterialPageRoute(
  //     //     builder: (_) =>  CreateNote(),
  //     //   );

  //     case viewNote:
  //       final note = settings.arguments as NoteModel;
  //       final notebook = settings.arguments as NotebookModel;
  //       return MaterialPageRoute(
  //         builder: (context) => ViewNoteScreen(notebook: notebook, note: note),
  //         settings: settings,
  //       );

  //     case viewNoteFullScreen:
  //       final note = settings.arguments as NoteModel;
  //       return MaterialPageRoute(
  //         builder: (context) => ViewNoteFullScreen(note: note),
  //         settings: settings,
  //       );

  //     case editNote:
  //       return MaterialPageRoute(
  //         builder: (_) => EditNotePage(
  //           note: settings.arguments as NoteModel,
  //         ),
  //       );

  //     default:
  //       throw const RouteException('Route not found!');
  //   }
  // }
// }
