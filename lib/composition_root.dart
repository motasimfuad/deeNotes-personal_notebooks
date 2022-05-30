import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebooks/data/repositories/data_repository.dart';
import 'package:notebooks/presentation/screens/all_notebooks_screen/all_notebooks_screen.dart';
import 'package:sqflite/sqflite.dart';

class CompositionRoot {
  static Database? _db;

  static configure() async {
    _db = await DataRepository.instance.createDatabase();
  }

  static Widget composeAllNotebooksUi() {
    return MultiBlocProvider(
      providers: const [],
      child: const AllNotebooksScreen(),
    );
  }
}
