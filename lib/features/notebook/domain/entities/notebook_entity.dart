import 'package:equatable/equatable.dart';

import 'package:notebooks/features/note/domain/entities/note_entity.dart';

import '../../../../data/models/label.dart';

class NotebookEntity extends Equatable {
  int? id;
  String name;
  String cover;
  List<Label?>? labels;
  List<NoteEntity?>? notes;
  bool isLocked;
  NotebookEntity({
    this.id,
    required this.name,
    required this.cover,
    this.labels,
    this.notes,
    required this.isLocked,
  });

  @override
  List<Object?> get props => [];
}
