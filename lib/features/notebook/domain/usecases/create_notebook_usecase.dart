import 'package:equatable/equatable.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/core/usecases/usecase.dart';
import 'package:notebooks/features/notebook/domain/repositories/notebook_repository.dart';

import '../../../notebook/domain/entities/notebook_entity.dart';

class CreateNotebookUsecase implements UseCase<int, Params> {
  final NotebookRepository notebookRepository;
  CreateNotebookUsecase(this.notebookRepository);

  @override
  Future<Either<Failure, int>> call(Params params) async {
    return await notebookRepository.createNotebook(params.notebook);
  }
}

class Params extends Equatable {
  final NotebookEntity notebook;
  const Params(this.notebook);
  @override
  List<Object> get props => [notebook];
}
