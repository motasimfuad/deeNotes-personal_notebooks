import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String _dbName = 'notebooks.db';
const int _dbVersion = 1;

const String _notebooksTableName = 'notebooks';
const String _id = 'id';
const String _name = 'name';
const String _cover = 'cover';
const String _locked = 'isLocked';

const String _notesTableName = 'noteTable';
const String _notebookId = 'notebookId';
const String _title = 'title';
const String _description = 'description';
const String _isFavorite = 'isFavorite';
const String _isLocked = 'isLocked';
const String _color = 'color';
const String _createdAt = 'createdAt';
const String _editedAt = 'editedAt';

class DataRepository {
  DataRepository._private();
  static final DataRepository instance = DataRepository._private();

  static Database? _database;

  // get database or throw error
  Future<Database> getDatabaseOrThrow() async {
    final db = _database;
    if (db != null) {
      return db;
    } else {
      final newDb = await createDatabase();
      return newDb as Database;
      // debugPrint('db is not open');
      // throw ('Thrown error: db is not open');
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
  // Future createNotebook(NotebookModel notebook) async {
  //   final db = await getDatabaseOrThrow();
  //   final notebookId = db.insert(
  //     _notebookTable,
  //     notebook.toMap(),
  //   );
  //   return notebookId;
  // }

  // update notebook
  // Future updateNotebook(NotebookModel notebook) async {
  //   final db = await getDatabaseOrThrow();
  //   final count = await db.update(
  //     _notebookTable,
  //     notebook.toMap(),
  //     where: '$_notebookId = ?',
  //     whereArgs: [notebook.id],
  //   );
  //   return count;
  // }

  //read single notebook
  // Future<NotebookModel> findNotebook(int id) async {
  //   final db = await getDatabaseOrThrow();
  //   final result = await db.query(
  //     _notebookTable,
  //     limit: 1,
  //     where: '$_notebookId = ?',
  //     whereArgs: [id],
  //   );

  //   if (result.isNotEmpty) {
  //     return NotebookModel.fromMap(result.first);
  //   } else {
  //     throw Exception('ID $id not found!');
  //   }
  // }

  // get all notebooks
  // Future<List<NotebookModel>> getAllNotebooks() async {
  //   final db = await getDatabaseOrThrow();
  //   var allRows = await db.query(_notebookTable);
  //   var notebooksIterable =
  //       allRows.map((notebook) => NotebookModel.fromMap(notebook));
  //   final notebooks = notebooksIterable.toList();
  //   log(notebooks.toString());
  //   return notebooks;
  // }

  // delete notebook
  // Future<int> deleteNotebook({required int notebookId}) async {
  //   final db = await getDatabaseOrThrow();
  //   final deleteCount = await db.delete(
  //     _notebookTable,
  //     where: '$_notebookId = ?',
  //     whereArgs: [notebookId],
  //   );
  //   return deleteCount;
  // }

  // delete all notebooks
  // Future<int> deleteAllNotebooks() async {
  //   final db = await getDatabaseOrThrow();
  //   return db.delete(_notebookTable);
  // }
}

void _onCreateDb(Database db, int version) async {
  await _createNotebooksTable(db);
  await _createNotesTable(db);
}

_createNotebooksTable(Database db) async {
  await db.execute(
      '''
        CREATE TABLE IF NOT EXISTS $_notebooksTableName (
          $_id	INTEGER NOT NULL,
          $_name	TEXT NOT NULL,
          $_cover	TEXT NOT NULL,
          $_locked	INTEGER DEFAULT 0,
          PRIMARY KEY("$_id" AUTOINCREMENT)
          );
      ''');
}

_createNotesTable(Database db) async {
  await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS $_notesTableName
      (
        "$_id"	INTEGER NOT NULL,
        "$_title"	TEXT NOT NULL,
        "$_description"	TEXT,
        "$_notebookId"	INTEGER NOT NULL,
        "$_isFavorite"	INTEGER DEFAULT 0,
        "$_isLocked"	INTEGER DEFAULT 0,
        "$_color"	TEXT NOT NULL,
        "$_createdAt"	TEXT NOT NULL,
        "$_editedAt"	TEXT DEFAULT null,
	      FOREIGN KEY("$_notebookId") REFERENCES "$_notebooksTableName"("$_id"),
	      PRIMARY KEY("$_id" AUTOINCREMENT)
      )
    ''');
}
