import 'package:dartz/dartz.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

abstract class NotebookRepository {
  Future<Either<Failure, int>> createNotebook(NotebookEntity notebook);
  Future<Either<Failure, int>> updateNotebook(NotebookEntity notebook);
  Future<Either<Failure, NotebookEntity>> findNotebook(int id);
  Future<Either<Failure, List<NotebookEntity>>> getAllNotebooks();
  Future<Either<Failure, int>> deleteNotebook(int notebookId);
  Future<Either<Failure, int>> deleteAllNotebooks();
}
