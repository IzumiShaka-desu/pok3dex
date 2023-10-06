import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pok3dex/app/extension/context_utils.dart';
import 'package:pok3dex/app/extension/extension.dart';
import 'package:pok3dex/presentation/cubit/detail/detail_cubit.dart';

import '../../domain/entities/detail_pokemon.dart';
import '../widgets/loading_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    // draggableScrollableSheetController = DraggableScrollableActuator.of(context);
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          final appState = context.watch<DetailCubit>().state;
          if (appState is DetailLoading) {
            return const Center(
              child: LoadingImage(imagePath: "images/pokeball_grey3.png"),
            );
          }
          if (appState is DetailError) {
            return const Center(
              child: LoadingImage(imagePath: "images/pokeball_grey3.png"),
            );
          }
          if (appState is DetailInitial) {
            context.read<DetailCubit>().getDetailPokemon(id);
            return const Center(
              child: Text("Initial"),
            );
          }
          final data = (appState as DetailLoaded).detailPokemon;
          return Stack(
            fit: StackFit.loose,
            children: [
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
                  decoration: BoxDecoration(
                    color: data.type.typeAsColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.white,
                            icon: const Icon(Icons.favorite_border),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.pokemon.capitalized,
                                  style: context.headlineLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                          data.type.capitalized,
                                          style: context.bodyMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              "#${fillStringWith(data.id.toString())}",
                              style: context.headlineLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            "images/pokeball.png",
                            width: 150,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.58,
                  maxChildSize: 1,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          SizedBox(
                            child: Stack(
                              children: [
                                DetailBody(data: data),
                                Transform.translate(
                                  offset: const Offset(0, -128),
                                  child: Center(
                                    child: Image.network(
                                      data.fullImageUrl,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    super.key,
    required this.data,
  });

  final DetailPokemon data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 8, 0),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Hitpoints"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Location"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Abilities"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("evolutions"),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${data.hitpoints} points"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data.location),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.abilities.map((e) => e.capitalized).join(", "),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        [
                          data.pokemon,
                          ...data.evolutions,
                        ].map((e) => e.capitalized).join(" > "),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
