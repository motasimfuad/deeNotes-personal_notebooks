import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/note_entity.dart';
import '../repositories/note_repository.dart';

class FindNoteUsecase implements UseCase<NoteEntity, Params> {
  final NoteRepository repository;

  FindNoteUsecase(this.repository);

  @override
  Future<Either<Failure, NoteEntity>> call(Params params) async {
    return await repository.findNote(params.id);
  }
}

class Params extends Equatable {
  final int id;
  const Params({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}
