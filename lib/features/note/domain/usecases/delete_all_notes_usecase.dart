import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/note_repository.dart';

class GetAllNotesUsecase implements UseCase<int, Params> {
  final NoteRepository repository;
  GetAllNotesUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(Params params) async {
    return await repository.deleteAllNotes(params.notebookId);
  }
}

class Params extends Equatable {
  final int notebookId;
  const Params({
    required this.notebookId,
  });
  @override
  List<Object> get props => [notebookId];
}
