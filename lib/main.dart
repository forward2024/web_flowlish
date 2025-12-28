// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app/app_router.dart';

void main() {
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTextTheme = GoogleFonts.montserratTextTheme(ThemeData.light().textTheme);

    final darkTextTheme = GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme);

    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Flowlish',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        textTheme: lightTextTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ).copyWith(surface: Colors.white),
        scaffoldBackgroundColor: Colors.white,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: darkTextTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ).copyWith(surface: Colors.black),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
