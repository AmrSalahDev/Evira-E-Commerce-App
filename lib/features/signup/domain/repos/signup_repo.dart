import 'package:evira_e_commerce/features/signup/domain/entities/signup_entity.dart';

abstract class SignupRepo {
  Future<bool> signup({required SignupEntity signupEntity});
}
