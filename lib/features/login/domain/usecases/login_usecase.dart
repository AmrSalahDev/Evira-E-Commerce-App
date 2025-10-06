import 'package:evira_e_commerce/features/login/domain/entities/login_entity.dart';
import 'package:evira_e_commerce/features/login/domain/repos/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUsecase {
  final LoginRepo loginRepo;
  LoginUsecase(this.loginRepo);
  Future<void> call(LoginEntity loginEntity) => loginRepo.login(loginEntity);
}
