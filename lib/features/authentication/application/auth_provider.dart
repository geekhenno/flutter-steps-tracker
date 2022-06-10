import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/core/models/view_states.dart';
import 'package:flutter_steps_tracker/core/provider/base_provider.dart';
import 'package:flutter_steps_tracker/core/usecases/usecase.dart';
import 'package:flutter_steps_tracker/features/authentication/domain/usecases/is_sign_in_usecase.dart';
import 'package:flutter_steps_tracker/features/authentication/domain/usecases/sign_in_usecase.dart';

final authProvider =
    StateNotifierProvider<AuthProvider, ViewState>((ref) => AuthProvider(
          ref.watch(signInUseCaseProvider),
          ref.watch(isSignInUseCaseProvider),
        ));

class AuthProvider extends BaseProvider<UserCredential> {
  final SignInUsecase _signInUsecase;
  final IsSignInUsecase _isSignInUsecase;

  AuthProvider(
    this._signInUsecase,
    this._isSignInUsecase,
  );
  Future<void> signIn() async {
    setLoadingState();
    final response = await _signInUsecase.call(NoParams());
    response.fold((failure) {
      setErrorState(failure.message);
    }, (user) {
      if (user != null) {
        setLoadedState(user);
      }
    });
  }

  Future<bool> isSignIn() async {
    final response = await _isSignInUsecase.call(NoParams());
    bool isUserSignIn = false;
    response.fold((failure) {
      isUserSignIn = false;
    }, (isSign) {
      isUserSignIn = isSign;
    });
    return isUserSignIn;
  }
}
