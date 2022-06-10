import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/datasources/redeeming_remote_datasource.dart';
import 'package:flutter_steps_tracker/features/redeeming/data/models/redeeming_items_model.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/entities/redeeming_entity.dart';
import 'package:flutter_steps_tracker/features/redeeming/domain/repositories/redeeming_repository.dart';

final redeemingPartnersRepositoryImplProvider =
    Provider<RedeemingRepositoryImpl>((ref) => RedeemingRepositoryImpl(
        ref.watch(redeemingRemoteDataSourceImplProvider)));

class RedeemingRepositoryImpl implements IRedeemingRepository {
  final IRedeemingRemoteDataSource _iRedeemingRemoteDataSource;
  RedeemingRepositoryImpl(this._iRedeemingRemoteDataSource);
  @override
  Future<Either<Failure, List<RedeemingEntity>?>>
      getAllRedeemingPartners() async {
    try {
      final response =
          await _iRedeemingRemoteDataSource.getAllRedeemingPartners();

      return Right(response);
    } on SocketException {
      return const Left(InternetFailure());
    } on FirebaseAuthException {
      return const Left(
          FirebaseFailure(message: 'Can not fetch redeeming partners'));
    }
  }

  @override
  Future<Either<Failure, bool>> redeem(RedeemingItemsModel item) async {
    try {
      final response = await _iRedeemingRemoteDataSource.redeem(item);

      return Right(response);
    } on SocketException {
      return const Left(InternetFailure());
    } on FirebaseAuthException {
      return const Left(FirebaseFailure(message: 'Can not  redeem '));
    }
  }

  @override
  Future<Either<Failure, List<RedeemingItemsModel>?>> getHistoryRedeem(
      String userId) async {
    try {
      final response =
          await _iRedeemingRemoteDataSource.getHistoryRedeem(userId);

      return Right(response);
    } on SocketException {
      return const Left(InternetFailure());
    } on FirebaseAuthException {
      return const Left(
          FirebaseFailure(message: 'Can not get history  redeem '));
    }
  }
}
