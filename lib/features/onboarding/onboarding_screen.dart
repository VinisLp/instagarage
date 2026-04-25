import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../feed/feed_screen.dart';
import 'interests_preview_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final Set<String> _selected = {};
  final List<_Interest> _customInterests = [];

  final List<_Interest> _interests = [
    _Interest(emoji: '🎴', name: 'Cards', desc: 'Pokémon, Magic, Yu-Gi-Oh'),
    _Interest(emoji: '🦸', name: 'Quadrinhos', desc: 'Marvel, DC, mangás'),
    _Interest(
        emoji: '🎸',
        name: 'Vinils & CDs',
        desc: 'Prensagens raras, edições limitadas'),
    _Interest(
        emoji: '🚀', name: 'Miniaturas', desc: 'Hot Wheels, Burago, Matchbox'),
    _Interest(
        emoji: '🤖', name: 'Action Figures', desc: 'He-Man, GI Joe, Star Wars'),
    _Interest(
        emoji: '👕',
        name: 'Camisas Retrô',
        desc: 'Futebol, bandas, times históricos'),
    _Interest(
        emoji: '📮', name: 'Selos & Moedas', desc: 'Filatelia, numismática'),
    _Interest(
        emoji: '🎮',
        name: 'Games & Consoles',
        desc: 'Retrogaming, edições de colecionador'),
    _Interest(emoji: '🧱', name: 'Lego', desc: 'Sets raros, edições especiais'),
    _Interest(
        emoji: '🎭',
        name: 'Funko Pop',
        desc: 'Exclusivos, vaulted, edições limitadas'),
    _Interest(
        emoji: '📷',
        name: 'Câmeras Antigas',
        desc: 'Analógicas, polaroids, vintage'),
    _Interest(
        emoji: '⌚',
        name: 'Relógios',
        desc: 'Vintage, mecânicos, edições especiais'),
    _Interest(
        emoji: '👟',
        name: 'Sneakers',
        desc: 'Tênis raros, collabs, edições limitadas'),
    _Interest(
        emoji: '🎨',
        name: 'Arte & Pinturas',
        desc: 'Obras originais, prints, litografias'),
    _Interest(
        emoji: '📚',
        name: 'Livros Raros',
        desc: 'Primeiras edições, autografados'),
    _Interest(
        emoji: '🏆',
        name: 'Medalhas & Troféus',
        desc: 'Esportivos, militares, históricos'),
    _Interest(
        emoji: '🎵',
        name: 'Instrumentos',
        desc: 'Guitarras, baixos, sintetizadores'),
    _Interest(
        emoji: '✈️',
        name: 'Modelos Militares',
        desc: 'Aviões, navios, tanques em escala'),
  ];

  List<_Interest> get _allInterests => [..._interests, ..._customInterests];

  bool get _canContinue => _selected.length >= 3;

  Future<void> _continue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user_interests', _selected.toList());
    if (mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => InterestsPreviewScreen(
                  selectedInterests: _selected.toList())));
    }
  }

  Future<void> _skip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const FeedScreen()));
    }
  }

  // Dialog simples — só campo de texto, sem ícones
  void _openAddCustom() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) => StatefulBuilder(
        builder: (context, setD) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 400,
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
                    child: Text('Não achou o que coleciona? Escreva aqui!',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12, color: const Color(0xFF7A7060))),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF2E2A22), height: 1),
                  const SizedBox(height: 16),

                  // Só o campo de texto
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NOME DA COLEÇÃO',
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
                              hintText: 'Ex: Garrafas Antigas, Relíquias...',
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
                                final name = nameController.text.trim();
                                final exists = _allInterests.any((i) =>
                                    i.name.toLowerCase() == name.toLowerCase());
                                if (!exists) {
                                  final newInterest = _Interest(
                                      emoji: '📦',
                                      name: name,
                                      desc: 'Adicionado por você');
                                  setState(() {
                                    _customInterests.add(newInterest);
                                    _selected.add(name);
                                  });
                                } else {
                                  setState(() => _selected.add(name));
                                }
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
    final allItems = _allInterests;

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
                                    color: i == 0
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
                  Text('O QUE VOCÊ\nCOLECIONA?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(
                          fontSize: isDesktop ? 36 : 30,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2,
                          height: 1.1)),
                  const SizedBox(height: 10),
                  Text(
                      'Selecione pelo menos 3 categorias para personalizar seu feed',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 13,
                          color: const Color(0xFF7A7060),
                          height: 1.4)),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _selected.isEmpty
                        ? Text('Selecione pelo menos 3',
                            key: const ValueKey('empty'),
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 10, color: const Color(0xFF4A4438)))
                        : Container(
                            key: ValueKey(_selected.length),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _canContinue
                                  ? const Color(0xFF4CAF7A).withOpacity(0.12)
                                  : const Color(0xFFD4622A).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: _canContinue
                                      ? const Color(0xFF4CAF7A).withOpacity(0.4)
                                      : const Color(0xFFD4622A)
                                          .withOpacity(0.4)),
                            ),
                            child: Text(
                              _canContinue
                                  ? '✓ ${_selected.length} selecionados'
                                  : '${_selected.length}/3 selecionados',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10,
                                  color: _canContinue
                                      ? const Color(0xFF4CAF7A)
                                      : const Color(0xFFD4622A),
                                  letterSpacing: 0.5),
                            ),
                          ),
                  ),
                ]),
              ),

              const SizedBox(height: 20),

              // Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDesktop ? 4 : 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: isDesktop ? 1.1 : 0.9,
                  ),
                  itemCount: allItems.length + 1,
                  itemBuilder: (context, index) {
                    // Card de adicionar — último
                    if (index == allItems.length) {
                      return GestureDetector(
                        onTap: _openAddCustom,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1814),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color:
                                    const Color(0xFFD4622A).withOpacity(0.35),
                                width: 1.5),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD4622A)
                                          .withOpacity(0.12),
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.add_rounded,
                                      color: Color(0xFFD4622A), size: 22),
                                ),
                                const SizedBox(height: 8),
                                Text('Adicionar',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: isDesktop ? 12 : 11,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFD4622A)),
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 3),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Text('Não achou o que coleciona?',
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 9,
                                          color: const Color(0xFFD4622A)
                                              .withOpacity(0.6)),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ]),
                        ),
                      );
                    }

                    final interest = allItems[index];
                    final isSelected = _selected.contains(interest.name);
                    final isCustom = _customInterests.contains(interest);

                    return GestureDetector(
                      onTap: () => setState(() {
                        if (isSelected)
                          _selected.remove(interest.name);
                        else
                          _selected.add(interest.name);
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFD4622A).withOpacity(0.12)
                              : const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFD4622A)
                                : const Color(0xFF2E2A22),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                // Cards normais mostram emoji, custom mostram só inicial
                                isCustom
                                    ? Container(
                                        width: isDesktop ? 42 : 38,
                                        height: isDesktop ? 42 : 38,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFFD4622A)
                                                  .withOpacity(0.2)
                                              : const Color(0xFF242018),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            interest.name.isNotEmpty
                                                ? interest.name[0].toUpperCase()
                                                : '?',
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: isDesktop ? 20 : 18,
                                                color: isSelected
                                                    ? const Color(0xFFD4622A)
                                                    : const Color(0xFFB0A898)),
                                          ),
                                        ),
                                      )
                                    : Text(interest.emoji,
                                        style: TextStyle(
                                            fontSize: isDesktop ? 34 : 30)),
                                if (isSelected)
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFD4622A),
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.check_rounded,
                                            color: Colors.white, size: 12),
                                      )),
                              ]),
                              const SizedBox(height: 8),
                              Text(interest.name,
                                  style: GoogleFonts.familjenGrotesk(
                                      fontSize: isDesktop ? 12 : 11,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? const Color(0xFFD4622A)
                                          : const Color(0xFFF0ECE4)),
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 3),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(interest.desc,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 9,
                                        color: isSelected
                                            ? const Color(0xFFD4622A)
                                                .withOpacity(0.7)
                                            : const Color(0xFF4A4438)),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              ),

              // Botão continuar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _canContinue ? _continue : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _canContinue
                            ? const Color(0xFFD4622A)
                            : const Color(0xFF2E2A22),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _canContinue
                                  ? 'VER PEÇAS DO MEU INTERESSE'
                                  : 'SELECIONE PELO MENOS 3',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 17,
                                  letterSpacing: 1.5,
                                  color: _canContinue
                                      ? Colors.white
                                      : const Color(0xFF4A4438)),
                            ),
                            if (_canContinue) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward_rounded,
                                  color: Colors.white, size: 20),
                            ],
                          ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _skip,
                    child: Text('Pular por agora',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12,
                            color: const Color(0xFF4A4438),
                            decoration: TextDecoration.underline)),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _Interest {
  final String emoji, name, desc;
  const _Interest(
      {required this.emoji, required this.name, required this.desc});
}
