abstract class IAuthService {
  Future<AuthResult> signin({required String email, required String password});

  Future<void> signout();
}

enum AuthResult {
  success,
  noInternet,
  incorrectPassword,
  other,
}
