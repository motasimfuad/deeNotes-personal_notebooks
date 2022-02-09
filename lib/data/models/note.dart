import 'package:flutter/material.dart';

import 'package:notebooks/data/models/label.dart';
import 'package:notebooks/data/models/note_color.dart';
import 'package:notebooks/data/models/notebook.dart';

class Note {
  int id;
  String title;
  String description;
  bool isFavorite;
  Color color;
  Notebook notebook;
  List<Label>? labels;
  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.notebook,
    this.isFavorite = false,
    this.labels,
  });
}

final sampleNote = Note(
  id: 32,
  title: 'This is the first note',
  description:
      'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
  color: noteColors[20].color,
  notebook: Notebook(id: 1, cover: '', name: ''),
  labels: [
    Label(id: 01, name: 'label 1'),
    Label(id: 02, name: 'label 2'),
    Label(id: 03, name: 'label 3'),
    Label(id: 04, name: 'label 4'),
  ],
);
