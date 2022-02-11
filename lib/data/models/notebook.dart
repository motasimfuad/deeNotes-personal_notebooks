import 'package:flutter/material.dart';

import 'package:notebooks/data/models/label.dart';
import 'package:notebooks/data/models/note.dart';

class Notebook {
  int? id;
  String name;
  String cover;
  List<Label?>? labels;
  List<Note?>? notes;
  bool? isLocked;
  Notebook({
    this.id,
    required this.name,
    required this.cover,
    this.labels,
    this.notes,
    this.isLocked = false,
  });

  //
}

// delete later
final sampleNotebook = Notebook(
  id: 1,
  name: 'Travel',
  cover: 'assets/images/notebooks/bg-1.jpg',
  labels: [
    Label(id: 1, name: 'Label 1'),
    Label(id: 1, name: 'LABEL 2'),
    Label(id: 1, name: 'LABEL 2'),
    Label(id: 1, name: 'LABEL 2'),
    Label(id: 1, name: 'LABEL 2'),
    Label(id: 1, name: 'LABEL 2'),
    Label(id: 1, name: 'LABEL 2'),
  ],
  notes: [
    Note(
      id: 32,
      title: 'Note 1',
      description: 'description',
      color: Colors.red,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
    Note(
      id: 31,
      title: 'Note 2',
      description: 'description 2',
      color: Colors.pink,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
    Note(
      id: 31,
      title: 'Note 2',
      description: 'description 2' * 150,
      color: Colors.purple,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
    Note(
      id: 31,
      title: 'Note 2',
      description: 'description 2',
      color: Colors.black,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
    Note(
      id: 31,
      title: 'Note 2',
      description: 'description 2',
      color: Colors.black,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
    Note(
      id: 31,
      title: 'Note 2',
      description: 'description 2',
      color: Colors.black,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
    Note(
      id: 31,
      title: 'Note 2',
      description: 'description 2',
      color: Colors.black,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
    Note(
      id: 31,
      title: 'Note 2',
      description: 'description 2',
      color: Colors.black,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
    Note(
      id: 31,
      title: 'Note 2',
      description: 'description 2',
      color: Colors.black,
      notebook: Notebook(id: 1, cover: '', name: ''),
    ),
  ],
);
