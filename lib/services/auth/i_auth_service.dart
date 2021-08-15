abstract class IAuthService {
  Future<AuthResult> signin({required String email, required String password});
}

enum AuthResult {
  success,
  noInternet,
  incorrectPassword,
  other,
}
