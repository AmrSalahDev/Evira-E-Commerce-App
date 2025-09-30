import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/shared_preferences_service.dart';
import 'package:evira_e_commerce/features/signup/domain/repos/signup_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignupRepo)
class SignupRepoImpl implements SignupRepo {
  @override
  Future<String?> signup({
    required String email,
    required String password,
    required bool remember,
  }) async {
    try {
      //   final credential = await FirebaseAuth.instance
      //       .createUserWithEmailAndPassword(email: email, password: password);

      //   if (credential.user != null) {
      //     getIt<SharedPreferencesService>().setBool('remember', remember);
      //   }
      //   return null;
      // } on FirebaseAuthException catch (e) {
      //   return mapFirebaseError(e.code);
    } catch (e) {
      return e.toString();
    }
  }

  String mapFirebaseError(String code) {
    switch (code) {
      case 'weak-password':
        return EviraLang.current.passwordTooWeak;
      case 'email-already-in-use':
        return EviraLang.current.emailAlreadyInUse;
      case 'too-many-requests':
        return EviraLang.current.tooManyRequests;
      case 'invalid-email':
        return EviraLang.current.invalidEmail;
      case 'operation-not-allowed':
        return EviraLang.current.operationNotAllowed;
      case 'network-request-failed':
        return EviraLang.current.networkError;
      default:
        return EviraLang.current.unknownError;
    }
  }
}
