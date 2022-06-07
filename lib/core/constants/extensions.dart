import 'package:intl/intl.dart';

extension OutputStrings on int? {
  String totalNotes() {
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
}

extension easyDate on DateTime {
  String get onlyDate {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
