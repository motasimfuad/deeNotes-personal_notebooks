import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/label.dart';

class NoteEntity extends Equatable {
  final int? id;
  final String title;
  final String description;
  final bool? isFavorite;
  final bool? isLocked;
  final Color color;
  final DateTime? createdAt;
  final DateTime? editedAt;
  final int notebookId;
  final List<Label>? labels;
  const NoteEntity({
    this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
    this.isLocked,
    required this.color,
    this.createdAt,
    this.editedAt,
    required this.notebookId,
    this.labels,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isFavorite,
        isLocked,
        color,
        createdAt,
        notebookId,
        labels,
      ];
}
