import 'package:equatable/equatable.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../entities/note_entity.dart';
import '../repositories/note_repository.dart';

class UpdateNoteUsecase implements UseCase<int, Params> {
  final NoteRepository noteRepository;

  UpdateNoteUsecase(this.noteRepository);
  @override
  Future<Either<Failure, int>> call(params) async {
    return await noteRepository.updateNote(params.note);
  }
}

class Params extends Equatable {
  final NoteEntity note;
  const Params({
    required this.note,
  });
  @override
  List<Object> get props => [note];
}
