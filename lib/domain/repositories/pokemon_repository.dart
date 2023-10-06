import 'package:pok3dex/app/utils/type_definition.dart';

abstract class PokemonRepository {
  Future<DetailPokemonOrFailure> getDetailPokemon(int id);
  Future<PokemonsOrFailure> getPokemonList();
}
