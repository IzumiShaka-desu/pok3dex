import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pok3dex/app/extension/context_utils.dart';
import 'package:pok3dex/app/extension/extension.dart';
import 'package:pok3dex/presentation/cubit/detail/detail_cubit.dart';
import 'package:pok3dex/presentation/cubit/home/home_cubit.dart';

import '../widgets/loading_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                  right: -64,
                  top: -64,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "images/pokeball_grey.png",
                      width: 256,
                    ),
                  )),
              Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pokedex",
                          style: context.headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.format_list_bulleted_rounded),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: Builder(builder: (context) {
                        final state = context.watch<HomeCubit>().state;
                        if (state is HomeLoading) {
                          return const Center(
                            child: LoadingImage(
                                imagePath: "images/pokeball_grey3.png"),
                          );
                        }
                        if (state is HomeError) {
                          return Center(
                            child: Text(state.message),
                          );
                        }
                        if (state is HomeInitial) {
                          context.read<HomeCubit>().getPokemonsList();
                          return const Center(
                            child: LoadingImage(
                                imagePath: "images/pokeball_grey3.png"),
                          );
                        }
                        final pokemons = (state as HomeLoaded).pokemons;
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: pokemons.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            final pokemon = pokemons[index];
                            return InkWell(
                              onTap: () {
                                context.push("/${pokemon.id}");
                                context
                                    .read<DetailCubit>()
                                    .getDetailPokemon(pokemon.id);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 8, 8),
                                decoration: BoxDecoration(
                                  color: pokemon.type.typeAsColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          pokemon.pokemon,
                                          style: context.titleLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "#${pokemon.id}",
                                          style: context.titleLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Image.network(
                                            pokemon.fullImageUrl,
                                            width: 64,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
