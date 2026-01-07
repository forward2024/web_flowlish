import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Premium Typography Combination: Playfair Display for Headings, Inter for Body
    // Using a refined pastel theme approach

    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Flowlish',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,

      // Setting defaults for Inter (body)
      textTheme: GoogleFonts.interTextTheme(ThemeData(brightness: brightness).textTheme)
          .copyWith(
            // We will specifically use Playfair Display for large headings in individual widgets
          ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1), // Soft Indigo
        brightness: brightness,
        primary: const Color(0xFF6366F1),
        surface: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
      ),
    );
  }
}
