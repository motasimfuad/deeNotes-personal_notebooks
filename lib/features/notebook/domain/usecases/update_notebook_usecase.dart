import 'package:equatable/equatable.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../entities/notebook_entity.dart';
import '../repositories/notebook_repository.dart';

class UpdateNotebookUsecase implements UseCase<int, Params> {
  final NotebookRepository notebookRepository;
  UpdateNotebookUsecase(this.notebookRepository);

  @override
  Future<Either<Failure, int>> call(params) async {
    return await notebookRepository.updateNotebook(params.notebook);
  }
}

class Params extends Equatable {
  final NotebookEntity notebook;
  const Params(this.notebook);
  @override
  List<Object> get props => [notebook];
}
