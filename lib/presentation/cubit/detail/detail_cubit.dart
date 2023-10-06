import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/detail_pokemon.dart';
import '../../../domain/usecases/get_detail_pokemon.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit({
    required GetDetailPokemon getDetailPokemon,
  })  : _getDetailPokemon = getDetailPokemon,
        super(DetailInitial());

  final GetDetailPokemon _getDetailPokemon;

  Future<void> getDetailPokemon(int id) async {
    emit(DetailLoading());
    final result = await _getDetailPokemon.execute(id);
    result.fold(
      (failure) => emit(DetailError(message: failure.message)),
      (detailPokemon) => emit(DetailLoaded(detailPokemon: detailPokemon)),
    );
  }
}
