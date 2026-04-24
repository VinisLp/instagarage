import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vlzatbuumtverbveqvye.supabase.co',
    anonKey: 'sb_publishable_iyMaO865jTkGaE4kuLEDPg_v9XSSdFh',
  );

  runApp(const ProviderScope(child: InstaGarageApp()));
}

// Atalho global para acessar o Supabase em qualquer lugar do app
final supabase = Supabase.instance.client;

class InstaGarageApp extends StatelessWidget {
  const InstaGarageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InstaGarage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0E0B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4622A),
          secondary: Color(0xFFD4A020),
          surface: Color(0xFF1A1814),
        ),
        textTheme: GoogleFonts.familjenGroteskTextTheme(
          ThemeData.dark().textTheme,
        ),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}
