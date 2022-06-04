import 'package:get_it/get_it.dart';
import 'package:notebooks/data/repositories/data_repository.dart';
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

final getIt = GetIt.instance;

Future<void> init() async {
  //! Features
  // Blocs
  getIt.registerFactory(() => NotebookBloc(
        getAllNotebooks: getIt(),
        createNotebook: getIt(),
        findNotebook: getIt(),
        updateNotebook: getIt(),
        deleteNotebook: getIt(),
        deleteAllNotebooks: getIt(),
      ));

  // UseCases
  getIt.registerLazySingleton(() => GetAllNotebooksUsecase(getIt()));
  getIt.registerLazySingleton(() => CreateNotebookUsecase(getIt()));
  getIt.registerLazySingleton(() => FindNotebookUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateNotebookUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteNotebookUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAllNotebooksUsecase(getIt()));

  // Repositories
  getIt.registerLazySingleton<NotebookRepository>(
    () => NotebookRepositoryImpl(getIt()),
  );

  //data sources
  getIt.registerLazySingleton<NotebookLocalDataSource>(
    () => NotebookLocalDataSourceImpl(dataRepo: getIt()),
  );

  //! core

  //! data
  getIt.registerLazySingleton<DataRepository>(() => DataRepository.instance);
}
