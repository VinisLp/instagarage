import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../feed/feed_screen.dart';

class InterestsPreviewScreen extends StatefulWidget {
  final List<String> selectedInterests;

  const InterestsPreviewScreen({
    super.key,
    required this.selectedInterests,
  });

  @override
  State<InterestsPreviewScreen> createState() => _InterestsPreviewScreenState();
}

class _InterestsPreviewScreenState extends State<InterestsPreviewScreen> {
  // ✅ Peças de exemplo por categoria
  final Map<String, List<_PreviewPiece>> _piecesByCategory = {
    'Cards': [
      _PreviewPiece(
          emoji: '🐲',
          name: 'Charizard Holo',
          series: 'Pokémon Base Set · 1999',
          value: 'R\$ 2.400',
          garage: 'pokemon_rafael',
          garageEmoji: '🏎️'),
      _PreviewPiece(
          emoji: '⚡',
          name: 'Pikachu Illustrator',
          series: 'Pokémon Promo · 1998',
          value: 'R\$ 185.000',
          garage: 'tcg_brasil',
          garageEmoji: '🎴'),
      _PreviewPiece(
          emoji: '🌿',
          name: 'Black Lotus',
          series: 'Magic Alpha · 1993',
          value: 'R\$ 85.000',
          garage: 'magic_sp',
          garageEmoji: '🧙'),
      _PreviewPiece(
          emoji: '🔵',
          name: 'Mox Sapphire',
          series: 'Magic Alpha · 1993',
          value: 'R\$ 42.000',
          garage: 'oldschool_mtg',
          garageEmoji: '♟️'),
    ],
    'Quadrinhos': [
      _PreviewPiece(
          emoji: '🕷️',
          name: 'Amazing Fantasy #15',
          series: 'Marvel · 1962',
          value: 'R\$ 95.000',
          garage: 'hq_collector',
          garageEmoji: '🦸'),
      _PreviewPiece(
          emoji: '🦇',
          name: 'Detective Comics #27',
          series: 'DC · 1939',
          value: 'R\$ 320.000',
          garage: 'comics_rj',
          garageEmoji: '📚'),
      _PreviewPiece(
          emoji: '🦸',
          name: 'X-Men #1',
          series: 'Marvel · 1963',
          value: 'R\$ 28.000',
          garage: 'xmen_collector',
          garageEmoji: '🔴'),
      _PreviewPiece(
          emoji: '💪',
          name: 'Fantastic Four #1',
          series: 'Marvel · 1961',
          value: 'R\$ 35.000',
          garage: 'marvel_sp',
          garageEmoji: '🦸'),
    ],
    'Vinils & CDs': [
      _PreviewPiece(
          emoji: '🎸',
          name: 'Led Zeppelin IV',
          series: 'LP Original UK · 1971',
          value: 'R\$ 1.200',
          garage: 'vinyl_br',
          garageEmoji: '🎸'),
      _PreviewPiece(
          emoji: '🍎',
          name: 'Abbey Road',
          series: 'LP First Press · 1969',
          value: 'R\$ 2.800',
          garage: 'beatles_col',
          garageEmoji: '🎵'),
      _PreviewPiece(
          emoji: '🌙',
          name: 'Dark Side of the Moon',
          series: 'LP · 1973',
          value: 'R\$ 1.800',
          garage: 'floyd_collector',
          garageEmoji: '🌑'),
      _PreviewPiece(
          emoji: '🕺',
          name: 'Thriller',
          series: 'LP · 1982',
          value: 'R\$ 950',
          garage: 'mj_fans',
          garageEmoji: '🎤'),
    ],
    'Miniaturas': [
      _PreviewPiece(
          emoji: '🏎️',
          name: 'Ferrari 250 GTO',
          series: 'Burago 1:18 · 1962',
          value: 'R\$ 420',
          garage: 'cars_col',
          garageEmoji: '🚗'),
      _PreviewPiece(
          emoji: '🚀',
          name: 'Hot Wheels Redline',
          series: 'Mattel · 1968',
          value: 'R\$ 950',
          garage: 'hw_vintage',
          garageEmoji: '🏁'),
      _PreviewPiece(
          emoji: '🚂',
          name: 'Märklin BR 01',
          series: 'Escala HO · 1955',
          value: 'R\$ 3.200',
          garage: 'trains_sp',
          garageEmoji: '🚂'),
      _PreviewPiece(
          emoji: '✈️',
          name: 'Spitfire Mk.I',
          series: 'Corgi 1:72 · 1940',
          value: 'R\$ 680',
          garage: 'warbirds_br',
          garageEmoji: '✈️'),
    ],
    'Action Figures': [
      _PreviewPiece(
          emoji: '⚔️',
          name: 'He-Man Original',
          series: 'Mattel · 1982',
          value: 'R\$ 1.400',
          garage: 'motu_br',
          garageEmoji: '🤖'),
      _PreviewPiece(
          emoji: '🌟',
          name: 'Luke Skywalker',
          series: 'Kenner · 1977',
          value: 'R\$ 2.200',
          garage: 'starwars_col',
          garageEmoji: '⭐'),
      _PreviewPiece(
          emoji: '🐍',
          name: 'Snake Eyes',
          series: 'GI Joe · 1982',
          value: 'R\$ 890',
          garage: 'joe_collector',
          garageEmoji: '🎖️'),
      _PreviewPiece(
          emoji: '🤖',
          name: 'Optimus Prime G1',
          series: 'Hasbro · 1984',
          value: 'R\$ 3.500',
          garage: 'tf_brasil',
          garageEmoji: '🔧'),
    ],
    'Camisas Retrô': [
      _PreviewPiece(
          emoji: '💛',
          name: 'Brasil Copa 1970',
          series: 'Seleção · Original',
          value: 'R\$ 3.200',
          garage: 'shirts_br',
          garageEmoji: '👕'),
      _PreviewPiece(
          emoji: '⚫',
          name: 'Milan 1989/90',
          series: 'Adidas · Serie A',
          value: 'R\$ 1.800',
          garage: 'calcio_vintage',
          garageEmoji: '⚽'),
      _PreviewPiece(
          emoji: '🔵',
          name: 'Barcelona 1998/99',
          series: 'Nike · La Liga',
          value: 'R\$ 2.400',
          garage: 'barca_retro',
          garageEmoji: '🔵'),
      _PreviewPiece(
          emoji: '⚪',
          name: 'Real Madrid 1998/99',
          series: 'Kelme · La Liga',
          value: 'R\$ 1.600',
          garage: 'retro_shirts',
          garageEmoji: '👕'),
    ],
    'Games & Consoles': [
      _PreviewPiece(
          emoji: '🎮',
          name: 'Nintendo NES',
          series: 'Nintendo · 1985',
          value: 'R\$ 1.800',
          garage: 'retrogaming_sp',
          garageEmoji: '🎮'),
      _PreviewPiece(
          emoji: '🟡',
          name: 'Game Boy Original',
          series: 'Nintendo · 1989',
          value: 'R\$ 950',
          garage: 'handheld_col',
          garageEmoji: '👾'),
      _PreviewPiece(
          emoji: '🔵',
          name: 'Sega Mega Drive',
          series: 'Sega · 1988',
          value: 'R\$ 1.200',
          garage: 'sega_brasil',
          garageEmoji: '🔵'),
      _PreviewPiece(
          emoji: '🟣',
          name: 'Neo Geo AES',
          series: 'SNK · 1990',
          value: 'R\$ 8.500',
          garage: 'neogeo_rare',
          garageEmoji: '🕹️'),
    ],
    'Lego': [
      _PreviewPiece(
          emoji: '🚀',
          name: 'Millennium Falcon',
          series: '#75192 · 2017',
          value: 'R\$ 4.200',
          garage: 'lego_col',
          garageEmoji: '🧱'),
      _PreviewPiece(
          emoji: '🗼',
          name: 'Eiffel Tower',
          series: '#10307 · 2022',
          value: 'R\$ 2.800',
          garage: 'afol_brasil',
          garageEmoji: '🏗️'),
      _PreviewPiece(
          emoji: '🚢',
          name: 'Titanic',
          series: '#10294 · 2021',
          value: 'R\$ 3.500',
          garage: 'lego_icons',
          garageEmoji: '⚓'),
      _PreviewPiece(
          emoji: '🏰',
          name: 'Hogwarts Castle',
          series: '#71043 · 2018',
          value: 'R\$ 5.200',
          garage: 'hp_lego',
          garageEmoji: '🧙'),
    ],
    'Funko Pop': [
      _PreviewPiece(
          emoji: '🦇',
          name: 'Batman #01',
          series: 'DC · Chrome Ed.',
          value: 'R\$ 890',
          garage: 'funko_sp',
          garageEmoji: '🎭'),
      _PreviewPiece(
          emoji: '💜',
          name: 'Thanos #289',
          series: 'Marvel · Glow Dark',
          value: 'R\$ 1.200',
          garage: 'pop_brasil',
          garageEmoji: '✨'),
      _PreviewPiece(
          emoji: '🕷️',
          name: 'Spider-Man #03',
          series: 'Marvel · 1st Ed.',
          value: 'R\$ 650',
          garage: 'funko_rare',
          garageEmoji: '🎭'),
      _PreviewPiece(
          emoji: '⚡',
          name: 'Iron Man #03',
          series: 'Marvel · Metallic',
          value: 'R\$ 780',
          garage: 'pop_collector',
          garageEmoji: '🤖'),
    ],
    'Sneakers': [
      _PreviewPiece(
          emoji: '👟',
          name: 'Air Jordan 1 Chicago',
          series: 'Nike · 1985',
          value: 'R\$ 15.000',
          garage: 'sneaker_sp',
          garageEmoji: '👟'),
      _PreviewPiece(
          emoji: '🏃',
          name: 'Yeezy 350 V2',
          series: 'Adidas · 2016',
          value: 'R\$ 3.200',
          garage: 'kicks_rj',
          garageEmoji: '👟'),
      _PreviewPiece(
          emoji: '🔵',
          name: 'Air Max 1 OG',
          series: 'Nike · 1987',
          value: 'R\$ 4.800',
          garage: 'airmax_col',
          garageEmoji: '💨'),
      _PreviewPiece(
          emoji: '⚫',
          name: 'New Balance 550',
          series: 'NB · Aime Leon',
          value: 'R\$ 2.100',
          garage: 'nb_collector',
          garageEmoji: 'N'),
    ],
  };

  List<_PreviewPiece> get _filteredPieces {
    final List<_PreviewPiece> result = [];
    for (final interest in widget.selectedInterests) {
      final pieces = _piecesByCategory[interest] ?? [];
      result.addAll(pieces.take(2)); // 2 peças por categoria
    }
    return result;
  }

  Future<void> _enterFeed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const FeedScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 600;
    final pieces = _filteredPieces;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: isDesktop ? 680.0 : double.infinity,
            child: Column(
              children: [
                // ── HEADER ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  child: Column(
                    children: [
                      // ✅ Progress 2/3
                      Row(
                        children: List.generate(
                            3,
                            (i) => Expanded(
                                  child: Container(
                                    height: 3,
                                    margin:
                                        EdgeInsets.only(right: i < 2 ? 4 : 0),
                                    decoration: BoxDecoration(
                                      color: i <= 1
                                          ? const Color(0xFFD4622A)
                                          : const Color(0xFF2E2A22),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                )),
                      ),
                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('INSTA',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 22,
                                  color: const Color(0xFFF0ECE4),
                                  letterSpacing: 4)),
                          Text('COLLECTION',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 22,
                                  color: const Color(0xFFD4622A),
                                  letterSpacing: 4)),
                        ],
                      ),
                      const SizedBox(height: 24),

                      Text('PEÇAS DO SEU\nINTERESSE',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bebasNeue(
                              fontSize: isDesktop ? 36 : 30,
                              color: const Color(0xFFF0ECE4),
                              letterSpacing: 2,
                              height: 1.1)),
                      const SizedBox(height: 10),
                      Text(
                        'Baseado nos seus interesses, essas são algumas peças que você vai encontrar na plataforma',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 13,
                            color: const Color(0xFF7A7060),
                            height: 1.4),
                      ),
                      const SizedBox(height: 12),

                      // ✅ Tags dos interesses selecionados
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        alignment: WrapAlignment.center,
                        children: widget.selectedInterests
                            .map((name) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD4622A)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: const Color(0xFFD4622A)
                                            .withOpacity(0.4)),
                                  ),
                                  child: Text(name,
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 11,
                                          color: const Color(0xFFD4622A),
                                          fontWeight: FontWeight.w600)),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── LISTA DE PEÇAS ──
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: pieces.length,
                    itemBuilder: (context, index) {
                      final piece = pieces[index];
                      return _PiecePreviewCard(piece: piece);
                    },
                  ),
                ),

                // ── BOTÃO ENTRAR NO FEED ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _enterFeed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4622A),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('EXPLORAR MINHA GARAGEM 🏎️',
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 17,
                                      letterSpacing: 1.5,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Você encontrará muito mais dentro do app!',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 11, color: const Color(0xFF4A4438)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── CARD DE PREVIEW ──
class _PiecePreviewCard extends StatefulWidget {
  final _PreviewPiece piece;
  const _PiecePreviewCard({required this.piece});

  @override
  State<_PiecePreviewCard> createState() => _PiecePreviewCardState();
}

class _PiecePreviewCardState extends State<_PiecePreviewCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Row(
        children: [
          // ✅ Imagem da peça
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF242018),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text(widget.piece.emoji,
                    style: const TextStyle(fontSize: 36))),
          ),
          const SizedBox(width: 14),

          // ✅ Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.piece.name,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0ECE4))),
                const SizedBox(height: 3),
                Text(widget.piece.series,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 11, color: const Color(0xFF7A7060))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(widget.piece.garageEmoji,
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text('@${widget.piece.garage}',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 11, color: const Color(0xFF7A7060))),
                  ],
                ),
              ],
            ),
          ),

          // ✅ Valor + curtir
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(widget.piece.value,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 16,
                      color: const Color(0xFFD4A020),
                      letterSpacing: 1)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => setState(() => _liked = !_liked),
                child: Icon(
                  _liked ? Icons.favorite : Icons.favorite_border,
                  color: _liked
                      ? const Color(0xFFD4622A)
                      : const Color(0xFF4A4438),
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── MODELO ──
class _PreviewPiece {
  final String emoji, name, series, value, garage, garageEmoji;
  const _PreviewPiece({
    required this.emoji,
    required this.name,
    required this.series,
    required this.value,
    required this.garage,
    required this.garageEmoji,
  });
}
