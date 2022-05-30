import 'package:flutter/material.dart';
import 'package:notebooks/bottom_nav.dart';
import 'package:notebooks/data/models/note.dart';
import 'package:notebooks/data/models/notebook.dart';
import 'package:notebooks/presentation/screens/all_notebooks_screen/all_notebooks_screen.dart';
import 'package:notebooks/presentation/screens/create_notebook/create_notebook.dart';
import 'package:notebooks/presentation/screens/edit_note_screen/edit_note_screen.dart';
import 'package:notebooks/presentation/screens/favorite_notes/favorite_notes.dart';
import 'package:notebooks/presentation/screens/view_note_screen/view_note_full_screen.dart';
import 'package:notebooks/presentation/screens/view_note_screen/view_note_screen.dart';

import '../../core/exceptions/route_exception.dart';

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
          builder: (_) => const AllNotebooksScreen(),
        );

      case createNotebook:
        return MaterialPageRoute(
          builder: (_) => const CreateNotebook(),
        );
      case favorites:
        return MaterialPageRoute(
          builder: (_) => const FavoriteNotes(),
        );
      // case createNote:
      //   return MaterialPageRoute(
      //     builder: (_) =>  CreateNote(),
      //   );

      case viewNote:
        final note = settings.arguments as Note;
        final notebook = settings.arguments as Notebook;
        return MaterialPageRoute(
          builder: (context) => ViewNoteScreen(notebook: notebook, note: note),
          settings: settings,
        );

      case viewNoteFullScreen:
        final note = settings.arguments as Note;
        return MaterialPageRoute(
          builder: (context) => ViewNoteFullScreen(note: note),
          settings: settings,
        );

      case editNote:
        return MaterialPageRoute(
          builder: (_) => EditNoteScreen(
            note: settings.arguments as Note,
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
