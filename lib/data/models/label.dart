import 'package:notebooks/data/models/note.dart';

class Label {
  int id;
  String name;
  List<Note>? notes;
  Label({
    required this.id,
    required this.name,
    this.notes,
  });
}
