import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyUserService {
  Future<bool> isProfileFilled() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) return false;

    final data = await Supabase.instance.client
        .from('users')
        .select('is_profile_filled')
        .eq('id', user.id)
        .maybeSingle();

    final isProfileFilled = data?['is_profile_filled'] ?? false;

    return isProfileFilled;
  }
}
