part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NotesListLoading extends NoteState {}

class NotesListLoaded extends NoteState {
  final List<NoteEntity> notes;
  const NotesListLoaded({required this.notes});
  @override
  List<Object> get props => [notes];
}

class NotesListError extends NoteState {
  final String message;
  const NotesListError({required this.message});
  @override
  List<Object> get props => [message];
}

class NoteCreated extends NoteState {}

class NoteCreatedFailed extends NoteState {
  final String message;
  const NoteCreatedFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NoteUpdated extends NoteState {
  final NoteEntity note;
  const NoteUpdated({required this.note});
  @override
  List<Object> get props => [note];
}

class NoteUpdateFailed extends NoteState {
  final String message;
  const NoteUpdateFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NoteDeleted extends NoteState {}

class NoteDeletedFailed extends NoteState {
  final String message;
  const NoteDeletedFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final NoteEntity note;
  const NoteLoaded({required this.note});
  @override
  List<Object> get props => [note];
}

class NoteColorsLoadingState extends NoteState {}

class AllNoteColorsFetchedState extends NoteState {
  final List<NoteColor> colors;
  const AllNoteColorsFetchedState({required this.colors});
  @override
  List<Object> get props => [colors];
}

class NoteColorSelectedState extends NoteState {
  final NoteColor color;
  const NoteColorSelectedState({
    required this.color,
  });
  @override
  List<Object> get props => [color];
}
