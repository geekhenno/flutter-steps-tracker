import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:flutter_steps_tracker/features/dashboard/domain/usecases/update_steps_points_usecase.dart';

final dashboardRepositoryImplProvider = Provider<DashboardRepositoryImpl>(
    (ref) => DashboardRepositoryImpl(
        ref.watch(dashboardRemoteDataSourceImplProvider)));

class DashboardRepositoryImpl implements IDashboardRepository {
  final IDashboardRemoteDataSource _dashboardRemoteDataSource;
  DashboardRepositoryImpl(this._dashboardRemoteDataSource);
  @override
  Future<Either<Failure, List<DashboardEntity>?>> getUserDashboard() async {
    try {
      final response = await _dashboardRemoteDataSource.getUserDashboard();

      return Right(response);
    } on SocketException {
      return const Left(InternetFailure());
    } on FirebaseAuthException {
      return const Left(FirebaseFailure(message: 'Can not fetch dashboard'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserStepsAndPoints(
      UpdateStepsPointsParams params) async {
    try {
      final response =
          await _dashboardRemoteDataSource.updateStepsPoint(params);

      return Right(response);
    } on SocketException {
      return const Left(InternetFailure());
    } on FirebaseAuthException {
      return const Left(FirebaseFailure(message: 'Can not fetch dashboard'));
    }
  }
}
