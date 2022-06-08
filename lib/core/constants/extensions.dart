import 'package:intl/intl.dart';

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
