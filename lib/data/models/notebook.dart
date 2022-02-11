import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  Notebook copyWith({
    int? id,
    String? name,
    String? cover,
    List<Label?>? labels,
    List<Note?>? notes,
    bool? isLocked,
  }) {
    return Notebook(
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
      'labels': labels?.map((x) => x?.toMap()).toList(),
      'notes': notes?.map((x) => x?.toMap()).toList(),
      'isLocked': isLocked,
    };
  }

  factory Notebook.fromMap(Map<String, dynamic> map) {
    return Notebook(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      cover: map['cover'] ?? '',
      labels: map['labels'] != null
          ? List<Label?>.from(map['labels']?.map((x) => Label?.fromMap(x)))
          : null,
      notes: map['notes'] != null
          ? List<Note?>.from(map['notes']?.map((x) => Note?.fromMap(x)))
          : null,
      isLocked: map['isLocked'] == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notebook.fromJson(String source) =>
      Notebook.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notebook(id: $id, name: $name, cover: $cover, labels: $labels, notes: $notes, isLocked: $isLocked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notebook &&
        other.id == id &&
        other.name == name &&
        other.cover == cover &&
        listEquals(other.labels, labels) &&
        listEquals(other.notes, notes) &&
        other.isLocked == isLocked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        cover.hashCode ^
        labels.hashCode ^
        notes.hashCode ^
        isLocked.hashCode;
  }
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
