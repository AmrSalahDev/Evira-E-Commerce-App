import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TextFieldCubit extends Cubit<bool> {
  TextFieldCubit() : super(true);

  void isEmpty(bool value) => emit(value);
}
