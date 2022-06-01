import 'package:equatable/equatable.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../../../notebook/domain/entities/notebook_entity.dart';
import '../../../notebook/domain/repositories/notebook_repository.dart';

class FindNotebookUsecase implements UseCase<NotebookEntity, Params> {
  final NotebookRepository notebookRepository;
  FindNotebookUsecase(this.notebookRepository);

  @override
  Future<Either<Failure, NotebookEntity>> call(params) async {
    return await notebookRepository.findNotebook(params.id);
  }
}

class Params extends Equatable {
  final int id;
  const Params(this.id);
  @override
  List<Object> get props => [id];
}
