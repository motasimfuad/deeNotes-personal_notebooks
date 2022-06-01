import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../../../notebook/domain/repositories/notebook_repository.dart';

class DeleteAllNotebooksUsecase implements UseCase<int, NoParams> {
  final NotebookRepository notebookRepository;
  DeleteAllNotebooksUsecase(this.notebookRepository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await notebookRepository.deleteAllNotebooks();
  }
}
