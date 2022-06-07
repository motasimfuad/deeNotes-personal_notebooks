import 'package:dartz/dartz.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';

abstract class NoteRepository {
  Future<Either<Failure, int>> createNote(NoteEntity note);
  Future<Either<Failure, int>> updateNote(NoteEntity note);
  Future<Either<Failure, NoteEntity>> findNote(int id);
  Future<Either<Failure, List<NoteEntity>>> getAllNotes(int notebookId);
  Future<Either<Failure, int>> deleteNote(int noteId);
  Future<Either<Failure, int>> deleteAllNotes(int notebookId);
}
