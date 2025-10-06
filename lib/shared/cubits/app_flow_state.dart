part of 'app_flow_cubit.dart';

sealed class AppFlowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppFlowInitial extends AppFlowState {}

class AppFlowPathState extends AppFlowState {
  final String path;

  AppFlowPathState(this.path);
  @override
  List<Object?> get props => [path];
}
