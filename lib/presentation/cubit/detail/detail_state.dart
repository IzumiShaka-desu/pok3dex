part of 'detail_cubit.dart';

abstract class DetailState extends Equatable {
  const DetailState();
  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final DetailPokemon detailPokemon;
  const DetailLoaded({required this.detailPokemon});
  @override
  List<Object> get props => [detailPokemon];
}

class DetailError extends DetailState {
  final String message;
  const DetailError({required this.message});
  @override
  List<Object> get props => [message];
}
