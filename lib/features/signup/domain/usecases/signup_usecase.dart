import 'package:evira_e_commerce/features/signup/domain/entities/signup_entity.dart';
import 'package:evira_e_commerce/features/signup/domain/repos/signup_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUsecase {
  final SignupRepo signupRepo;
  SignupUsecase({required this.signupRepo});

  Future<bool> call({required SignupEntity signupEntity}) =>
      signupRepo.signup(signupEntity: signupEntity);
}
