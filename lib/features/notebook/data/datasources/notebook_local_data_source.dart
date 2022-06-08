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

class NotebookLocalDataSourceImpl implements NotebookLocalDataSource {
  final DataRepository dataRepo;
  NotebookLocalDataSourceImpl({required this.dataRepo});

  @override
  Future<int> createNotebook(NotebookModel notebook) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final notebookId = db.insert(
      notebooksTableName,
      notebook.toMap(),
    );
    return notebookId;
  }

  @override
  Future<int> deleteAllNotebooks() async {
    final db = await dataRepo.getDatabaseOrCreate();
    return await db.delete(notebooksTableName);
  }

  @override
  Future<int> deleteNotebook(int notebookId) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final deleteCount = await db.delete(
      notebooksTableName,
      where: '$idField = ?',
      whereArgs: [notebookId],
    );
    return deleteCount;
  }

  @override
  Future<NotebookModel> findNotebook(int id) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final result = await db.query(
      notebooksTableName,
      limit: 1,
      where: '$idField = ?',
      whereArgs: [id],
    );

    print(idField);

    if (result.isNotEmpty) {
      return NotebookModel.fromMap(result.first);
    } else {
      throw LocalException;
      // throw Exception('ID $id not found!');
    }
  }

  @override
  Future<List<NotebookModel>> getAllNotebooks() async {
    final db = await dataRepo.getDatabaseOrCreate();
    var allRows = await db.query(notebooksTableName);
    var notebooksIterable =
        allRows.map((notebook) => NotebookModel.fromMap(notebook));
    final notebooks = notebooksIterable.toList();
    return notebooks;
  }

  @override
  Future<int> updateNotebook(NotebookModel notebook) async {
    final db = await dataRepo.getDatabaseOrCreate();
    final count = await db.update(
      notebooksTableName,
      notebook.toMap(),
      where: '$idField = ?',
      whereArgs: [notebook.id],
    );
    return count;
  }
}
