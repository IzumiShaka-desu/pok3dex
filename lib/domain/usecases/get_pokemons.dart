import 'package:pok3dex/app/utils/type_definition.dart';

import '../repositories/pokemon_repository.dart';

class GetPokemons {
  final PokemonRepository _repository;

  GetPokemons(PokemonRepository repository) : _repository = repository;

  Future<PokemonsOrFailure> call() async {
    return await _repository.getPokemonList();
  }
}
