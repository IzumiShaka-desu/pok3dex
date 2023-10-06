import 'package:pok3dex/app/utils/exception.dart';
import 'package:pok3dex/app/utils/type_definition.dart';
import 'package:pok3dex/domain/entities/detail_pokemon.dart';
import 'package:pok3dex/domain/repositories/pokemon_repository.dart';

import '../datasources/pokemon_datasource.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  PokemonRepositoryImpl({
    required PokemonDatasource pokemonDatasource,
  }) : _pokemonDatasource = pokemonDatasource;
  final PokemonDatasource _pokemonDatasource;
  @override
  Future<DetailPokemonOrFailure> getDetailPokemon(int id) =>
      tryCatch<DetailPokemon>(() async {
        final response = await _pokemonDatasource.fetchDetailPokemon(id: id);
        return response.toEntity();
      });

  @override
  Future<PokemonsOrFailure> getPokemonList() => tryCatch(() async {
        final response = await _pokemonDatasource.fetchPokemonList();
        return response.map((e) => e.toEntity()).toList();
      });
}
