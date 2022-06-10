import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_steps_tracker/features/authentication/domain/repositories/auth_repository.dart';

final authRepositoryImplProvider =
    Provider<AuthRepositoryImpl>((ref) => AuthRepositoryImpl(
          ref.watch(authRemoteDataSourceImplProvider),
        ));

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> isSignIn() async {
    try {
      final isSignIn = await _authRemoteDataSource.isSignIn();

      if (isSignIn) {
        return Right(isSignIn);
      }
      return const Left(UnAuthenticatedFailure(message: 'User not signed in'));
    } on SocketException {
      return const Left(InternetFailure());
    } on FirebaseAuthException {
      return const Left(FirebaseFailure(message: 'Can not Sign in'));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signIn() async {
    try {
      final authResponse = await _authRemoteDataSource.signIn();

      return Right(authResponse);
    } on SocketException {
      return const Left(InternetFailure());
    } on FirebaseAuthException {
      return const Left(FirebaseFailure(message: 'Can not Sign in'));
    }
  }

  @override
  Future<Either<Failure, void>> updateDisplayName(String name) {
    // TODO: implement updateDisplayName
    throw UnimplementedError();
  }
}
