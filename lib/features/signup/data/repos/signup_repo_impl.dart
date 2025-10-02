import 'package:evira_e_commerce/features/signup/domain/entities/signup_entity.dart';
import 'package:evira_e_commerce/features/signup/domain/repos/signup_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SignupRepo)
class SignupRepoImpl implements SignupRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<bool> signup({required SignupEntity signupEntity}) async {
    AuthResponse response = await supabase.auth.signUp(
      email: signupEntity.email,
      password: signupEntity.password,
    );

    // ✅ حالة نجاح كامل (تم التسجيل + session موجودة)
    if (response.user != null && response.session != null) {
      // if (remember) {
      //   await getIt<SharedPreferencesService>().setBool('remember', true);
      // }
      return true;
    }

    // ⚠️ حالة: الإيميل مستخدم أو محتاج تفعيل
    if (response.user != null && response.session == null) {
      // هنا ممكن تميّز بين إيميل موجود بالفعل أو مجرد محتاج confirmation
      return false;
    }
    return false;
  }
}
