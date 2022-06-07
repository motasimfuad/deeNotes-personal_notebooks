import 'package:notebooks/core/error/exceptions.dart';
import 'package:notebooks/data/repositories/data_repository.dart';
import 'package:notebooks/features/note/data/models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<int> createNote(NoteModel note);
  Future<int> updateNote(NoteModel note);
  Future<NoteModel> findNote(int id);
  Future<List<NoteModel>> getAllNotes(int notebookId);
  Future<int> deleteNote(int noteId);
  Future<int> deleteAllNotes(int notebookId);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final DataRepository dataRepo;
  NoteLocalDataSourceImpl({required this.dataRepo});

  @override
  Future<int> createNote(NoteModel note) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final noteId = db.insert(
      notesTableName,
      note.toMap(),
    );
    return noteId;
  }

  @override
  Future<int> deleteAllNotes(int notebookId) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final deleteCount = await db.delete(
      notesTableName,
      where: '$notesTableName.notebookId = ?',
      whereArgs: [notebookId],
    );
    return deleteCount;
  }

  @override
  Future<int> deleteNote(int noteId) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final deleteCount = await db.delete(
      notesTableName,
      where: '$id = ?',
      whereArgs: [noteId],
    );
    if (deleteCount == 0) {
      throw LocalException();
    } else {
      return deleteCount;
    }
  }

  @override
  Future<NoteModel> findNote(int id) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final result = await db.query(
      notesTableName,
      limit: 1,
      where: '$id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      final note = NoteModel.fromMap(result.first);
      return note;
    } else {
      throw LocalException();
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes(int notebookId) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final result = await db.query(
      notesTableName,
      where: '$notesTableName.notebookId = ?',
      whereArgs: [notebookId],
    );
    final notesIterable = result.map((e) => NoteModel.fromMap(e));
    final notes = notesIterable.toList();
    return notes;
  }

  @override
  Future<int> updateNote(NoteModel note) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final count = await db.update(
      notesTableName,
      note.toMap(),
      where: '$id = ?',
      whereArgs: [note.id],
    );
    return count;
  }
}
