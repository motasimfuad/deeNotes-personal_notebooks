import 'package:equatable/equatable.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/core/usecases/usecase.dart';
import 'package:notebooks/features/note/domain/repositories/note_repository.dart';

import '../entities/note_entity.dart';

class CreateNoteUseCase implements UseCase<int, Params> {
  final NoteRepository repository;
  CreateNoteUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(params) async {
    return await repository.createNote(params.note);
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
