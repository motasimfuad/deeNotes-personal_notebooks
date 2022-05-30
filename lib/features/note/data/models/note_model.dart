import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:notebooks/data/models/label.dart';

import '../../../../data/data_providers/note_colors_provider.dart';

class NoteModel {
  int? id;
  String title;
  String description;
  bool isFavorite;
  bool? isLocked;
  Color color;
  DateTime? createdAt;
  int notebookId;
  List<Label>? labels;
  NoteModel({
    this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
    this.isLocked = false,
    required this.color,
    required this.notebookId,
    this.createdAt,
    this.labels,
  });

  NoteModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isFavorite,
    bool? isLocked,
    Color? color,
    DateTime? createdAt,
    int? notebookId,
    List<Label>? labels,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isLocked: isLocked ?? this.isLocked,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      labels: labels ?? this.labels,
      notebookId: notebookId ?? this.notebookId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFavorite': isFavorite,
      'isLocked': isLocked,
      'notebookId': notebookId,
      'color': color.value,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'labels': labels?.map((x) => x.toMap()).toList(),
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isFavorite: map['isFavorite'] == 1 ? true : false,
      isLocked: map['isLocked'] == 1 ? true : false,
      notebookId: map['notebookId'],
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

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, isFavorite: $isFavorite, isLocked: $isLocked, color: $color, createdAt: $createdAt, labels: $labels, notebookId: $notebookId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isFavorite == isFavorite &&
        other.isLocked == isLocked &&
        other.color == color &&
        other.notebookId == notebookId &&
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
        notebookId.hashCode ^
        labels.hashCode;
  }
}

// delete later
var noteColorsProvider = NoteColorsProvider();
final sampleNote = NoteModel(
  id: 32,
  title: 'This is the first note',
  description:
      'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
  color: noteColorsProvider.noteColors[20].color,
  notebookId: 1,
  labels: [
    Label(id: 01, name: 'label 1'),
    Label(id: 02, name: 'label 2'),
    Label(id: 03, name: 'label 3'),
    Label(id: 04, name: 'label 4'),
  ],
);
