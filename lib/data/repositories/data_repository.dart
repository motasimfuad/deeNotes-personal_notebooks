import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:notebooks/features/notebook/data/models/notebook.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String _dbName = 'notebooks.db';
const int _dbVersion = 1;

const String _notebookTable = 'notebooks';
const String _notebookId = 'id';
const String _notebookName = 'name';
const String _notebookCover = 'cover';
const String _notebookLocked = 'isLocked';

class DataRepository {
  DataRepository._private();
  static final DataRepository instance = DataRepository._private();

  static Database? _database;

  // get database or throw error
  Future<Database> _getDatabaseOrThrow() async {
    final db = _database;
    if (db != null) {
      return db;
    } else {
      await createDatabase();
      debugPrint('db is not open');
      throw ('Thrown error: db is not open');
    }
  }

  // create database
  // ignore: body_might_complete_normally_nullable
  Future<Database?> createDatabase() async {
    if (_database != null) {
      return _database;
    } else {
      try {
        final directory = await getApplicationDocumentsDirectory();
        final path = join(directory.path, _dbName);
        _database = await openDatabase(path,
            version: _dbVersion, onCreate: _onCreateDb);
        return _database;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
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
    final db = await _getDatabaseOrThrow();
    final notebookId = db.insert(
      _notebookTable,
      notebook.toMap(),
    );
    return notebookId;
  }

  // update notebook
  Future updateNotebook(Notebook notebook) async {
    final db = await _getDatabaseOrThrow();
    final count = await db.update(
      _notebookTable,
      notebook.toMap(),
      where: '$_notebookId = ?',
      whereArgs: [notebook.id],
    );
    return count;
  }

  //read single notebook
  Future<Notebook> findNotebook(int id) async {
    final db = await _getDatabaseOrThrow();
    final result = await db.query(
      _notebookTable,
      limit: 1,
      where: '$_notebookId = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Notebook.fromMap(result.first);
    } else {
      throw Exception('ID $id not found!');
    }
  }

  // get all notebooks
  Future<List<Notebook>> getAllNotebooks() async {
    final db = await _getDatabaseOrThrow();
    var allRows = await db.query(_notebookTable);
    var notebooksIterable =
        allRows.map((notebook) => Notebook.fromMap(notebook));
    final notebooks = notebooksIterable.toList();
    log(notebooks.toString());
    return notebooks;
  }

  // delete notebook
  Future<int> deleteNotebook({required int notebookId}) async {
    final db = await _getDatabaseOrThrow();
    final deleteCount = await db.delete(
      _notebookTable,
      where: '$_notebookId = ?',
      whereArgs: [notebookId],
    );
    return deleteCount;
  }

  // delete all notebooks
  Future<int> deleteAllNotebooks() async {
    final db = await _getDatabaseOrThrow();
    return db.delete(_notebookTable);
  }
}

void _onCreateDb(Database db, int version) async {
  await _createNotebooksTable(db);
  // await _createNotesTable(db);
}

_createNotebooksTable(Database db) async {
  await db.execute('''
        CREATE TABLE IF NOT EXISTS $_notebookTable (
          $_notebookId	INTEGER NOT NULL,
          $_notebookName	TEXT NOT NULL,
          $_notebookCover	TEXT NOT NULL,
          $_notebookLocked	INTEGER DEFAULT 0,
          PRIMARY KEY("$_notebookId" AUTOINCREMENT)
          );
      ''');
}

_createNotesTable(Database db) {}
