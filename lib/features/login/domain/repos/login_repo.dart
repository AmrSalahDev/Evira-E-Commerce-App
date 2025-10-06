import 'package:evira_e_commerce/features/login/domain/entities/login_entity.dart';

abstract class LoginRepo {
  Future<void> login(LoginEntity loginEntity);
}
