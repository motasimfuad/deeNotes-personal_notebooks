import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/core/usecases/usecase.dart';

import '../../../notebook/domain/entities/notebook_entity.dart';
import '../../../notebook/domain/repositories/notebook_repository.dart';

class GetAllNotebooksUsecase
    implements UseCase<List<NotebookEntity>, NoParams> {
  final NotebookRepository notebookRepository;
  GetAllNotebooksUsecase(this.notebookRepository);

  @override
  Future<Either<Failure, List<NotebookEntity>>> call(NoParams params) async {
    return await notebookRepository.getAllNotebooks();
  }
}
