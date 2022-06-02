import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

part 'notebook_event.dart';
part 'notebook_state.dart';

class NotebookBloc extends Bloc<NotebookEvent, NotebookState> {
  NotebookBloc() : super(NotebookInitial()) {
    on<NotebookEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
