import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notebooks/data/models/note_color.dart';

import '../../domain/entities/note_entity.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<NoteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
