import 'package:notebooks/features/note/data/datasources/note_local_data_source.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/features/note/domain/repositories/note_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _localDataSource;
  NoteRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, int>> createNote(NoteEntity note) async {
    NoteModel noteModel = NoteModel(
      id: note.id,
      notebookId: note.notebookId,
      title: note.title,
      description: note.description,
      color: note.color,
      isFavorite: note.isFavorite,
      isLocked: note.isLocked,
      createdAt: note.createdAt,
      editedAt: note.editedAt,
    );
    try {
      final futureNote = await _localDataSource.createNote(noteModel);
      return Right(futureNote);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteAllNotes(int notebookId) async {
    try {
      final deleteCount = await _localDataSource.deleteAllNotes(notebookId);
      return Right(deleteCount);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteNote(int noteId) async {
    try {
      final count = await _localDataSource.deleteNote(noteId);
      return Right(count);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, NoteEntity>> findNote(int id) async {
    try {
      final noteModel = await _localDataSource.findNote(id);
      final noteEntity = NoteEntity(
        id: noteModel.id,
        notebookId: noteModel.notebookId,
        title: noteModel.title,
        description: noteModel.description,
        color: noteModel.color,
        isFavorite: noteModel.isFavorite,
        isLocked: noteModel.isLocked,
        createdAt: noteModel.createdAt,
        editedAt: noteModel.editedAt,
      );
      return Right(noteEntity);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes(int notebookId) async {
    try {
      final noteModels = await _localDataSource.getAllNotes(notebookId);
      final noteEntities = noteModels
          .map(
            (noteModel) => NoteEntity(
              id: noteModel.id,
              notebookId: noteModel.notebookId,
              title: noteModel.title,
              description: noteModel.description,
              color: noteModel.color,
              isFavorite: noteModel.isFavorite,
              isLocked: noteModel.isLocked,
              createdAt: noteModel.createdAt,
              editedAt: noteModel.editedAt,
            ),
          )
          .toList();
      return Right(noteEntities);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, int>> updateNote(NoteEntity note) async {
    try {
      NoteModel noteModel = NoteModel(
        id: note.id,
        notebookId: note.notebookId,
        title: note.title,
        description: note.description,
        color: note.color,
        isFavorite: note.isFavorite,
        isLocked: note.isLocked,
        createdAt: note.createdAt,
        editedAt: note.editedAt,
      );
      final count = await _localDataSource.updateNote(noteModel);
      return Right(count);
    } on LocalException {
      return Left(LocalFailure());
    }
  }
}
