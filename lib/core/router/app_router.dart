import 'package:flutter/material.dart';
import 'package:notebooks/bottom_nav.dart';
import 'package:notebooks/features/note/data/models/note_model.dart';
import 'package:notebooks/features/note/presentation/pages/view_note_screen/view_note_full_screen.dart';
import 'package:notebooks/features/note/presentation/pages/view_note_screen/view_note_screen.dart';
import 'package:notebooks/features/notebook/data/models/notebook_model.dart';

import 'package:notebooks/features/note/presentation/pages/edit_note_page.dart';
import 'package:notebooks/features/note/presentation/pages/favorite_notes_page.dart';

import '../exceptions/route_exception.dart';
import '../../features/notebook/presentation/pages/all_notebooks_page.dart';
import '../../features/notebook/presentation/pages/create_notebook_page.dart';

class AppRouter {
  static const String home = '/';
  static const String notebooks = 'notebooks';
  static const String favorites = 'favorites';
  static const String notebookScreen = 'notebookScreen';
  static const String createNote = 'createNote';
  static const String createNotebook = 'createNotebook';
  static const String viewNote = 'viewNote';
  static const String viewNoteFullScreen = 'viewNoteFullScreen';
  static const String editNote = 'editNote';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const BottomNav(),
        );
      case notebooks:
        return MaterialPageRoute(
          builder: (_) => const AllNotebooksPage(),
        );

      case createNotebook:
        return MaterialPageRoute(
          builder: (_) => const CreateNotebookPage(),
        );
      case favorites:
        return MaterialPageRoute(
          builder: (_) => const FavoriteNotesPage(),
        );
      // case createNote:
      //   return MaterialPageRoute(
      //     builder: (_) =>  CreateNote(),
      //   );

      case viewNote:
        final note = settings.arguments as NoteModel;
        final notebook = settings.arguments as NotebookModel;
        return MaterialPageRoute(
          builder: (context) => ViewNoteScreen(notebook: notebook, note: note),
          settings: settings,
        );

      case viewNoteFullScreen:
        final note = settings.arguments as NoteModel;
        return MaterialPageRoute(
          builder: (context) => ViewNoteFullScreen(note: note),
          settings: settings,
        );

      case editNote:
        return MaterialPageRoute(
          builder: (_) => EditNotePage(
            note: settings.arguments as NoteModel,
          ),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}

// extension NavigatorStateExtentions on NavigatorState {
//   Future<void> toNoteScreen({note, notebook}) => pushNamed(
//         AppRouter.viewNote,
//         arguments: note, notebook;
//       );
// }
