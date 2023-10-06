import 'package:pok3dex/app/utils/type_definition.dart';

import '../repositories/pokemon_repository.dart';

class GetDetailPokemon {
  final PokemonRepository _repository;

  GetDetailPokemon(PokemonRepository repository) : _repository = repository;

  Future<DetailPokemonOrFailure> execute(int id) async {
    return await _repository.getDetailPokemon(id);
  }
}
