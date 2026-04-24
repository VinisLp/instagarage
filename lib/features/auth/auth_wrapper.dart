import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import '../feed/feed_screen.dart';
import '../onboarding/onboarding_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<bool> _shouldShowOnboarding(User user) async {
    final prefs = await SharedPreferences.getInstance();

    // ✅ Se já completou o onboarding, vai direto pro feed
    final done = prefs.getBool('onboarding_done') ?? false;
    if (done) return false;

    // ✅ Verifica se é conta nova (criada nos últimos 30 segundos)
    final createdAt = DateTime.tryParse(user.createdAt);
    if (createdAt == null) return false;

    final isNewUser = DateTime.now().difference(createdAt).inSeconds < 30;

    // ✅ Se não é novo, marca como feito e vai pro feed
    if (!isNewUser) {
      await prefs.setBool('onboarding_done', true);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0F0E0B),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFD4622A)),
            ),
          );
        }

        final session = snapshot.data?.session;

        if (session == null) return const LoginScreen();

        return FutureBuilder<bool>(
          future: _shouldShowOnboarding(session.user),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                backgroundColor: Color(0xFF0F0E0B),
                body: Center(
                  child: CircularProgressIndicator(color: Color(0xFFD4622A)),
                ),
              );
            }

            final showOnboarding = snap.data ?? false;

            if (showOnboarding) return const OnboardingScreen();
            return const FeedScreen();
          },
        );
      },
    );
  }
}
