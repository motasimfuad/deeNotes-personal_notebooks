import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:notebooks/data/data_providers/note_colors_provider.dart';
import 'package:notebooks/data/models/note_color.dart';
import 'package:notebooks/features/note/domain/usecases/create_note_usecase.dart'
    as create;
import 'package:notebooks/features/note/domain/usecases/delete_all_notes_usecase.dart'
    as deleteAll;
import 'package:notebooks/features/note/domain/usecases/delete_note_usecase.dart'
    as delete;
import 'package:notebooks/features/note/domain/usecases/get_all_notes_usecase.dart'
    as getAll;
import 'package:notebooks/features/note/domain/usecases/update_note_usecase.dart'
    as update;
import '../../domain/usecases/find_note_usecase.dart' as find;

import '../../domain/entities/note_entity.dart';

part 'note_event.dart';
part 'note_state.dart';

String getAllError = "Notes could not be loaded!";
String createNoteError = "Note could not be created!";
String deleteErrMsg = "Deletion failed!";

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final create.CreateNoteUsecase createNote;
  final update.UpdateNoteUsecase updateNote;
  final find.FindNoteUsecase findNote;
  final getAll.GetAllNotesUsecase getAllNotes;
  final delete.DeleteNoteUsecase deleteNote;
  final deleteAll.DeleteAllNotesUsecase deleteAllNotes;
  final NoteColorsProvider noteColorsProvider;
  NoteBloc({
    required this.createNote,
    required this.updateNote,
    required this.findNote,
    required this.getAllNotes,
    required this.deleteNote,
    required this.deleteAllNotes,
    required this.noteColorsProvider,
  }) : super(NoteInitial()) {
    on<NoteEvent>((event, emit) async {
      if (event is GetAllNotesEvent) {
        emit(NotesListLoading());
        final params = getAll.Params(notebookId: event.notebookId);
        final either = await getAllNotes(params);
        either.fold(
          (failure) => emit(
            NotesListError(message: getAllError),
          ),
          (result) => emit(
            NotesListLoaded(notes: result),
          ),
        );
      }

      // create note
      if (event is CreateNoteEvent) {
        final params = create.Params(note: event.note);
        final either = await createNote(params);
        either.fold(
          (failure) => emit(
            NoteCreatedFailed(message: createNoteError),
          ),
          (result) => emit(
            NoteCreated(),
          ),
        );
      }

      // get all note colors
      if (event is GetAllNoteColorsEvent) {
        emit(NoteColorsLoadingState());
        var colors = noteColorsProvider.noteColors;
        emit(AllNoteColorsFetchedState(colors: colors));
      }

      // select note color
      if (event is SelectNoteColorEvent) {
        emit(NoteColorSelectedState(color: event.color));
      }
    });
  }
}
