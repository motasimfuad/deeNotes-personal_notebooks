import 'package:intl/intl.dart';
import 'package:notebooks/core/constants/constants.dart';

extension OutputStrings on int? {
  String get totalNotes {
    return Intl.plural(
      this ?? 0,
      zero: '0 notes',
      one: '$this note',
      other: '$this notes',
      name: "note",
      args: [this ?? 0],
      examples: const {'quantity': 4},
      desc: "Total number of notes in the notebook",
    );
  }

  String get totalFavs {
    return Intl.plural(
      this ?? 0,
      zero: '0 Favorites',
      one: '$this Favorite',
      other: '$this Favorites',
      name: "Favorite",
      args: [this ?? 0],
      examples: const {'quantity': 4},
      desc: "Total number of favorite notes in the notebook",
    );
  }

  String get totalWords {
    return Intl.plural(
      this ?? 0,
      zero: '0 words',
      one: '$this word',
      other: '$this words',
      name: "word",
      args: [this ?? 0],
      examples: const {'quantity': 4},
      desc: "Total number of words in the note",
    );
  }
}

extension FormattedDate on DateTime {
  String get onlyDate {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String get formatted {
    return DateFormat('dd MMM yyyy, hh:mm a').format(this);
  }
}

extension StringName on NoteViewType {
  String get name {
    switch (this) {
      case NoteViewType.list:
        return 'List View';
      case NoteViewType.grid:
        return 'Grid View';
      default:
        return 'Grid View';
    }
  }

  String get getValue {
    switch (this) {
      case NoteViewType.list:
        return 'NoteViewTypeList';
      case NoteViewType.grid:
        return 'NoteViewTypeGrid';
      default:
        return 'NoteViewTypeGrid';
    }
  }
}

extension GetNoteViewType on String {
  NoteViewType get getNoteViewType {
    switch (this) {
      case 'NoteViewTypeList':
        return NoteViewType.list;
      case 'NoteViewTypeGrid':
        return NoteViewType.grid;
      default:
        return NoteViewType.grid;
    }
  }
}
