import 'package:get_it/get_it.dart';
import 'package:pok3dex/data/repositories/pokemon_repository.dart';

import '../data/datasources/pokemon_datasource.dart';
import '../domain/repositories/pokemon_repository.dart';
import '../domain/usecases/get_detail_pokemon.dart';
import '../domain/usecases/get_pokemons.dart';
import '../presentation/cubit/detail/detail_cubit.dart';
import '../presentation/cubit/home/home_cubit.dart';

final locator = GetIt.instance;

void init() {
  // datasources
  locator.registerLazySingleton(() => PokemonDatasource());
  // repositories
  locator.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(pokemonDatasource: locator()),
  );
  // usecases
  locator.registerLazySingleton(() => GetPokemons(locator()));
  locator.registerLazySingleton(() => GetDetailPokemon(locator()));
  // cubits
  locator.registerFactory(() => HomeCubit(getPokemons: locator()));
  locator.registerFactory(() => DetailCubit(getDetailPokemon: locator()));
}
