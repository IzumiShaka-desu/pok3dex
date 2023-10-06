import 'package:equatable/equatable.dart';

import '../../../domain/entities/pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_pokemons.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required GetPokemons getPokemons,
  })  : _getPokemons = getPokemons,
        super(HomeInitial());

  final GetPokemons _getPokemons;

  Future<void> getPokemonsList() async {
    emit(HomeLoading());
    final pokemonsOrFailure = await _getPokemons();
    pokemonsOrFailure.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (pokemons) => emit(HomeLoaded(pokemons: pokemons)),
    );
  }
}
