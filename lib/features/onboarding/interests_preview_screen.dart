import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../feed/feed_screen.dart';

class InterestsPreviewScreen extends StatefulWidget {
  final List<String> selectedInterests;
  const InterestsPreviewScreen({super.key, required this.selectedInterests});

  @override
  State<InterestsPreviewScreen> createState() => _InterestsPreviewScreenState();
}

class _InterestsPreviewScreenState extends State<InterestsPreviewScreen> {
  // Itens personalizados: emoji + nome
  final List<({String emoji, String name})> _customPreviews = [];

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
          emoji: '🌿',
          name: 'Black Lotus',
          series: 'Magic Alpha · 1993',
          value: 'R\$ 85.000',
          garage: 'magic_sp',
          garageEmoji: '🧙'),
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
    ],
  };

  List<_PreviewPiece> get _filteredPieces {
    final result = <_PreviewPiece>[];
    for (final interest in widget.selectedInterests) {
      result.addAll((_piecesByCategory[interest] ?? []).take(2));
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

  // Dialog com ícones — igual ao da tela 2
  void _openAddCustom() {
    final nameController = TextEditingController();
    String selectedEmoji = '📦';
    final emojis = [
      '📦',
      '🔩',
      '🪙',
      '🎯',
      '🧸',
      '🪆',
      '🎪',
      '🧩',
      '🪅',
      '💡',
      '🔬',
      '🎻',
      '🥊',
      '🏅',
      '🗿',
      '🪖',
      '🧲',
      '🎠'
    ];

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) => StatefulBuilder(
        builder: (context, setD) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 420,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF2E2A22)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 16, 0),
                    child: Row(children: [
                      Text('ADICIONAR COLEÇÃO',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 18,
                              color: const Color(0xFFF0ECE4),
                              letterSpacing: 2)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: const Color(0xFF242018),
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xFF2E2A22))),
                          child: const Icon(Icons.close_rounded,
                              color: Color(0xFF7A7060), size: 15),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        'Quer adicionar algo diferente ao seu perfil? Escreva aqui!',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12, color: const Color(0xFF7A7060))),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF2E2A22), height: 1),
                  const SizedBox(height: 16),

                  // Seleção de ícone
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ESCOLHA UM ÍCONE',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 9,
                                  color: const Color(0xFF7A7060),
                                  letterSpacing: 1.5)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: emojis
                                .map((e) => GestureDetector(
                                      onTap: () =>
                                          setD(() => selectedEmoji = e),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 150),
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: selectedEmoji == e
                                              ? const Color(0xFFD4622A)
                                                  .withOpacity(0.15)
                                              : const Color(0xFF242018),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: selectedEmoji == e
                                                ? const Color(0xFFD4622A)
                                                : const Color(0xFF2E2A22),
                                            width: selectedEmoji == e ? 1.5 : 1,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(e,
                                                style: const TextStyle(
                                                    fontSize: 20))),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 16),

                  // Campo de nome
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('O QUE VOCÊ COLECIONA?',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 9,
                                  color: const Color(0xFF7A7060),
                                  letterSpacing: 1.5)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: nameController,
                            autofocus: true,
                            style: GoogleFonts.familjenGrotesk(
                                color: const Color(0xFFF0ECE4), fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Ex: Garrafas Antigas, Tampinhas...',
                              hintStyle: GoogleFonts.familjenGrotesk(
                                  color: const Color(0xFF4A4438), fontSize: 13),
                              filled: true,
                              fillColor: const Color(0xFF242018),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3A3428))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3A3428))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFD4622A))),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                            ),
                            onChanged: (_) => setD(() {}),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: nameController.text.trim().isEmpty
                            ? null
                            : () {
                                setState(() => _customPreviews.add((
                                      emoji: selectedEmoji,
                                      name: nameController.text.trim(),
                                    )));
                                Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: nameController.text.trim().isEmpty
                              ? const Color(0xFF2E2A22)
                              : const Color(0xFFD4622A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Text('ADICIONAR À MINHA LISTA',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 15,
                                letterSpacing: 1.5,
                                color: nameController.text.trim().isEmpty
                                    ? const Color(0xFF4A4438)
                                    : Colors.white)),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
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
            child: Column(children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                child: Column(children: [
                  Row(
                      children: List.generate(
                          3,
                          (i) => Expanded(
                                child: Container(
                                  height: 3,
                                  margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                                  decoration: BoxDecoration(
                                    color: i <= 1
                                        ? const Color(0xFFD4622A)
                                        : const Color(0xFF2E2A22),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ))),
                  const SizedBox(height: 32),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  ]),
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
                          height: 1.4)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    alignment: WrapAlignment.center,
                    children: widget.selectedInterests
                        .map((name) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4622A).withOpacity(0.1),
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
                ]),
              ),

              const SizedBox(height: 20),

              // Lista de peças + custom + botão adicionar
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  itemCount: pieces.length + _customPreviews.length + 1,
                  itemBuilder: (context, index) {
                    // Peças normais
                    if (index < pieces.length) {
                      return _PiecePreviewCard(piece: pieces[index]);
                    }

                    // Itens personalizados adicionados
                    final customIndex = index - pieces.length;
                    if (customIndex < _customPreviews.length) {
                      final item = _customPreviews[customIndex];
                      return _CustomPreviewCard(
                          emoji: item.emoji, name: item.name);
                    }

                    // Card de adicionar — sempre por último
                    return GestureDetector(
                      onTap: _openAddCustom,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color(0xFFD4622A).withOpacity(0.35),
                              width: 1.5),
                        ),
                        child: Row(children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                                color: const Color(0xFFD4622A).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.add_rounded,
                                color: Color(0xFFD4622A), size: 26),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text('Adicionar item da sua preferência',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFD4622A))),
                                const SizedBox(height: 4),
                                Text(
                                    'Não achou o que você coleciona? Escreva aqui e personalize seu perfil.',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 11,
                                        color: const Color(0xFF7A7060),
                                        height: 1.4)),
                              ])),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFD4622A), size: 14),
                        ]),
                      ),
                    );
                  },
                ),
              ),

              // Botão entrar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(children: [
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
                      child: Text('EXPLORAR MINHA GARAGEM 🏎️',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 17,
                              letterSpacing: 1.5,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Você encontrará muito mais dentro do app!',
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11, color: const Color(0xFF4A4438))),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Card de item personalizado adicionado (com emoji escolhido) ──
class _CustomPreviewCard extends StatelessWidget {
  final String emoji, name;
  const _CustomPreviewCard({required this.emoji, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4CAF7A).withOpacity(0.3)),
      ),
      child: Row(children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
              color: const Color(0xFF4CAF7A).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12)),
          child:
              Center(child: Text(emoji, style: const TextStyle(fontSize: 36))),
        ),
        const SizedBox(width: 14),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name,
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF0ECE4))),
          const SizedBox(height: 4),
          Text('Adicionado por você',
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 11, color: const Color(0xFF7A7060))),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                color: const Color(0xFF4CAF7A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: const Color(0xFF4CAF7A).withOpacity(0.3))),
            child: Text('✓ Na sua lista',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 9, color: const Color(0xFF4CAF7A))),
          ),
        ])),
      ]),
    );
  }
}

// ── Card de peça ──
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
      child: Row(children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
              color: const Color(0xFF242018),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
              child: Text(widget.piece.emoji,
                  style: const TextStyle(fontSize: 36))),
        ),
        const SizedBox(width: 14),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Row(children: [
            Text(widget.piece.garageEmoji,
                style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text('@${widget.piece.garage}',
                style: GoogleFonts.familjenGrotesk(
                    fontSize: 11, color: const Color(0xFF7A7060))),
          ]),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(widget.piece.value,
              style: GoogleFonts.bebasNeue(
                  fontSize: 16,
                  color: const Color(0xFFD4A020),
                  letterSpacing: 1)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _liked = !_liked),
            child: Icon(_liked ? Icons.favorite : Icons.favorite_border,
                color:
                    _liked ? const Color(0xFFD4622A) : const Color(0xFF4A4438),
                size: 22),
          ),
        ]),
      ]),
    );
  }
}

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
