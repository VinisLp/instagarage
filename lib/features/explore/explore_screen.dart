import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../feed/feed_screen.dart';
import '../piece/ai_scan_screen.dart';
import '../dm/dm_screen.dart';
import '../marketplace/marketplace_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 600;
    const contentWidth = 900.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: isDesktop ? contentWidth : double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EXPLORAR',
                          style: GoogleFonts.bebasNeue(
                            fontSize: isDesktop ? 30 : 26,
                            color: const Color(0xFFF0ECE4),
                            letterSpacing: 3,
                          )),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2E2A22)),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 14),
                              child: Icon(Icons.search_rounded,
                                  color: Color(0xFF7A7060), size: 20),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (_) => setState(() {}),
                                style: GoogleFonts.familjenGrotesk(
                                    color: const Color(0xFFF0ECE4),
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'Buscar peças, eventos, blogs...',
                                  hintStyle: GoogleFonts.familjenGrotesk(
                                      color: const Color(0xFF4A4438),
                                      fontSize: 14),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 13),
                                ),
                              ),
                            ),
                            if (_searchController.text.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 12),
                                  child: Icon(Icons.close_rounded,
                                      color: Color(0xFF7A7060), size: 18),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: isDesktop ? contentWidth : double.infinity,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFFD4622A),
                  indicatorWeight: 2,
                  labelColor: const Color(0xFFD4622A),
                  unselectedLabelColor: const Color(0xFF7A7060),
                  labelStyle:
                      GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5),
                  unselectedLabelStyle:
                      GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5),
                  tabs: const [
                    Tab(text: 'PEÇAS'),
                    Tab(text: 'EVENTOS'),
                    Tab(text: 'BLOGS'),
                    Tab(text: 'GARAGENS'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: isDesktop ? contentWidth : double.infinity,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _PiecesTab(
                          search: _searchController.text, isDesktop: isDesktop),
                      _EventsTab(isDesktop: isDesktop),
                      _BlogsTab(isDesktop: isDesktop),
                      _GaragesTab(
                          search: _searchController.text, isDesktop: isDesktop),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: 1,
        isDesktop: isDesktop,
        onTap: (index) {
          if (index == 0)
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const FeedScreen()));
          else if (index == 2)
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AiScanScreen()));
          else if (index == 3)
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const DmScreen()));
          else if (index == 4)
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const MarketplaceScreen()));
        },
      ),
    );
  }
}

// ══════════════════════════════════════
// ABA — PEÇAS ✅ com view toggle + detalhes
// ══════════════════════════════════════

// ✅ Enum para modo de visualização
enum _ViewMode { list, grid3, grid6 }

class _PiecesTab extends StatefulWidget {
  final String search;
  final bool isDesktop;
  const _PiecesTab({required this.search, required this.isDesktop});

  @override
  State<_PiecesTab> createState() => _PiecesTabState();
}

class _PiecesTabState extends State<_PiecesTab> {
  String _selectedCategory = 'Todos';
  _ViewMode _viewMode = _ViewMode.grid3; // ✅ padrão: grid 3 colunas

  final List<String> _categories = [
    'Todos',
    'Cards',
    'Action Figures',
    'Vinils',
    'Quadrinhos',
    'Miniaturas',
    'Selos',
    'Camisas',
  ];

  final List<_ExplorePiece> _pieces = [
    _ExplorePiece(
        emoji: '🐲',
        name: 'Charizard Holo',
        series: 'Pokémon Base Set',
        value: 'R\$ 2.400',
        category: 'Cards',
        garage: 'pokemon_rafael',
        garageEmoji: '🏎️',
        condition: 'Near Mint',
        description:
            'Card original de 1999. Sem marcas visíveis, guardado em sleeve duplo desde que saiu do booster. Autenticidade comprovada por PSA Grade 9.'),
    _ExplorePiece(
        emoji: '🎸',
        name: 'Led Zeppelin IV',
        series: 'Vinil · 1971',
        value: 'R\$ 1.200',
        category: 'Vinils',
        garage: 'vinyl_br',
        garageEmoji: '🎸',
        condition: 'Good',
        description:
            'Prensagem original UK de 1971. Pequenos arranhões na capa mas disco impecável. Toca perfeitamente sem skip.'),
    _ExplorePiece(
        emoji: '🦸',
        name: 'Spider-Man #1',
        series: 'Marvel · 1990',
        value: 'R\$ 380',
        category: 'Quadrinhos',
        garage: 'hq_collector',
        garageEmoji: '🦸',
        condition: 'Very Fine',
        description:
            'Edição especial de 1990, capa brilhante. Reprodução certificada, emoldurada. Perfeita para decoração ou coleção.'),
    _ExplorePiece(
        emoji: '🚀',
        name: 'Hot Wheels Redline',
        series: 'Mattel · 1968',
        value: 'R\$ 950',
        category: 'Miniaturas',
        garage: 'trains_sp',
        garageEmoji: '🚂',
        condition: 'Good',
        description:
            'Raridade original dos anos 60. Pintura original preservada em 85%. Rodas Redline intactas. Caixa não incluída.'),
    _ExplorePiece(
        emoji: '⚡',
        name: 'Pikachu Promo',
        series: 'Pokémon · 1998',
        value: 'R\$ 4.800',
        category: 'Cards',
        garage: 'pokemon_rafael',
        garageEmoji: '🏎️',
        condition: 'Mint',
        description:
            'Pikachu Promo exclusivo do Pokémon World Championships 1998. Extremamente raro. Um dos menos de 500 no mundo.'),
    _ExplorePiece(
        emoji: '👕',
        name: 'Camisa Brasil 1970',
        series: 'Seleção · Copa',
        value: 'R\$ 3.200',
        category: 'Camisas',
        garage: 'shirts_br',
        garageEmoji: '👕',
        condition: 'Good',
        description:
            'Camisa histórica da Copa do Mundo de 1970. Com certificado de autenticidade emitido pela CBF. Bordado original.'),
    _ExplorePiece(
        emoji: '🎴',
        name: 'Black Lotus',
        series: 'Magic Alpha · 1993',
        value: 'R\$ 85.000',
        category: 'Cards',
        garage: 'magic_sp',
        garageEmoji: '🎴',
        condition: 'Near Mint',
        description:
            'Um dos cards mais raros e valiosos do mundo. Autenticidade verificada por PSA Grau 8.5. Alpha print 1993.'),
    _ExplorePiece(
        emoji: '🏎️',
        name: 'Ferrari 250 GTO',
        series: 'Burago · 1:18',
        value: 'R\$ 420',
        category: 'Miniaturas',
        garage: 'cars_col',
        garageEmoji: '🚗',
        condition: 'Perfeito',
        description:
            'Miniatura escala 1:18 da Ferrari 250 GTO de 1962. Lacrada na caixa original nunca aberta. Coleção limitada Burago Elite.'),
  ];

  List<_ExplorePiece> get _filtered => _pieces.where((p) {
        final matchCat =
            _selectedCategory == 'Todos' || p.category == _selectedCategory;
        final matchSearch = widget.search.isEmpty ||
            p.name.toLowerCase().contains(widget.search.toLowerCase());
        return matchCat && matchSearch;
      }).toList();

  // ✅ Abre sub-tela de detalhes da peça
  void _openPieceDetail(BuildContext context, _ExplorePiece piece) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F0E0B),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFF3A3428),
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),

              // ── IMAGEM DA PEÇA ──
              Container(
                height: 260,
                width: double.infinity,
                color: const Color(0xFF1A1814),
                child: Center(
                    child: Text(piece.emoji,
                        style: const TextStyle(fontSize: 110))),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── NOME + CONDIÇÃO ──
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(piece.name,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 28,
                                  letterSpacing: 1.5,
                                  color: const Color(0xFFF0ECE4),
                                  height: 1.1)),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF7A).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:
                                    const Color(0xFF4CAF7A).withOpacity(0.4)),
                          ),
                          child: Text(piece.condition,
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10,
                                  color: const Color(0xFF4CAF7A))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // ── SÉRIE + CATEGORIA ──
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: const Color(0xFF2E2A22),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(piece.series,
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10,
                                  color: const Color(0xFF7A7060))),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: const Color(0xFF2E2A22),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(piece.category,
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10,
                                  color: const Color(0xFF7A7060))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── VALOR ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF2E2A22)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('VALOR DE MERCADO',
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 9,
                                      color: const Color(0xFF7A7060),
                                      letterSpacing: 1)),
                              const SizedBox(height: 4),
                              Text(piece.value,
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 32,
                                      color: const Color(0xFFD4A020),
                                      letterSpacing: 1)),
                            ],
                          ),
                          const Spacer(),
                          const Text('📈', style: TextStyle(fontSize: 36)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── DESCRIÇÃO ──
                    Text('SOBRE A PEÇA',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9,
                            color: const Color(0xFF7A7060),
                            letterSpacing: 1.5)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2E2A22)),
                      ),
                      child: Text(piece.description,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 14,
                              color: const Color(0xFFB0A898),
                              height: 1.6)),
                    ),
                    const SizedBox(height: 16),

                    // ── VENDEDOR ──
                    Text('COLECIONADOR',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9,
                            color: const Color(0xFF7A7060),
                            letterSpacing: 1.5)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2E2A22)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF242018),
                                border: Border.all(
                                    color: const Color(0xFFD4622A),
                                    width: 1.5)),
                            child: Center(
                                child: Text(piece.garageEmoji,
                                    style: const TextStyle(fontSize: 22))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(piece.garage,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFF0ECE4))),
                                Text('@${piece.garage}',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 11,
                                        color: const Color(0xFF7A7060))),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                                color: const Color(0xFF242018),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0xFF3A3428))),
                            child: Text('VER PERFIL',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 12,
                                    letterSpacing: 1,
                                    color: const Color(0xFFF0ECE4))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── BOTÕES DE AÇÃO ──
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Mensagem enviada para @${piece.garage}! 💬',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 13)),
                                backgroundColor: const Color(0xFF4CAF7A),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF242018),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFF3A3428)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.chat_bubble_outline_rounded,
                                      color: Color(0xFFF0ECE4), size: 18),
                                  const SizedBox(width: 8),
                                  Text('CONTATAR',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 15,
                                          letterSpacing: 1.5,
                                          color: const Color(0xFFF0ECE4))),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const MarketplaceScreen()));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4622A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.storefront_rounded,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 8),
                                  Text('VER NO MARKETPLACE',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 15,
                                          letterSpacing: 1.5,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pieces = _filtered;

    // ✅ Número de colunas baseado no modo + desktop
    int crossAxisCount;
    switch (_viewMode) {
      case _ViewMode.list:
        crossAxisCount = 1;
        break;
      case _ViewMode.grid3:
        crossAxisCount = widget.isDesktop ? 4 : 3;
        break;
      case _ViewMode.grid6:
        crossAxisCount = widget.isDesktop ? 6 : 6;
        break;
    }

    return Column(
      children: [
        // ── FILTROS + TOGGLE DE VISUALIZAÇÃO ──
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              // Filtros de categoria
              Expanded(
                child: SizedBox(
                  height: 46,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(16, 4, 8, 6),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = _selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFD4622A)
                                : const Color(0xFF1A1814),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFD4622A)
                                    : const Color(0xFF2E2A22)),
                          ),
                          child: Text(cat,
                              style: GoogleFonts.familjenGrotesk(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF7A7060),
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // ✅ Botões de visualização: lista / grid3 / grid6
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  children: [
                    _ViewToggle(
                      icon: Icons.view_list_rounded,
                      active: _viewMode == _ViewMode.list,
                      onTap: () => setState(() => _viewMode = _ViewMode.list),
                    ),
                    const SizedBox(width: 4),
                    _ViewToggle(
                      icon: Icons.grid_view_rounded,
                      active: _viewMode == _ViewMode.grid3,
                      onTap: () => setState(() => _viewMode = _ViewMode.grid3),
                    ),
                    const SizedBox(width: 4),
                    _ViewToggle(
                      icon: Icons.apps_rounded,
                      active: _viewMode == _ViewMode.grid6,
                      onTap: () => setState(() => _viewMode = _ViewMode.grid6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        Expanded(
          child: pieces.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🔍', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 12),
                      Text('NENHUMA PEÇA ENCONTRADA',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 16,
                              color: const Color(0xFF4A4438),
                              letterSpacing: 2)),
                    ],
                  ),
                )
              : _viewMode == _ViewMode.list
                  // ── MODO LISTA ──
                  ? ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: pieces.length,
                      itemBuilder: (context, index) => _PieceListTile(
                        piece: pieces[index],
                        onTap: () => _openPieceDetail(context, pieces[index]),
                      ),
                    )
                  // ── MODO GRID ──
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: _viewMode == _ViewMode.grid6 ? 4 : 10,
                        mainAxisSpacing: _viewMode == _ViewMode.grid6 ? 4 : 10,
                        childAspectRatio:
                            _viewMode == _ViewMode.grid6 ? 0.75 : 0.82,
                      ),
                      itemCount: pieces.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _openPieceDetail(context, pieces[index]),
                        child: _viewMode == _ViewMode.grid6
                            ? _PieceMiniCard(piece: pieces[index])
                            : _ExplorePieceCard(piece: pieces[index]),
                      ),
                    ),
        ),
      ],
    );
  }
}

// ✅ Botão de toggle de visualização
class _ViewToggle extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _ViewToggle(
      {required this.icon, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: active ? const Color(0xFFD4622A) : const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color:
                  active ? const Color(0xFFD4622A) : const Color(0xFF2E2A22)),
        ),
        child: Icon(icon,
            color: active ? Colors.white : const Color(0xFF7A7060), size: 16),
      ),
    );
  }
}

// ✅ Tile de peça no modo lista
class _PieceListTile extends StatelessWidget {
  final _ExplorePiece piece;
  final VoidCallback onTap;
  const _PieceListTile({required this.piece, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF2E2A22)),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xFF242018),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child:
                      Text(piece.emoji, style: const TextStyle(fontSize: 32))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(piece.name,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF0ECE4))),
                  const SizedBox(height: 3),
                  Text(piece.series,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11, color: const Color(0xFF7A7060))),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: const Color(0xFF2E2A22),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(piece.condition,
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 8, color: const Color(0xFF7A7060))),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: const Color(0xFF2E2A22),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(piece.category,
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 8, color: const Color(0xFF7A7060))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(piece.value,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 18,
                        color: const Color(0xFFD4A020),
                        letterSpacing: 1)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(piece.garageEmoji,
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 3),
                    Text('@${piece.garage}',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 10, color: const Color(0xFF7A7060))),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFF3A3428), size: 20),
          ],
        ),
      ),
    );
  }
}

// ✅ Card mini para grid 6 (apenas emoji + valor)
class _PieceMiniCard extends StatelessWidget {
  final _ExplorePiece piece;
  const _PieceMiniCard({required this.piece});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF242018),
                borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
              ),
              child: Center(
                  child:
                      Text(piece.emoji, style: const TextStyle(fontSize: 28))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            child: Column(
              children: [
                Text(piece.name,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0ECE4)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(piece.value,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 11,
                        color: const Color(0xFFD4A020),
                        letterSpacing: 0.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════
// ABA — EVENTOS
// ══════════════════════════════════════
class _EventsTab extends StatelessWidget {
  final bool isDesktop;
  const _EventsTab({required this.isDesktop});

  final List<_Event> _events = const [
    _Event(
        emoji: '🎴',
        title: 'Feira de Cards SP 2025',
        organizer: 'Garage TCG',
        organizerEmoji: '🏎️',
        date: '15 Mai 2025',
        location: 'São Paulo · Expo Center Norte',
        description:
            'Maior feira de cards colecionáveis do Brasil. Pokémon, Magic, Yu-Gi-Oh e muito mais. Entrada gratuita.',
        attendees: 342,
        isPro: true,
        type: 'Presencial',
        typeColor: Color(0xFF4CAF7A)),
    _Event(
        emoji: '🎸',
        title: 'Encontro de Colecionadores de Vinil',
        organizer: 'Garagem do Vinil',
        organizerEmoji: '🎸',
        date: '22 Mai 2025',
        location: 'Rio de Janeiro · Lapa',
        description:
            'Troca, venda e apreciação de discos de vinil raros. Trazer suas peças para avaliação.',
        attendees: 128,
        isPro: true,
        type: 'Presencial',
        typeColor: Color(0xFF4CAF7A)),
    _Event(
        emoji: '🦸',
        title: 'Live: Avaliação de HQs Raras',
        organizer: 'HQ Garage',
        organizerEmoji: '🦸',
        date: '18 Mai 2025',
        location: 'Online · YouTube Live',
        description:
            'Live especial avaliando quadrinhos raros enviados pela comunidade. Mande fotos antes!',
        attendees: 891,
        isPro: true,
        type: 'Online',
        typeColor: Color(0xFF4A8FD4)),
    _Event(
        emoji: '🏎️',
        title: 'Swap Meet: Miniaturas e Carrinhos',
        organizer: 'Cars Collection',
        organizerEmoji: '🚗',
        date: '01 Jun 2025',
        location: 'Curitiba · Shopping Mueller',
        description:
            'Evento de troca de miniaturas. Hot Wheels, Matchbox, Burago e outros. Leve suas duplicatas!',
        attendees: 215,
        isPro: false,
        type: 'Presencial',
        typeColor: Color(0xFF4CAF7A)),
  ];

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.95,
        ),
        itemCount: _events.length,
        itemBuilder: (context, index) => _EventCard(event: _events[index]),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _events.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFD4622A).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: const Color(0xFFD4622A).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_outline_rounded,
                    color: Color(0xFFD4622A), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                      'Eventos são criados por usuários Garagem Pro verificados ✦',
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 12, color: const Color(0xFFD4622A))),
                ),
              ],
            ),
          );
        }
        return _EventCard(event: _events[index - 1]);
      },
    );
  }
}

class _EventCard extends StatefulWidget {
  final _Event event;
  const _EventCard({required this.event});

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _attending = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF242018),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              children: [
                Text(widget.event.emoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(widget.event.title,
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    color: const Color(0xFFF0ECE4))),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: widget.event.typeColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color:
                                      widget.event.typeColor.withOpacity(0.4)),
                            ),
                            child: Text(widget.event.type,
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 9,
                                    color: widget.event.typeColor,
                                    letterSpacing: 0.5)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(widget.event.organizerEmoji,
                              style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Text(widget.event.organizer,
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 11,
                                  color: const Color(0xFF7A7060))),
                          if (widget.event.isPro) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFD4A020).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('✦ PRO',
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 8,
                                      color: const Color(0xFFD4A020))),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded,
                        color: Color(0xFFD4622A), size: 13),
                    const SizedBox(width: 6),
                    Text(widget.event.date,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFF0ECE4))),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: Color(0xFF7A7060), size: 13),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(widget.event.location,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 12, color: const Color(0xFF7A7060))),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(widget.event.description,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 13,
                        color: const Color(0xFFB0A898),
                        height: 1.5),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.people_rounded,
                        color: Color(0xFF7A7060), size: 14),
                    const SizedBox(width: 4),
                    Text(
                        '${widget.event.attendees + (_attending ? 1 : 0)} confirmados',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 11, color: const Color(0xFF7A7060))),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => setState(() => _attending = !_attending),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _attending
                              ? const Color(0xFF4CAF7A).withOpacity(0.12)
                              : const Color(0xFFD4622A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: _attending
                                  ? const Color(0xFF4CAF7A)
                                  : const Color(0xFFD4622A)),
                        ),
                        child: Text(_attending ? '✓ CONFIRMADO' : 'PARTICIPAR',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 12,
                                letterSpacing: 1.5,
                                color: _attending
                                    ? const Color(0xFF4CAF7A)
                                    : Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════
// ABA — BLOGS
// ══════════════════════════════════════
class _BlogsTab extends StatelessWidget {
  final bool isDesktop;
  const _BlogsTab({required this.isDesktop});

  final List<_BlogPost> _posts = const [
    _BlogPost(
        emoji: '🐲',
        title: 'Os 10 Cards Pokémon mais valiosos de 2025',
        author: 'pokemon_rafael',
        authorEmoji: '🏎️',
        date: '12 Mai 2025',
        readTime: '5 min',
        preview:
            'O mercado de cards Pokémon continua aquecido. Veja quais cartas ultrapassaram R\$10.000 esse ano e por que...',
        tags: ['Pokémon', 'Cards', 'Mercado'],
        likes: 847,
        isPro: true,
        hasVideo: false),
    _BlogPost(
        emoji: '🎸',
        title: 'Como identificar uma prensagem original dos anos 70',
        author: 'vinyl_br',
        authorEmoji: '🎸',
        date: '10 Mai 2025',
        readTime: '8 min',
        preview:
            'Muitas réplicas no mercado enganam até colecionadores experientes. Aprenda os detalhes que fazem a diferença...',
        tags: ['Vinil', 'Autenticidade', 'Guia'],
        likes: 523,
        isPro: true,
        hasVideo: true),
    _BlogPost(
        emoji: '🦸',
        title: 'Marvel vs DC: quais HQs valorizam mais?',
        author: 'hq_collector',
        authorEmoji: '🦸',
        date: '8 Mai 2025',
        readTime: '6 min',
        preview:
            'Análise completa dos últimos 5 anos de leilões mostra tendências surpreendentes no mercado de quadrinhos...',
        tags: ['HQs', 'Marvel', 'DC', 'Investimento'],
        likes: 392,
        isPro: true,
        hasVideo: false),
    _BlogPost(
        emoji: '👕',
        title: 'Camisas retrô: o novo ouro do colecionismo esportivo',
        author: 'shirts_br',
        authorEmoji: '👕',
        date: '5 Mai 2025',
        readTime: '4 min',
        preview:
            'Camisas de copa do mundo antigas batem recordes em leilões. Saiba como autenticar e conservar suas peças...',
        tags: ['Futebol', 'Camisas', 'Retrô'],
        likes: 614,
        isPro: false,
        hasVideo: true),
  ];

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.82,
        ),
        itemCount: _posts.length,
        itemBuilder: (context, index) => _BlogCard(post: _posts[index]),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _posts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFD4A020).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: const Color(0xFFD4A020).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Text('✦',
                    style: TextStyle(color: Color(0xFFD4A020), fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                      'Blogs são publicados por colecionadores Garagem Pro verificados',
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 12, color: const Color(0xFFD4A020))),
                ),
              ],
            ),
          );
        }
        return _BlogCard(post: _posts[index - 1]);
      },
    );
  }
}

class _BlogCard extends StatefulWidget {
  final _BlogPost post;
  const _BlogCard({required this.post});

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _liked = false;

  _BlogPost get post => widget.post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openBlog(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2E2A22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF242018),
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Stack(
                children: [
                  Center(
                      child: Text(post.emoji,
                          style: const TextStyle(fontSize: 60))),
                  if (post.hasVideo)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            const Icon(Icons.play_circle_filled_rounded,
                                color: Color(0xFFD4622A), size: 14),
                            const SizedBox(width: 4),
                            Text('COM VÍDEO',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 9,
                                    color: Colors.white,
                                    letterSpacing: 0.5)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: post.tags
                        .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4622A).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(tag,
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 9,
                                      color: const Color(0xFFD4622A),
                                      letterSpacing: 0.5)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  Text(post.title,
                      style: GoogleFonts.bebasNeue(
                          fontSize: 18,
                          letterSpacing: 1,
                          color: const Color(0xFFF0ECE4),
                          height: 1.2)),
                  const SizedBox(height: 8),
                  Text(post.preview,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 12,
                          color: const Color(0xFF7A7060),
                          height: 1.5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Text(post.authorEmoji,
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(post.author,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF0ECE4))),
                      if (post.isPro) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                              color: const Color(0xFFD4A020).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text('✦ PRO',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 8, color: const Color(0xFFD4A020))),
                        ),
                      ],
                      const Spacer(),
                      const Icon(Icons.timer_outlined,
                          color: Color(0xFF7A7060), size: 12),
                      const SizedBox(width: 3),
                      Text(post.readTime,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 10, color: const Color(0xFF7A7060))),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => setState(() => _liked = !_liked),
                        child: Row(
                          children: [
                            Icon(
                                _liked ? Icons.favorite : Icons.favorite_border,
                                color: _liked
                                    ? const Color(0xFFD4622A)
                                    : const Color(0xFF7A7060),
                                size: 16),
                            const SizedBox(width: 3),
                            Text('${post.likes + (_liked ? 1 : 0)}',
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 11,
                                    color: const Color(0xFF7A7060))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openBlog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F0E0B),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: const Color(0xFF3A3428),
                          borderRadius: BorderRadius.circular(2)))),
              Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color(0xFF1A1814),
                  child: Center(
                      child: Text(post.emoji,
                          style: const TextStyle(fontSize: 80)))),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: post.tags
                            .map((tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD4622A)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(tag,
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 9,
                                          color: const Color(0xFFD4622A))),
                                ))
                            .toList()),
                    const SizedBox(height: 12),
                    Text(post.title,
                        style: GoogleFonts.bebasNeue(
                            fontSize: 28,
                            letterSpacing: 1.5,
                            color: const Color(0xFFF0ECE4),
                            height: 1.1)),
                    const SizedBox(height: 8),
                    Row(children: [
                      Text(post.authorEmoji,
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(post.author,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFD4622A))),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(
                              '· ${post.date} · ${post.readTime} de leitura',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 11,
                                  color: const Color(0xFF7A7060)))),
                    ]),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFF2E2A22)),
                    const SizedBox(height: 20),
                    Text(post.preview,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 15,
                            color: const Color(0xFFB0A898),
                            height: 1.8)),
                    const SizedBox(height: 16),
                    Text(
                        'O mercado de colecionáveis tem crescido exponencialmente nos últimos anos. Com o aumento do interesse de novos colecionadores e a valorização de peças raras, o setor movimenta bilhões anualmente no mundo todo.\n\nNo Brasil, a comunidade cresce a cada ano com feiras, encontros e grupos online dedicados. Plataformas como o Instacollection facilitam a conexão entre colecionadores de todo o país.',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 15,
                            color: const Color(0xFFB0A898),
                            height: 1.8)),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════
// ABA — GARAGENS
// ══════════════════════════════════════
class _GaragesTab extends StatelessWidget {
  final String search;
  final bool isDesktop;
  const _GaragesTab({required this.search, required this.isDesktop});

  final List<_ExploreGarage> _garages = const [
    _ExploreGarage(
        emoji: '🏎️',
        name: 'Garage TCG',
        handle: '@pokemon_rafael',
        pieces: 347,
        followers: 1200,
        category: 'Cards',
        city: 'São Paulo'),
    _ExploreGarage(
        emoji: '🎸',
        name: 'Garagem do Vinil',
        handle: '@vinyl_br',
        pieces: 128,
        followers: 890,
        category: 'Vinils',
        city: 'São Paulo'),
    _ExploreGarage(
        emoji: '🦸',
        name: 'HQ Garage',
        handle: '@hq_collector',
        pieces: 89,
        followers: 654,
        category: 'Quadrinhos',
        city: 'Rio de Janeiro'),
    _ExploreGarage(
        emoji: '🚂',
        name: 'Trainz Collection',
        handle: '@trains_sp',
        pieces: 214,
        followers: 432,
        category: 'Miniaturas',
        city: 'Curitiba'),
    _ExploreGarage(
        emoji: '👕',
        name: 'Shirts Brasil',
        handle: '@shirts_br',
        pieces: 67,
        followers: 987,
        category: 'Camisas',
        city: 'Belo Horizonte'),
    _ExploreGarage(
        emoji: '🎴',
        name: 'Magic SP',
        handle: '@magic_sp',
        pieces: 503,
        followers: 2100,
        category: 'Cards',
        city: 'São Paulo'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = search.isEmpty
        ? _garages
        : _garages
            .where((g) =>
                g.name.toLowerCase().contains(search.toLowerCase()) ||
                g.handle.toLowerCase().contains(search.toLowerCase()))
            .toList();

    if (isDesktop) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 12,
          childAspectRatio: 2.6,
        ),
        itemCount: filtered.length,
        itemBuilder: (context, index) =>
            _GarageListCard(garage: filtered[index]),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: filtered.length,
      itemBuilder: (context, index) => _GarageListCard(garage: filtered[index]),
    );
  }
}

class _GarageListCard extends StatefulWidget {
  final _ExploreGarage garage;
  const _GarageListCard({required this.garage});

  @override
  State<_GarageListCard> createState() => _GarageListCardState();
}

class _GarageListCardState extends State<_GarageListCard> {
  bool _following = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF242018),
              border: Border.all(color: const Color(0xFFD4622A), width: 1.5),
            ),
            child: Center(
                child: Text(widget.garage.emoji,
                    style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.garage.name,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0ECE4))),
                const SizedBox(height: 2),
                Text(widget.garage.handle,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 11, color: const Color(0xFF7A7060))),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _StatChip(
                        icon: Icons.grid_view_rounded,
                        value: '${widget.garage.pieces}'),
                    const SizedBox(width: 8),
                    _StatChip(
                        icon: Icons.people_rounded,
                        value: _formatNum(widget.garage.followers)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: const Color(0xFF2E2A22),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(widget.garage.category,
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 9, color: const Color(0xFF7A7060))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => setState(() => _following = !_following),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: _following
                    ? const Color(0xFF1A1814)
                    : const Color(0xFFD4622A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: _following
                        ? const Color(0xFF3A3428)
                        : const Color(0xFFD4622A)),
              ),
              child: Text(_following ? 'SEGUINDO' : 'SEGUIR',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 12,
                      letterSpacing: 1.5,
                      color:
                          _following ? const Color(0xFF7A7060) : Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNum(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  const _StatChip({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF7A7060), size: 11),
        const SizedBox(width: 3),
        Text(value,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 9, color: const Color(0xFF7A7060))),
      ],
    );
  }
}

// ── BOTTOM NAV ──
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final bool isDesktop;
  final Function(int) onTap;
  const _BottomNav(
      {required this.currentIndex,
      required this.isDesktop,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
          color: Color(0xFF1A1814),
          border: Border(top: BorderSide(color: Color(0xFF2E2A22)))),
      child: Center(
        child: SizedBox(
          width: isDesktop ? 900.0 : double.infinity,
          child: Row(
            children: [
              _NavItem(
                  icon: Icons.home_rounded,
                  label: '',
                  active: currentIndex == 0,
                  onTap: () => onTap(0)),
              _NavItem(
                  icon: Icons.search_rounded,
                  label: 'EXPLORAR',
                  active: currentIndex == 1,
                  onTap: () => onTap(1)),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTap(2),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                              color: const Color(0xFFD4622A),
                              borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 26),
                        ),
                      ]),
                ),
              ),
              _NavItem(
                  icon: Icons.chat_bubble_rounded,
                  label: 'DMs',
                  active: currentIndex == 3,
                  onTap: () => onTap(3)),
              _NavItem(
                  icon: Icons.storefront_rounded,
                  label: 'MARKET',
                  active: currentIndex == 4,
                  onTap: () => onTap(4)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavItem(
      {required this.icon,
      required this.label,
      required this.active,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color:
                    active ? const Color(0xFFD4622A) : const Color(0xFF7A7060),
                size: 22),
            if (label.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(label,
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 8,
                      color: active
                          ? const Color(0xFFD4622A)
                          : const Color(0xFF7A7060),
                      letterSpacing: 0.5)),
            ],
          ],
        ),
      ),
    );
  }
}

// ── EXPLORE PIECE CARD (grid 3) ──
class _ExplorePieceCard extends StatelessWidget {
  final _ExplorePiece piece;
  const _ExplorePieceCard({required this.piece});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF242018),
                borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
              ),
              child: Center(
                  child:
                      Text(piece.emoji, style: const TextStyle(fontSize: 48))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(piece.name,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0ECE4)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(piece.series,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 10, color: const Color(0xFF7A7060))),
                const SizedBox(height: 5),
                Text(piece.value,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 14,
                        color: const Color(0xFFD4A020),
                        letterSpacing: 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── MODELOS ──
class _ExplorePiece {
  final String emoji,
      name,
      series,
      value,
      category,
      garage,
      garageEmoji,
      condition,
      description;
  const _ExplorePiece({
    required this.emoji,
    required this.name,
    required this.series,
    required this.value,
    required this.category,
    required this.garage,
    required this.garageEmoji,
    required this.condition,
    required this.description,
  });
}

class _ExploreGarage {
  final String emoji, name, handle, category, city;
  final int pieces, followers;
  const _ExploreGarage(
      {required this.emoji,
      required this.name,
      required this.handle,
      required this.pieces,
      required this.followers,
      required this.category,
      required this.city});
}

class _Event {
  final String emoji,
      title,
      organizer,
      organizerEmoji,
      date,
      location,
      description,
      type;
  final int attendees;
  final bool isPro;
  final Color typeColor;
  const _Event(
      {required this.emoji,
      required this.title,
      required this.organizer,
      required this.organizerEmoji,
      required this.date,
      required this.location,
      required this.description,
      required this.attendees,
      required this.isPro,
      required this.type,
      required this.typeColor});
}

class _BlogPost {
  final String emoji, title, author, authorEmoji, date, readTime, preview;
  final List<String> tags;
  final int likes;
  final bool isPro, hasVideo;
  const _BlogPost(
      {required this.emoji,
      required this.title,
      required this.author,
      required this.authorEmoji,
      required this.date,
      required this.readTime,
      required this.preview,
      required this.tags,
      required this.likes,
      required this.isPro,
      required this.hasVideo});
}
