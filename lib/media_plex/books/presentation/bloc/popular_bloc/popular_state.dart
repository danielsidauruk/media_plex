part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object?> get props => [];
}

class PopularEmpty extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  const PopularLoaded ({required this.popular});
  final Popular popular;

  @override
  List<Object?> get props => [popular];
}

class PopularError extends PopularState {
  const PopularError ({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}