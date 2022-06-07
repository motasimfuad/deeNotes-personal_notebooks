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

class NotebookCreatedFailed extends NotebookState {
  final String message;
  const NotebookCreatedFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NotebookUpdated extends NotebookState {
  final NotebookEntity notebook;
  const NotebookUpdated({required this.notebook});
  @override
  List<Object> get props => [notebook];
}

class NotebookUpdateFailed extends NotebookState {
  final String message;
  const NotebookUpdateFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NotebookDeleted extends NotebookState {}

class NotebookDeletedFailed extends NotebookState {
  final String message;
  const NotebookDeletedFailed({required this.message});
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

class ViewNotebookCoverState extends NotebookState {
  final NotebookCover cover;
  const ViewNotebookCoverState({
    required this.cover,
  });
  @override
  List<Object> get props => [cover];
}
