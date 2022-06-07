import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:notebooks/data/models/label.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';

import '../../../../data/data_providers/note_colors_provider.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    int? id,
    required String title,
    required String description,
    bool? isFavorite,
    bool? isLocked,
    required Color color,
    DateTime? createdAt,
    DateTime? editedAt,
    required int notebookId,
    List<Label>? labels,
  }) : super(
          id: id,
          title: title,
          description: description,
          isFavorite: isFavorite,
          isLocked: isLocked,
          color: color,
          createdAt: createdAt,
          editedAt: editedAt,
          notebookId: notebookId,
          labels: labels,
        );

  NoteModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isFavorite,
    bool? isLocked,
    Color? color,
    DateTime? createdAt,
    DateTime? editedAt,
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
      editedAt: editedAt ?? this.editedAt,
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
      'editedAt': editedAt?.millisecondsSinceEpoch,
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
      editedAt: map['editedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['editedAt'])
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
    return 'Note(id: $id, title: $title, description: $description, isFavorite: $isFavorite, isLocked: $isLocked, color: $color, createdAt: $createdAt, editedAt: $editedAt, labels: $labels, notebookId: $notebookId)';
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
