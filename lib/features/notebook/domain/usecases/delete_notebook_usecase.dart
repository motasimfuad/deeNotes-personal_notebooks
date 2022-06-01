import 'package:equatable/equatable.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../../../notebook/domain/repositories/notebook_repository.dart';

class DeleteNotebookUsecase implements UseCase<void, Params> {
  final NotebookRepository notebookRepository;
  DeleteNotebookUsecase(this.notebookRepository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return await notebookRepository.deleteNotebook(params.id);
  }
}

class Params extends Equatable {
  final int id;
  const Params(this.id);
  @override
  List<Object> get props => [id];
}
