import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notebooks/bottom_nav.dart';
import 'package:notebooks/features/notebook/presentation/pages/all_notebooks_page.dart';
import 'package:notebooks/features/notebook/presentation/pages/notebook_page.dart';

// class AppRouter {
const String home = '/';
const String notebooks = 'notebooks';
const String favorites = 'favorites';
const String notebookScreen = 'notebook';
const String createNote = 'createNote';
const String createNotebook = 'createNotebook';
const String viewNote = 'viewNote';
const String viewNoteFullScreen = 'viewNoteFullScreen';
const String editNote = 'editNote';

// AppRouter._();

final router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: home,
  routes: [
    GoRoute(
      name: home,
      path: home,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const BottomNav(),
      ),
    ),
    GoRoute(
      name: notebooks,
      path: '/$notebooks',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: AllNotebooksPage(),
        );
      },
      routes: [
        GoRoute(
          name: notebookScreen,
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
