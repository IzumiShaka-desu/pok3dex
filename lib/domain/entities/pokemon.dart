import 'package:equatable/equatable.dart';

import '../../app/constants.dart';

class Pokemon extends Equatable {
  final int id;
  final String pokemon;
  final String type;
  final List<String> abilities;
  final int hitpoints;
  final List<String> evolutions;
  final String location;
  final String imageUrl;

  String get fullImageUrl => "${Constants.baseUrlPngImages}$id.png";

  Pokemon({
    required this.id,
    required this.pokemon,
    required this.type,
    required this.abilities,
    required this.hitpoints,
    required this.evolutions,
    required this.location,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        pokemon,
        type,
        abilities,
        hitpoints,
        evolutions,
        location,
        imageUrl,
      ];
}
