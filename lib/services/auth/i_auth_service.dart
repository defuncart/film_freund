abstract class IAuthService {
  bool get isUserAuthenicated;

  Future<AuthResult> signin({required String email, required String password});

  Future<void> signout();
}

enum AuthResult {
  createSuccess,
  signinSuccess,
  signinIncorrectPassword,
  other,
}
