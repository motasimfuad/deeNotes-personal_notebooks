// Dummy file

import 'package:sqflite/sqflite.dart';

class DataRepository {
  DataRepository._private();
  static final DataRepository instance = DataRepository._private();

  static Database? _database;

  Future<Database?> get createDatabase async {
    if (_database != null) {
      return _database;
    }
    return _database;
  }
}
