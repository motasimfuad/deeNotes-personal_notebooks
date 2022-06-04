import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notebooks/data/data_providers/notebook_covers_provider.dart';

import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';
import 'package:notebooks/features/notebook/domain/usecases/create_notebook_usecase.dart'
    as create;
import 'package:notebooks/features/notebook/domain/usecases/delete_all_notebooks_usecase.dart';
import 'package:notebooks/features/notebook/domain/usecases/delete_notebook_usecase.dart';
import 'package:notebooks/features/notebook/domain/usecases/find_notebook_usecase.dart'
    as find;
import 'package:notebooks/features/notebook/domain/usecases/get_all_notebooks_usecase.dart';
import 'package:notebooks/features/notebook/domain/usecases/update_notebook_usecase.dart';

import '../../../../core/usecases/usecase.dart';

part 'notebook_event.dart';
part 'notebook_state.dart';

String errMsg = "Something went wrong!";

/// add the required usecases to the bloc
/// receive the response from the usecase inside the bloc body as either and then use [.fold] method to handle the response as failure or success and then emit the states

class NotebookBloc extends Bloc<NotebookEvent, NotebookState> {
  GetAllNotebooksUsecase getAllNotebooks;
  create.CreateNotebookUsecase createNotebook;
  find.FindNotebookUsecase findNotebook;
  UpdateNotebookUsecase updateNotebook;
  DeleteNotebookUsecase deleteNotebook;
  DeleteAllNotebooksUsecase deleteAllNotebooks;

  NotebookBloc({
    required this.getAllNotebooks,
    required this.createNotebook,
    required this.findNotebook,
    required this.updateNotebook,
    required this.deleteNotebook,
    required this.deleteAllNotebooks,
  }) : super(NotebookInitial()) {
    on<NotebookEvent>((event, emit) async {
      if (event is GetAllNotebooksEvent) {
        emit(NotebookListLoading());
        final either = await getAllNotebooks(NoParams());
        either.fold(
          (failure) => emit(NotebookListError(message: errMsg)),
          (result) => emit(NotebookListLoaded(notebooks: result)),
        );
      }
      if (event is CreateNotebookEvent) {
        emit(NotebookListLoading());
        final params = create.Params(notebook: event.notebook);
        final either = await createNotebook(params);
        either.fold(
          (failure) => emit(NotebookCreatedFailed(message: errMsg)),
          (result) => emit(NotebookCreated()),
        );
      }

      if (event is FindNotebookEvent) {
        emit(NotebookLoading());
        final params = find.Params(id: event.id);
        final either = await findNotebook(params);
        print('called find notebook');
        either.fold(
          (failure) => emit(NotebookListError(message: errMsg)),
          (result) => emit(NotebookLoaded(notebook: result)),
        );
      }

      if (event is ViewNotebookOnCreatePageEvent) {
        print(event.cover?.name);
        emit(ViewNotebookOnCreatePageState(
          cover: event.cover!,
          notebookName: event.notebookName,
        ));
      }
    });
  }
}
