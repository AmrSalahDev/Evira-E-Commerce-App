abstract class SignupRepo {
  Future<String?> signup({
    required String email,
    required String password,
    required bool remember,
  });
}
