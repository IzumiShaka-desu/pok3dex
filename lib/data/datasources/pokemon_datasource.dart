import 'package:pok3dex/app/services/base_client.dart';
import 'package:pok3dex/data/models/detail_pokemon_model.dart';
import 'package:pok3dex/data/models/pokemon_model.dart';

class PokemonDatasource extends BaseClient {
  Future<List<PokemonModel>> fetchPokemonList() => tryRequest(
        () async {
          final response = await get("/pokemon");
          return List<PokemonModel>.from(
            response.data.map((x) => PokemonModel.fromJson(x)),
          );
        },
      );
  Future<DetailPokemonModel> fetchDetailPokemon({required int id}) =>
      tryRequest(
        () async {
          final response = await get("/pokemon/$id");
          return DetailPokemonModel.fromJson(response.data);
        },
      );
}
