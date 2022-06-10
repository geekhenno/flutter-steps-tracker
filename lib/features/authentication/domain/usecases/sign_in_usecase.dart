import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';
import 'package:flutter_steps_tracker/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:flutter_steps_tracker/features/authentication/domain/repositories/auth_repository.dart';

final signInUseCaseProvider = Provider<SignInUsecase>(
    (ref) => SignInUsecase(ref.watch(authRepositoryImplProvider)));

class SignInUsecase implements UseCase<UserCredential?, NoParams> {
  final IAuthRepository _authRepository;

  SignInUsecase(this._authRepository);

  @override
  Future<Either<Failure, UserCredential?>> call(NoParams params) async {
    return await _authRepository.signIn();
  }
}
