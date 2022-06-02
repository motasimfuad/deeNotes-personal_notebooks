import 'dart:async';

import 'package:notebooks/data/repositories/data_repository.dart';
import 'package:notebooks/features/notebook/data/models/notebook_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class NotebookLocalDataSource {
  Future<int> createNotebook(NotebookModel notebook);
  Future<int> updateNotebook(NotebookModel notebook);
  Future<NotebookModel> findNotebook(int id);
  Future<List<NotebookModel>> getAllNotebooks();
  Future<int> deleteNotebook(int notebookId);
  Future<int> deleteAllNotebooks();
}

const String _notebookTable = 'notebooks';
const String _notebookId = 'id';

class NotebookLocalDataSourceImpl implements NotebookLocalDataSource {
  final DataRepository _db = DataRepository.instance;

  @override
  Future<int> createNotebook(NotebookModel notebook) async {
    final db = await _db.getDatabaseOrThrow();
    final notebookId = db.insert(
      _notebookTable,
      notebook.toMap(),
    );
    return notebookId;
  }

  @override
  Future<int> deleteAllNotebooks() async {
    final db = await _db.getDatabaseOrThrow();
    return db.delete(_notebookTable);
  }

  @override
  Future<int> deleteNotebook(int notebookId) async {
    final db = await _db.getDatabaseOrThrow();
    final deleteCount = await db.delete(
      _notebookTable,
      where: '$_notebookId = ?',
      whereArgs: [notebookId],
    );
    return deleteCount;
  }

  @override
  Future<NotebookModel> findNotebook(int id) async {
    final db = await _db.getDatabaseOrThrow();
    final result = await db.query(
      _notebookTable,
      limit: 1,
      where: '$_notebookId = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return NotebookModel.fromMap(result.first);
    } else {
      throw LocalException;
      // throw Exception('ID $id not found!');
    }
  }

  @override
  Future<List<NotebookModel>> getAllNotebooks() async {
    final db = await _db.getDatabaseOrThrow();
    var allRows = await db.query(_notebookTable);
    var notebooksIterable =
        allRows.map((notebook) => NotebookModel.fromMap(notebook));
    final notebooks = notebooksIterable.toList();
    return notebooks;
  }

  @override
  Future<int> updateNotebook(NotebookModel notebook) async {
    final db = await _db.getDatabaseOrThrow();
    final count = await db.update(
      _notebookTable,
      notebook.toMap(),
      where: '$_notebookId = ?',
      whereArgs: [notebook.id],
    );
    return count;
  }
}
