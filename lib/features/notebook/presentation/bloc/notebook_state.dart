part of 'notebook_bloc.dart';

abstract class NotebookState extends Equatable {
  const NotebookState();  

  @override
  List<Object> get props => [];
}
class NotebookInitial extends NotebookState {}
