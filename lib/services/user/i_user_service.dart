abstract class IUserService {
  Future<void> createUser({
    required String id,
    String firstName,
    String lastName,
  });
}
