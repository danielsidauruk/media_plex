part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

  @override
  List<Object?> get props => [];
}

class GetForPopular extends PopularEvent {
  const GetForPopular(this.dataSortQuery);
  final String dataSortQuery;

  @override
  List<Object?> get props => [];
}
