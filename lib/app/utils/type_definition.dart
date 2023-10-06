import 'package:dartz/dartz.dart';

import '../../domain/entities/detail_pokemon.dart';
import '../../domain/entities/pokemon.dart';
import 'failure.dart';

typedef PokemonsOrFailure = Either<Failure, List<Pokemon>>;
typedef DetailPokemonOrFailure = Either<Failure, DetailPokemon>;
