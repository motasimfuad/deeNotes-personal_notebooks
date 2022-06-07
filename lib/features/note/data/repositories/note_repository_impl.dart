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
  Future<Either<Failure, int>> deleteNote(int noteId) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NoteEntity>> findNote(int id) {
    // TODO: implement findNote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes(int notebookId) {
    // TODO: implement getAllNotes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> updateNote(NoteEntity note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
