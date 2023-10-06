import 'package:pok3dex/domain/entities/pokemon.dart';

class PokemonModel {
  final int id;
  final String pokemon;
  final String type;
  final List<String> abilities;
  final int hitpoints;
  final List<String> evolutions;
  final String location;
  final String imageUrl;

  PokemonModel({
    required this.id,
    required this.pokemon,
    required this.type,
    required this.abilities,
    required this.hitpoints,
    required this.evolutions,
    required this.location,
    required this.imageUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        id: json["id"],
        pokemon: json["pokemon"],
        type: json["type"],
        abilities: List<String>.from(json["abilities"].map((x) => x)),
        hitpoints: json["hitpoints"],
        evolutions: List<String>.from(json["evolutions"].map((x) => x)),
        location: json["location"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pokemon": pokemon,
        "type": type,
        "abilities": List<dynamic>.from(abilities.map((x) => x)),
        "hitpoints": hitpoints,
        "evolutions": List<dynamic>.from(evolutions.map((x) => x)),
        "location": location,
        "image_url": imageUrl,
      };
  Pokemon toEntity() {
    return Pokemon(
      id: id,
      pokemon: pokemon,
      type: type,
      abilities: abilities,
      hitpoints: hitpoints,
      evolutions: evolutions,
      location: location,
      imageUrl: imageUrl,
    );
  }
}
