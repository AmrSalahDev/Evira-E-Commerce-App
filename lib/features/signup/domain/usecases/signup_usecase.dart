import 'package:evira_e_commerce/features/signup/domain/repos/signup_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUsecase {
  final SignupRepo signupRepo;
  SignupUsecase({required this.signupRepo});

  Future<String?> call({
    required String email,
    required String password,
    required bool remember,
  }) => signupRepo.signup(email: email, password: password, remember: remember);
}
