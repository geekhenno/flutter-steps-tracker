import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/errors/failure.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';
import 'package:flutter_steps_tracker/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:flutter_steps_tracker/features/authentication/domain/repositories/auth_repository.dart';

final isSignInUseCaseProvider = Provider<IsSignInUsecase>(
    (ref) => IsSignInUsecase(ref.watch(authRepositoryImplProvider)));

class IsSignInUsecase implements UseCase<bool, NoParams> {
  final IAuthRepository _authRepository;

  IsSignInUsecase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _authRepository.isSignIn();
  }
}
