import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'collection_screen.dart';
import 'feed_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            // ── BANNER + AVATAR ──
            Stack(children: [
              Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xFF1a0800),
                    Color(0xFF3a1800),
                    Color(0xFF6a2800)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: const Center(
                      child: Text('🏎️', style: TextStyle(fontSize: 60)))),
              // Botão voltar
              Positioned(
                  top: 12,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        // Navega para o feed se não há rota anterior
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  const _FeedFallback(),
                              transitionDuration: Duration.zero,
                            ));
                      }
                    },
                    child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 18)),
                  )),
              // Botão editar
              Positioned(
                  top: 12,
                  right: 16,
                  child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.edit_outlined,
                          color: Colors.white, size: 18))),
              // Avatar
              Positioned(
                  bottom: 0,
                  left: 20,
                  child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                          color: const Color(0xFF242018),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF0F0E0B), width: 4)),
                      child: const Center(
                          child: Text('🏎️', style: TextStyle(fontSize: 34))))),
            ]),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── NOME + BOTÃO EDITAR ──
                    Row(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('rafael',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 24,
                                    color: const Color(0xFFF0ECE4),
                                    letterSpacing: 1)),
                            Text('@rafael_col',
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 12,
                                    color: const Color(0xFF7A7060))),
                          ]),
                      const Spacer(),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF2E2A22)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text('EDITAR PERFIL',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 12,
                                  letterSpacing: 1,
                                  color: const Color(0xFFF0ECE4)))),
                    ]),

                    const SizedBox(height: 12),

                    // ── BIO ──
                    Text(
                        'Colecionador apaixonado por raridades desde 2001. SP 🔥',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 13,
                            color: const Color(0xFFB0A898),
                            height: 1.5)),

                    const SizedBox(height: 16),

                    // ── STATS ──
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2E2A22))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _ProfileStat(value: '127', label: 'PEÇAS'),
                            Container(
                                width: 1,
                                height: 28,
                                color: const Color(0xFF2E2A22)),
                            _ProfileStat(value: '2.4k', label: 'SEGUIDORES'),
                            Container(
                                width: 1,
                                height: 28,
                                color: const Color(0xFF2E2A22)),
                            _ProfileStat(value: '381', label: 'SEGUINDO'),
                            Container(
                                width: 1,
                                height: 28,
                                color: const Color(0xFF2E2A22)),
                            _ProfileStat(value: 'R\$ 48k', label: 'VALOR'),
                          ]),
                    ),

                    const SizedBox(height: 16),

                    // ── LINK PARA COLEÇÃO ──
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CollectionScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xFF1A1814),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color:
                                    const Color(0xFFD4622A).withOpacity(0.3))),
                        child: Row(children: [
                          const Text('🏆', style: TextStyle(fontSize: 22)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text('VER MINHA COLEÇÃO',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 14,
                                        letterSpacing: 1,
                                        color: const Color(0xFFF0ECE4))),
                                Text('Dashboard com vendas, leilões e álbuns',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 11,
                                        color: const Color(0xFF7A7060))),
                              ])),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFD4622A), size: 14),
                        ]),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── PEÇAS RECENTES ──
                    Text('PEÇAS RECENTES',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9,
                            color: const Color(0xFF7A7060),
                            letterSpacing: 1.5)),
                    const SizedBox(height: 10),
                    GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        children: ['🏎️', '🎸', '🐲', '🦸', '📮', '🚂']
                            .map((e) => Container(
                                color: const Color(0xFF1A1814),
                                child: Center(
                                    child: Text(e,
                                        style: const TextStyle(fontSize: 32)))))
                            .toList()),

                    const SizedBox(height: 30),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}

// ── Fallback para quando não há rota anterior ──
class _FeedFallback extends StatelessWidget {
  const _FeedFallback();
  @override
  Widget build(BuildContext context) => const FeedScreen();
}

// ── STAT WIDGET ──
class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;
  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value,
          style: GoogleFonts.bebasNeue(
              fontSize: 20, color: const Color(0xFFF0ECE4), letterSpacing: 1)),
      Text(label,
          style: GoogleFonts.jetBrainsMono(
              fontSize: 9, color: const Color(0xFF7A7060), letterSpacing: 1)),
    ]);
  }
}
