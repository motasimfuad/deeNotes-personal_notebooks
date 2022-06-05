import 'package:intl/intl.dart';

extension OutputStrings on int {
  String totalNotes() {
    return Intl.plural(
      this,
      zero: '0 notes',
      one: '$this note',
      other: '$this notes',
      name: "note",
      args: [this],
      examples: const {'quantity': 4},
      desc: "Total number of notes in the notebook",
    );
  }
}
