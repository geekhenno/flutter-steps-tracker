abstract class Failure {
  final String message;
  const Failure(this.message);
}

// General failures

class InternetFailure extends Failure {
  const InternetFailure({String? message})
      : super(message ?? 'No internet connection detected, please try again.');
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({String? message})
      : super(message ?? 'Firebase Failure');
}

class UnAuthenticatedFailure extends Failure {
  const UnAuthenticatedFailure({String? message})
      : super(message ?? 'UnAuthenticated Failure');
}
