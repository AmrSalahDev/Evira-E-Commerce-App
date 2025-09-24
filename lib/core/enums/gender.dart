import 'package:evira_e_commerce/core/lang_generated/l10n.dart';

enum Gender { male, female, other }

extension GenderExtension on Gender {
  String get title {
    switch (this) {
      case Gender.male:
        return EviraLang.current.male;
      case Gender.female:
        return EviraLang.current.female;
      case Gender.other:
        return EviraLang.current.other;
    }
  }
}
