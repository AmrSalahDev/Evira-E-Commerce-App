import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fill_profile_state.dart';

class FillProfileCubit extends Cubit<FillProfileState> {
  FillProfileCubit() : super(FillProfileInitial());
}
