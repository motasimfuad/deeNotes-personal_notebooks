import 'dart:convert';

import 'package:notebooks/data/models/label.dart';
import 'package:notebooks/data/models/note_color.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';

import '../../../../data/data_providers/note_colors_provider.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    int? id,
    required String title,
    required String description,
    bool? isFavorite,
    bool? isLocked,
    required NoteColor noteColor,
    required DateTime createdAt,
    DateTime? editedAt,
    required int notebookId,
    List<Label>? labels,
  }) : super(
          id: id,
          title: title,
          description: description,
          isFavorite: isFavorite,
          isLocked: isLocked,
          noteColor: noteColor,
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
    NoteColor? noteColor,
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
      noteColor: noteColor ?? this.noteColor,
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
      'isFavorite': isFavorite == true ? 1 : 0,
      'isLocked': isLocked == true ? 1 : 0,
      'notebookId': notebookId,
      'noteColor': noteColor.toJson(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'editedAt': editedAt?.millisecondsSinceEpoch,
      // 'labels': labels?.map((x) => x.toMap()).toList(),
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
      noteColor: NoteColor.fromJson(map['noteColor']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      editedAt: map['editedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['editedAt'])
          : null,
      // labels: map['labels'] != null
      //     ? List<Label>.from(map['labels']?.map((x) => Label.fromMap(x)))
      //     : null,
    );
  }

  String toJson() {
    var encoded = json.encode(toMap());
    print('encoded: $encoded');
    return encoded;
  }

  factory NoteModel.fromJson(String source) {
    return NoteModel.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, isFavorite: $isFavorite, isLocked: $isLocked, noteColor: $noteColor, createdAt: $createdAt, editedAt: $editedAt, labels: $labels, notebookId: $notebookId)';
  }
}

// delete later
var noteColorsProvider = NoteColorsProvider();
final sampleNote = NoteModel(
  id: 32,
  title: 'This is the first note',
  description:
      'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
  noteColor: noteColorsProvider.noteColors[20],
  notebookId: 1,
  createdAt: DateTime.now(),
  // labels: [
  //   Label(id: 01, name: 'label 1'),
  //   Label(id: 02, name: 'label 2'),
  //   Label(id: 03, name: 'label 3'),
  //   Label(id: 04, name: 'label 4'),
  // ],
);
