class DetailPokemon {
  final int id;
  final String pokemon;
  final String type;
  final List<String> abilities;
  final int hitpoints;
  final List<String> evolutions;
  final String location;
  final String imageUrl;

  DetailPokemon({
    required this.id,
    required this.pokemon,
    required this.type,
    required this.abilities,
    required this.hitpoints,
    required this.evolutions,
    required this.location,
    required this.imageUrl,
  });

  factory DetailPokemon.fromJson(Map<String, dynamic> json) => DetailPokemon(
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
}
