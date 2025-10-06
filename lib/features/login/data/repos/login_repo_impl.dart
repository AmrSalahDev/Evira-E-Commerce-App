import 'package:evira_e_commerce/features/login/domain/entities/login_entity.dart';
import 'package:evira_e_commerce/features/login/domain/repos/login_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  @override
  Future<void> login(LoginEntity loginEntity) async {
    await Supabase.instance.client.auth.signInWithPassword(
      email: loginEntity.email,
      password: loginEntity.password,
    );
  }
}
