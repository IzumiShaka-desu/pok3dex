import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pok3dex/app/di.dart' as di;
import 'package:pok3dex/presentation/cubit/detail/detail_cubit.dart';
import 'package:pok3dex/presentation/cubit/home/home_cubit.dart';

import 'app/route_config.dart';
import 'app/utils/color_utils.dart';

void main() {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => di.locator<HomeCubit>(),
        ),
        BlocProvider<DetailCubit>(
          create: (_) => di.locator<DetailCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Pokedex',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: fromHex("#6C79DB"),
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        routerConfig: routeConfig,
      ),
    );
  }
}
