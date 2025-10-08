import 'dart:async';

import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GreetingCubit extends Cubit<String> {
  GreetingCubit() : super('');
  Timer? _timer;

  void startGreeting() {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(_getGreeting());
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return EviraLang.current.goodMorning;
    } else if (hour < 17) {
      return EviraLang.current.goodAfternoon;
    } else {
      return EviraLang.current.goodEvening;
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
