import 'package:notebooks/core/error/exceptions.dart';
import 'package:notebooks/features/notebook/data/models/notebook_model.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';
import 'package:notebooks/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notebooks/features/notebook/domain/repositories/notebook_repository.dart';

import '../datasources/notebook_local_data_source.dart';

class NotebookRepositoryImpl implements NotebookRepository {
  final NotebookLocalDataSource _localDataSource;

  NotebookRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, int>> createNotebook(NotebookEntity notebook) async {
    NotebookModel notebookModel = NotebookModel(
      name: notebook.name,
      cover: notebook.cover,
      isLocked: notebook.isLocked,
    );

    try {
      final futureNotebook =
          await _localDataSource.createNotebook(notebookModel);
      return Right(futureNotebook);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteAllNotebooks() async {
    try {
      return Right(await _localDataSource.deleteAllNotebooks());
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteNotebook(int notebookId) async {
    try {
      return Right(await _localDataSource.deleteNotebook(notebookId));
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, NotebookEntity>> findNotebook(int id) async {
    try {
      final notebookModel = await _localDataSource.findNotebook(id);
      final notebookEntity = NotebookEntity(
        id: notebookModel.id,
        name: notebookModel.name,
        cover: notebookModel.cover,
        isLocked: notebookModel.isLocked,
      );
      return Right(notebookEntity);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<NotebookEntity>>> getAllNotebooks() async {
    try {
      final notebookModels = await _localDataSource.getAllNotebooks();
      final notebookEntities = notebookModels
          .map((notebookModel) => NotebookEntity(
                id: notebookModel.id,
                name: notebookModel.name,
                cover: notebookModel.cover,
                isLocked: notebookModel.isLocked,
              ))
          .toList();
      return Right(notebookEntities);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, int>> updateNotebook(NotebookEntity notebook) async {
    NotebookModel notebookModel = NotebookModel(
      id: notebook.id,
      name: notebook.name,
      cover: notebook.cover,
      isLocked: notebook.isLocked,
    );

    try {
      final futureNotebook =
          await _localDataSource.updateNotebook(notebookModel);
      return Right(futureNotebook);
    } on LocalException {
      return Left(LocalFailure());
    }
  }
}
