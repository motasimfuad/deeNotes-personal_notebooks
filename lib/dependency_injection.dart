import 'package:get_it/get_it.dart';
import 'package:notebooks/data/data_providers/note_colors_provider.dart';
import 'package:notebooks/data/repositories/data_repository.dart';
import 'package:notebooks/features/note/data/datasources/note_local_data_source.dart';
import 'package:notebooks/features/note/domain/repositories/note_repository.dart';
import 'package:notebooks/features/note/domain/usecases/delete_all_notes_usecase.dart';
import 'package:notebooks/features/note/domain/usecases/delete_note_usecase.dart';
import 'package:notebooks/features/note/domain/usecases/find_note_usecase.dart';
import 'package:notebooks/features/note/domain/usecases/get_all_notes_usecase.dart';
import 'package:notebooks/features/note/presentation/bloc/note_bloc.dart';
import 'package:notebooks/features/notebook/data/datasources/notebook_local_data_source.dart';
import 'package:notebooks/features/notebook/data/repositories/notebook_repository_impl.dart';
import 'package:notebooks/features/notebook/domain/repositories/notebook_repository.dart';
import 'package:notebooks/features/notebook/domain/usecases/create_notebook_usecase.dart';
import 'package:notebooks/features/notebook/domain/usecases/delete_all_notebooks_usecase.dart';
import 'package:notebooks/features/notebook/domain/usecases/delete_notebook_usecase.dart';
import 'package:notebooks/features/notebook/domain/usecases/find_notebook_usecase.dart';
import 'package:notebooks/features/notebook/domain/usecases/get_all_notebooks_usecase.dart';
import 'package:notebooks/features/notebook/domain/usecases/update_notebook_usecase.dart';
import 'package:notebooks/features/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:notebooks/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/note/data/repositories/note_repository_impl.dart';
import 'features/note/domain/usecases/create_note_usecase.dart';
import 'features/note/domain/usecases/update_note_usecase.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! Features
  // Blocs
  getIt.registerFactory(
    () => NotebookBloc(
      getAllNotebooks: getIt(),
      createNotebook: getIt(),
      findNotebook: getIt(),
      updateNotebook: getIt(),
      deleteNotebook: getIt(),
      deleteAllNotebooks: getIt(),
    ),
  );

  getIt.registerFactory(
    () => NoteBloc(
      createNote: getIt(),
      updateNote: getIt(),
      findNote: getIt(),
      getAllNotes: getIt(),
      deleteNote: getIt(),
      deleteAllNotes: getIt(),
      noteColorsProvider: getIt(),
    ),
  );

  getIt.registerFactory(() => SettingsBloc(pref: getIt()));

  // UseCases
  // notebook usecases
  getIt.registerLazySingleton(() => GetAllNotebooksUsecase(getIt()));
  getIt.registerLazySingleton(() => CreateNotebookUsecase(getIt()));
  getIt.registerLazySingleton(() => FindNotebookUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateNotebookUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteNotebookUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAllNotebooksUsecase(getIt()));
  // note usecases
  getIt.registerLazySingleton(() => CreateNoteUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateNoteUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteNoteUsecase(getIt()));
  getIt.registerLazySingleton(() => GetAllNotesUsecase(getIt()));
  getIt.registerLazySingleton(() => FindNoteUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAllNotesUsecase(getIt()));

  // Repositories
  getIt.registerLazySingleton<NotebookRepository>(
      () => NotebookRepositoryImpl(getIt()));

  getIt
      .registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl(getIt()));

  //data sources
  getIt.registerLazySingleton<NotebookLocalDataSource>(
    () => NotebookLocalDataSourceImpl(dataRepo: getIt()),
  );

  getIt.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSourceImpl(dataRepo: getIt()),
  );

  //! core

  //! data
  getIt.registerLazySingleton<DataRepository>(() => DataRepository.instance);
  getIt.registerLazySingleton<NoteColorsProvider>(() => NoteColorsProvider());

  var sharedPref = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton<SharedPreferences>(() => sharedPref);
  getIt.registerSingleton<SharedPreferences>(sharedPref);
}
