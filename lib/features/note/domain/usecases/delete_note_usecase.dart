import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/note_repository.dart';

class DeleteNoteUsecase implements UseCase<int, Params> {
  final NoteRepository repository;
  DeleteNoteUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(Params params) async {
    return await repository.deleteNote(params.id);
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
