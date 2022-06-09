import 'package:notebooks/data/models/label.dart';
import 'package:notebooks/features/note/data/models/note_model.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

class NotebookModel extends NotebookEntity {
  NotebookModel({
    int? id,
    required String name,
    required String cover,
    List<Label?>? labels,
    List<NoteEntity?>? notes,
    required bool isLocked,
  }) : super(
          id: id,
          name: name,
          cover: cover,
          labels: labels,
          notes: notes,
          isLocked: isLocked,
        );

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

  NotebookModel fromEntity(NotebookEntity notebookEntity) => NotebookModel(
        id: notebookEntity.id,
        name: notebookEntity.name,
        cover: notebookEntity.cover,
        labels: notebookEntity.labels,
        notes: notebookEntity.notes,
        isLocked: notebookEntity.isLocked,
      );

  @override
  String toString() {
    return 'Notebook(id: $id, name: $name, cover: $cover, labels: $labels, notes: $notes, isLocked: $isLocked)';
  }

  @override
  bool operator ==(covariant NotebookModel other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}
