import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserCredential?>> signIn();
  Future<Either<Failure, bool>> isSignIn();
  Future<Either<Failure, void>> updateDisplayName(String name);
}
