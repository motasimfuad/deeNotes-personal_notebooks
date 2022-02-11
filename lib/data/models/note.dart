import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:notebooks/data/models/label.dart';
import 'package:notebooks/data/models/notebook.dart';

import '../data_providers/note_colors_provider.dart';

class Note {
  int? id;
  String title;
  String description;
  bool isFavorite;
  bool? isLocked;
  Color color;
  DateTime? createdAt;
  Notebook notebook;
  List<Label>? labels;
  Note({
    this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
    this.isLocked = false,
    required this.color,
    required this.notebook,
    this.createdAt,
    this.labels,
  });

  Note copyWith({
    int? id,
    String? title,
    String? description,
    bool? isFavorite,
    bool? isLocked,
    Color? color,
    DateTime? createdAt,
    Notebook? notebook,
    List<Label>? labels,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isLocked: isLocked ?? this.isLocked,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      labels: labels ?? this.labels,
      notebook: notebook ?? this.notebook,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFavorite': isFavorite,
      'isLocked': isLocked,
      'notebook': notebook,
      'color': color.value,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'labels': labels?.map((x) => x.toMap()).toList(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      isLocked: map['isLocked'],
      notebook: map['notebook'],
      color: Color(map['color']),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      labels: map['labels'] != null
          ? List<Label>.from(map['labels']?.map((x) => Label.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, isFavorite: $isFavorite, isLocked: $isLocked, color: $color, createdAt: $createdAt, labels: $labels, notebook: $notebook)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isFavorite == isFavorite &&
        other.isLocked == isLocked &&
        other.color == color &&
        other.notebook == notebook &&
        other.createdAt == createdAt &&
        listEquals(other.labels, labels);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isFavorite.hashCode ^
        isLocked.hashCode ^
        color.hashCode ^
        createdAt.hashCode ^
        notebook.hashCode ^
        labels.hashCode;
  }
}

// delete later
var noteColorsProvider = NoteColorsProvider();
final sampleNote = Note(
  id: 32,
  title: 'This is the first note',
  description:
      'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
  color: noteColorsProvider.noteColors[20].color,
  notebook: Notebook(id: 1, cover: '', name: ''),
  labels: [
    Label(id: 01, name: 'label 1'),
    Label(id: 02, name: 'label 2'),
    Label(id: 03, name: 'label 3'),
    Label(id: 04, name: 'label 4'),
  ],
);
