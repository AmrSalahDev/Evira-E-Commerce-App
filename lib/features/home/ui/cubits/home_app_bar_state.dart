part of 'home_app_bar_cubit.dart';

class HomeAppBarState extends Equatable {
  final HomeAppBarEntity? data;
  final bool isLoading;
  final String? error;

  const HomeAppBarState({this.data, this.isLoading = false, this.error});

  HomeAppBarState copyWith({
    HomeAppBarEntity? data,
    bool? isLoading,
    String? error,
  }) {
    return HomeAppBarState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [data, isLoading, error];
}
