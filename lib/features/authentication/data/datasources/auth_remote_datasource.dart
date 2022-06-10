import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_steps_tracker/services/firebase/firebase_client.dart';

abstract class IAuthRemoteDataSource {
  Future<UserCredential?> signIn();
  Future<bool> isSignIn();
}

final authRemoteDataSourceImplProvider = Provider<AuthRemoteDataSourceImpl>(
    (ref) => AuthRemoteDataSourceImpl(ref.watch(firebaseClientProvider)));

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final FirebaseClient _firebaseClient;
  AuthRemoteDataSourceImpl(this._firebaseClient);

  @override
  Future<UserCredential?> signIn() async {
    return _firebaseClient.auth.signInAnonymously();
  }

  @override
  Future<bool> isSignIn() async {
    return _firebaseClient.auth.currentUser != null;
  }
}
