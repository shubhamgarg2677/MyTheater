import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_theater/domain/models/booking_detail/booking_detail_model.dart';
import 'package:my_theater/domain/models/movie_detail/genre_model.dart';
import 'package:my_theater/domain/models/movie_detail/media_model.dart';
import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';
import 'package:my_theater/presentation/screens/movie_list/movie_list_screen.dart';
import 'package:my_theater/presentation/screens/splash/splash_screen.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieItemModelAdapter());
  Hive.registerAdapter(GenreModelAdapter());
  Hive.registerAdapter(MediaModelAdapter());
  Hive.registerAdapter(BookingDetailModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie booking Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColorsUtils.appColor),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.system,
      routes: {
        '/': (_)=> const SplashScreen(),
        '/MovieList': (_)=> const MovieListScreen(),
      },
      // home: const SplashScreen(),
    );
  }
}