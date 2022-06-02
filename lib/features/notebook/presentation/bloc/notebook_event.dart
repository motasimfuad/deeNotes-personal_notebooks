part of 'notebook_bloc.dart';

abstract class NotebookEvent extends Equatable {
  const NotebookEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotebooksEvent extends NotebookEvent {
  const GetAllNotebooksEvent();
}

class CreateNotebookEvent extends NotebookEvent {
  final NotebookEntity notebook;
  const CreateNotebookEvent(this.notebook);
  @override
  List<Object> get props => [notebook];
}

class UpdateNotebookEvent extends NotebookEvent {
  final NotebookEntity notebook;
  const UpdateNotebookEvent(this.notebook);
  @override
  List<Object> get props => [notebook];
}

class FindNotebookEvent extends NotebookEvent {
  final int id;
  const FindNotebookEvent(this.id);
  @override
  List<Object> get props => [id];
}

class DeleteNotebookEvent extends NotebookEvent {
  final int notebookId;
  const DeleteNotebookEvent(this.notebookId);
  @override
  List<Object> get props => [notebookId];
}

class DeleteAllNotebooksEvent extends NotebookEvent {
  const DeleteAllNotebooksEvent();
}
