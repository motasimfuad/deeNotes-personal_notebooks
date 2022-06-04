part of 'notebook_bloc.dart';

abstract class NotebookState extends Equatable {
  const NotebookState();

  @override
  List<Object> get props => [];
}

class NotebookInitial extends NotebookState {}

class NotebookListLoading extends NotebookState {}

class NotebookListLoaded extends NotebookState {
  final List<NotebookEntity> notebooks;
  const NotebookListLoaded({required this.notebooks});
  @override
  List<Object> get props => [notebooks];
}

class NotebookListError extends NotebookState {
  final String message;
  const NotebookListError({required this.message});
  @override
  List<Object> get props => [message];
}

class NotebookCreated extends NotebookState {}

class NotebookUpdated extends NotebookState {
  final NotebookEntity notebook;
  const NotebookUpdated({required this.notebook});
  @override
  List<Object> get props => [notebook];
}

class NotebookDeleted extends NotebookState {
  final int notebookId;
  const NotebookDeleted({required this.notebookId});
  @override
  List<Object> get props => [notebookId];
}

class NotebookCreatedFailed extends NotebookState {
  final String message;
  const NotebookCreatedFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NotebookLoading extends NotebookState {}

class NotebookLoaded extends NotebookState {
  final NotebookEntity notebook;
  const NotebookLoaded({required this.notebook});
  @override
  List<Object> get props => [notebook];
}

class ViewNotebookOnCreatePageState extends NotebookState {
  final String? notebookName;
  final NotebookCover cover;
  const ViewNotebookOnCreatePageState({
    this.notebookName,
    required this.cover,
  });
  @override
  List<Object> get props => [
        cover
        // notebookName as String,
      ];
}
