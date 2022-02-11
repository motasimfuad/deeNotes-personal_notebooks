import 'package:flutter/cupertino.dart';
import 'package:notebooks/data/models/notebook.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String _dbName = 'notebooks.db';
const int _dbVersion = 1;

const String _notebookTableName = 'notebooks';
const String _notebookId = 'id';
const String _notebookName = 'name';
const String _notebookCover = 'cover';
const String _notebookLocked = 'isLocked';

class DataRepository {
  DataRepository._private();
  static final DataRepository instance = DataRepository._private();

  static Database? _database;

  // get database or throw error
  Database _getDatabaseOrThrow() {
    final db = _database;
    if (db != null) {
      return db;
    } else {
      debugPrint('db is not open');
      throw ('Thrown error: db is not open');
    }
  }

  // create database
  Future<Database?> createDatabase() async {
    if (_database != null) {
      return _database;
    }
    try {
      final direcrtory = await getApplicationDocumentsDirectory();
      final path = join(direcrtory.path, _dbName);
      await openDatabase(path, version: _dbVersion, onCreate: _onCreateDb);
      return _database;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  // delete database
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  // create notebook
  Future createNotebook(Notebook notebook) async {
    final db = _getDatabaseOrThrow();
    final notebookId = db.insert(
      _notebookTableName,
      notebook.toMap(),
    );
    return notebookId;
  }

  // update notebook
  Future updateNotebook(Notebook notebook) async {
    final db = _getDatabaseOrThrow();
    final count = await db.update(
      _notebookTableName,
      notebook.toMap(),
      where: '$_notebookId = ?',
      whereArgs: [notebook.id],
    );
    return count;
  }

  //fetch single notebook
  Future<Notebook> findNotebook(String notebookName) async {
    final db = _getDatabaseOrThrow();
    final result = await db.query(
      _notebookTableName,
      limit: 1,
      where: '$_notebookName = ?',
      whereArgs: [notebookName],
    );

    if (result.isNotEmpty) {
      return Notebook.fromMap(result.first);
    } else {
      throw 'no notebook found';
    }
  }

  // get all notebooks
  Future<List<Notebook>> getAllNotebooks() async {
    final db = _getDatabaseOrThrow();
    var allRows = await db.query(_notebookTableName);
    var notebooksIterable =
        allRows.map((notebook) => Notebook.fromMap(notebook));
    final notebooks = notebooksIterable.toList();
    return notebooks;
  }

  // delete notebook
  Future<void> deleteNotebook({required int notebookId}) async {
    final db = _getDatabaseOrThrow();
    final deleteCount = await db.delete(
      _notebookTableName,
      where: '$_notebookId = ?',
      whereArgs: [notebookId],
    );
  }

  // delete all notebooks
  Future<int> deleteAllNotebooks() async {
    final db = _getDatabaseOrThrow();
    return db.delete(_notebookTableName);
  }
}

void _onCreateDb(Database db, int version) async {
  await _createNotebooksTable(db);
  await _createNotesTable(db);
}

_createNotebooksTable(Database db) async {
  await db.execute(
      '''
        CREATE TABLE IF NOT EXISTS $_notebookTableName (
          $_notebookId	INTEGER NOT NULL,
          $_notebookName	TEXT NOT NULL,
          $_notebookCover	TEXT NOT NULL,
          $_notebookLocked	INTEGER DEFAULT 0,
          PRIMARY KEY("$_notebookId" AUTOINCREMENT)
          );
      ''');
}

_createNotesTable(Database db) {}
