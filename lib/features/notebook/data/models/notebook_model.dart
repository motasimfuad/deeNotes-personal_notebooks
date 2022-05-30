import 'package:flutter/material.dart';

import 'package:notebooks/data/models/label.dart';
import 'package:notebooks/features/note/data/models/note_model.dart';

class NotebookModel {
  int? id;
  String name;
  String cover;
  List<Label?>? labels;
  List<NoteModel?>? notes;
  bool isLocked;
  NotebookModel({
    this.id,
    required this.name,
    required this.cover,
    this.labels,
    this.notes,
    this.isLocked = false,
  });

  NotebookModel copyWith({
    int? id,
    String? name,
    String? cover,
    List<Label?>? labels,
    List<NoteModel?>? notes,
    bool? isLocked,
  }) {
    return NotebookModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cover: cover ?? this.cover,
      labels: labels ?? this.labels,
      notes: notes ?? this.notes,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cover': cover,
      // 'labels': labels?.map((x) => x?.toMap()).toList(),
      // 'notes': notes?.map((x) => x?.toMap()).toList(),
      'isLocked': isLocked ? 1 : 0,
    };
  }

  factory NotebookModel.fromMap(Map<String, dynamic> map) {
    return NotebookModel(
      id: map['id']?.toInt(),
      name: map['name'] as String,
      cover: map['cover'] as String,
      // labels: map['labels']
      // // != null ? List<Label?>.from(map['labels']?.map((x) => Label?.fromMap(x)))
      // //     : null
      // ,
      // notes: map['notes']
      // // != null ? List<Note?>.from(map['notes']?.map((x) => Note?.fromMap(x))) : null
      // ,
      isLocked: (map['isLocked'] as int) == 1 ? true : false,
    );
  }

  @override
  String toString() {
    return 'Notebook(id: $id, name: $name, cover: $cover, labels: $labels, notes: $notes, isLocked: $isLocked)';
  }

  @override
  bool operator ==(covariant NotebookModel other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// delete later
final sampleNotebook = NotebookModel(
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
    NoteModel(
      id: 32,
      title: 'Note 1',
      description: 'description',
      color: Colors.red,
      notebookId: 1,
    ),
  ],
);