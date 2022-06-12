import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String _dbName = 'notebooks.db';
const int _dbVersion = 1;

const String notebooksTableName = 'notebooks';
const String notesTableName = 'noteTable';
const String idField = 'id';
const String notebookIdField = 'notebookId';

const String _name = 'name';
const String _cover = 'cover';
const String _locked = 'isLocked';

const String _title = 'title';
const String _description = 'description';
const String _isFavorite = 'isFavorite';
const String _isLocked = 'isLocked';
const String _noteColor = 'noteColor';
const String _createdAt = 'createdAt';
const String _editedAt = 'editedAt';

class DataRepository {
  DataRepository._private();
  static final DataRepository instance = DataRepository._private();

  static Database? _database;

  // get database or throw error
  Future<Database> getDatabaseOrCreate() async {
    final db = _database;
    if (db != null) {
      return db;
    } else {
      final newDb = await createDatabase();
      return newDb as Database;
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
        _database = await openDatabase(
          path,
          version: _dbVersion,
          onCreate: _onCreateDb,
        );
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
      db.close();
      _database = null;
      databaseFactory.deleteDatabase(db.path);
    }
  }
}

void _onCreateDb(Database db, int version) async {
  await _createNotebooksTable(db);
  await _createNotesTable(db);
}

_createNotebooksTable(Database db) async {
  await db.execute(
      '''
        CREATE TABLE IF NOT EXISTS $notebooksTableName (
          $idField	INTEGER NOT NULL,
          $_name	TEXT NOT NULL,
          $_cover	TEXT NOT NULL,
          $_locked	INTEGER DEFAULT 0,
          PRIMARY KEY("$idField" AUTOINCREMENT)
          );
      ''');
}

_createNotesTable(Database db) async {
  await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS $notesTableName
      (
        "$idField"	INTEGER NOT NULL,
        "$_title"	TEXT NOT NULL,
        "$_description"	TEXT,
        "$notebookIdField"	INTEGER NOT NULL,
        "$_isFavorite"	INTEGER DEFAULT 0,
        "$_isLocked"	INTEGER DEFAULT 0,
        "$_noteColor"	TEXT NOT NULL,
        "$_createdAt"	INTEGER NOT NULL,
        "$_editedAt"	INTEGER DEFAULT null,
	      FOREIGN KEY("$notebookIdField") REFERENCES "$notebooksTableName"("$idField"),
	      PRIMARY KEY("$idField" AUTOINCREMENT)
      )
    ''');
}
