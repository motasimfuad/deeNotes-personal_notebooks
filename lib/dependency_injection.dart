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

final di = GetIt.instance;

Future<void> init() async {
  //! Features
  // Blocs
  di.registerFactory(() => NotebookBloc(
        getAllNotebooks: di(),
        createNotebook: di(),
        findNotebook: di(),
        updateNotebook: di(),
        deleteNotebook: di(),
        deleteAllNotebooks: di(),
      ));

  // UseCases
  di.registerLazySingleton(() => GetAllNotebooksUsecase(di()));
  di.registerLazySingleton(() => CreateNotebookUsecase(di()));
  di.registerLazySingleton(() => FindNotebookUsecase(di()));
  di.registerLazySingleton(() => UpdateNotebookUsecase(di()));
  di.registerLazySingleton(() => DeleteNotebookUsecase(di()));
  di.registerLazySingleton(() => DeleteAllNotebooksUsecase(di()));

  // Repositories
  di.registerLazySingleton<NotebookRepository>(
    () => NotebookRepositoryImpl(di()),
  );

  //data sources
  di.registerLazySingleton<NotebookLocalDataSource>(
    () => NotebookLocalDataSourceImpl(dataRepo: di()),
  );

  //! core

  //! data
  di.registerLazySingleton<DataRepository>(() => DataRepository.instance);
}
