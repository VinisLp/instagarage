import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/main_layout.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});
  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'Todos';
  bool _isGridView = false; // toggle lista/grid

  final List<String> _categories = [
    'Todos',
    'Cards',
    'Vinils',
    'Quadrinhos',
    'Miniaturas',
    'Camisas',
    'Action Figures',
  ];

  final List<_MarketItem> _directItems = [
    _MarketItem(
        id: '1',
        emoji: '🐲',
        name: 'Charizard Holo Base Set',
        seller: 'pokemon_rafael',
        sellerEmoji: '🏎️',
        price: 2400,
        originalPrice: null,
        category: 'Cards',
        condition: 'Near Mint',
        description: 'Card original 1999, sem marcas, sleeve desde que recebi.',
        isSold: false,
        isFavorited: false),
    _MarketItem(
        id: '2',
        emoji: '🎸',
        name: 'Led Zeppelin IV - 1971',
        seller: 'vinyl_br',
        sellerEmoji: '🎸',
        price: 1200,
        originalPrice: 900,
        category: 'Vinils',
        condition: 'Good',
        description:
            'Prensagem original UK, pequenos arranhões na capa mas disco impecável.',
        isSold: false,
        isFavorited: true),
    _MarketItem(
        id: '3',
        emoji: '🦸',
        name: 'Amazing Fantasy #15',
        seller: 'hq_collector',
        sellerEmoji: '🦸',
        price: 380,
        originalPrice: null,
        category: 'Quadrinhos',
        condition: 'Good',
        description: 'Reprodução certificada, emoldurada.',
        isSold: true,
        isFavorited: false),
    _MarketItem(
        id: '4',
        emoji: '🏎️',
        name: 'Ferrari 250 GTO Burago',
        seller: 'cars_col',
        sellerEmoji: '🚗',
        price: 420,
        originalPrice: null,
        category: 'Miniaturas',
        condition: 'Perfeito',
        description: 'Escala 1:18, lacrada na caixa original.',
        isSold: false,
        isFavorited: false),
    _MarketItem(
        id: '5',
        emoji: '⚡',
        name: 'Pikachu Promo 1998',
        seller: 'pokemon_rafael',
        sellerEmoji: '🏎️',
        price: 4800,
        originalPrice: null,
        category: 'Cards',
        condition: 'Mint',
        description: 'Pikachu Promo exclusivo do Pokémon World Championships.',
        isSold: false,
        isFavorited: false),
    _MarketItem(
        id: '6',
        emoji: '👕',
        name: 'Camisa Brasil 1970',
        seller: 'shirts_br',
        sellerEmoji: '👕',
        price: 3200,
        originalPrice: null,
        category: 'Camisas',
        condition: 'Good',
        description: 'Camisa histórica da Copa do Mundo de 1970.',
        isSold: false,
        isFavorited: true),
  ];

  final List<_CartItem> _cart = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<_MarketItem> get _filtered => _directItems
      .where((i) =>
          _selectedCategory == 'Todos' || i.category == _selectedCategory)
      .toList();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: NavIndex.market,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Column(children: [
      // ── Topbar ──
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('MARKETPLACE',
                style: GoogleFonts.bebasNeue(
                    fontSize: isDesktop ? 28 : 22,
                    color: const Color(0xFFF0ECE4),
                    letterSpacing: 3)),
            Text('Compre, venda e arremate',
                style: GoogleFonts.familjenGrotesk(
                    fontSize: 11, color: const Color(0xFF7A7060))),
          ]),
          const Spacer(),
          // Carrinho
          GestureDetector(
            onTap: _openCart,
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  color: const Color(0xFF1A1814),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF2E2A22))),
              child: Stack(clipBehavior: Clip.none, children: [
                const Icon(Icons.shopping_cart_outlined,
                    color: Color(0xFFF0ECE4), size: 20),
                if (_cart.isNotEmpty)
                  Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                            color: Color(0xFFD4622A), shape: BoxShape.circle),
                        child: Center(
                            child: Text('${_cart.length}',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700))),
                      )),
              ]),
            ),
          ),
          // Favoritos
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2E2A22))),
            child: const Icon(Icons.favorite_border_rounded,
                color: Color(0xFFF0ECE4), size: 20),
          ),
        ]),
      ),

      // ── Abas ──
      TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFFD4622A),
        indicatorWeight: 2,
        labelColor: const Color(0xFFD4622A),
        unselectedLabelColor: const Color(0xFF7A7060),
        labelStyle: GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5),
        unselectedLabelStyle:
            GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5),
        tabs: const [
          Tab(text: 'VENDA DIRETA'),
          Tab(text: 'ÁLBUNS'),
          Tab(text: 'LEILÕES')
        ],
      ),

      const SizedBox(height: 8),

      // ── Filtros + Toggle ──
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          // Filtros de categoria
          Expanded(
              child: SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                                : const Color(0xFF7A7060))),
                  ),
                );
              },
            ),
          )),
          const SizedBox(width: 8),
          // Toggle lista/grid
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF2E2A22))),
            child: Row(children: [
              _ToggleBtn(
                  icon: Icons.view_list_rounded,
                  active: !_isGridView,
                  onTap: () => setState(() => _isGridView = false)),
              const SizedBox(width: 2),
              _ToggleBtn(
                  icon: Icons.grid_view_rounded,
                  active: _isGridView,
                  onTap: () => setState(() => _isGridView = true)),
            ]),
          ),
        ]),
      ),

      const SizedBox(height: 8),

      // ── Conteúdo ──
      Expanded(
          child: TabBarView(controller: _tabController, children: [
        _buildDirectSales(isDesktop),
        _buildEmptyTab('📦', 'ÁLBUNS EM BREVE'),
        _buildEmptyTab('🔨', 'LEILÕES EM BREVE'),
      ])),
    ]);
  }

  Widget _buildEmptyTab(String emoji, String label) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(emoji, style: const TextStyle(fontSize: 48)),
      const SizedBox(height: 12),
      Text(label,
          style: GoogleFonts.bebasNeue(
              fontSize: 18, color: const Color(0xFF4A4438), letterSpacing: 2)),
    ]));
  }

  Widget _buildDirectSales(bool isDesktop) {
    final items = _filtered;
    if (items.isEmpty) {
      return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('🔍', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 12),
        Text('NENHUM ITEM ENCONTRADO',
            style: GoogleFonts.bebasNeue(
                fontSize: 16,
                color: const Color(0xFF4A4438),
                letterSpacing: 2)),
      ]));
    }

    // Grid no desktop ou quando toggle ativo
    if (_isGridView || isDesktop) {
      final crossCount = isDesktop ? 3 : 2;
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isDesktop ? 0.72 : 0.68,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => _GridItemCard(
          item: items[index],
          onBuy: () => _handleBuy(items[index]),
          onFavorite: () => setState(
              () => items[index].isFavorited = !items[index].isFavorited),
          onMessage: () =>
              _openMessageSheet(items[index].seller, items[index].sellerEmoji),
        ),
      );
    }

    // Lista (mobile padrão)
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      itemCount: items.length,
      itemBuilder: (context, index) => _ListItemCard(
        item: items[index],
        onBuy: () => _handleBuy(items[index]),
        onFavorite: () => setState(
            () => items[index].isFavorited = !items[index].isFavorited),
        onMessage: () =>
            _openMessageSheet(items[index].seller, items[index].sellerEmoji),
      ),
    );
  }

  void _handleBuy(_MarketItem item) {
    if (!_cart.any((c) => c.id == item.id)) {
      setState(() => _cart.add(_CartItem(
          id: item.id,
          name: item.name,
          emoji: item.emoji,
          price: item.price,
          seller: item.seller)));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${item.emoji} adicionado ao carrinho!',
            style: GoogleFonts.familjenGrotesk(fontSize: 13)),
        backgroundColor: const Color(0xFF4CAF7A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
            label: 'VER', textColor: Colors.white, onPressed: _openCart),
      ));
    }
  }

  void _openMessageSheet(String seller, String sellerEmoji) {
    final controller = TextEditingController(
        text: 'Olá! Tenho interesse neste item. Ainda está disponível?');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF3A3428),
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Row(children: [
            Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF242018),
                    border:
                        Border.all(color: const Color(0xFFD4622A), width: 1.5)),
                child: Center(
                    child: Text(sellerEmoji,
                        style: const TextStyle(fontSize: 20)))),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('MENSAGEM',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 18,
                      color: const Color(0xFFF0ECE4),
                      letterSpacing: 2)),
              Text('@$seller',
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 12, color: const Color(0xFF7A7060))),
            ]),
          ]),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2E2A22)),
          const SizedBox(height: 12),
          TextField(
              controller: controller,
              maxLines: 3,
              style: GoogleFonts.familjenGrotesk(
                  color: const Color(0xFFF0ECE4), fontSize: 14),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF242018),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF3A3428))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF3A3428))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFD4622A))),
                  contentPadding: const EdgeInsets.all(14))),
          const SizedBox(height: 16),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Mensagem enviada! 💬',
                          style: GoogleFonts.familjenGrotesk(fontSize: 13)),
                      backgroundColor: const Color(0xFF4CAF7A),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4622A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0),
                child: Text('ENVIAR MENSAGEM',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 16, letterSpacing: 2, color: Colors.white)),
              )),
        ]),
      ),
    );
  }

  void _openCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
          builder: (context, setSheet) => DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 0.92,
                expand: false,
                builder: (context, sc) => Column(children: [
                  Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: const Color(0xFF3A3428),
                          borderRadius: BorderRadius.circular(2))),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        const Icon(Icons.shopping_cart_outlined,
                            color: Color(0xFFD4622A), size: 22),
                        const SizedBox(width: 8),
                        Text('CARRINHO',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                color: const Color(0xFFF0ECE4),
                                letterSpacing: 2)),
                        if (_cart.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFD4622A),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('${_cart.length}',
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)))
                        ],
                      ])),
                  const SizedBox(height: 8),
                  const Divider(color: Color(0xFF2E2A22)),
                  Expanded(
                      child: _cart.isEmpty
                          ? Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  const Text('🛒',
                                      style: TextStyle(fontSize: 48)),
                                  const SizedBox(height: 12),
                                  Text('CARRINHO VAZIO',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 16,
                                          color: const Color(0xFF4A4438),
                                          letterSpacing: 2))
                                ]))
                          : ListView.builder(
                              controller: sc,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _cart.length,
                              itemBuilder: (context, index) {
                                final ci = _cart[index];
                                return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF242018),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: const Color(0xFF3A3428))),
                                    child: Row(children: [
                                      Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF1A1814),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(ci.emoji,
                                                  style: const TextStyle(
                                                      fontSize: 24)))),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text(ci.name,
                                                style:
                                                    GoogleFonts.familjenGrotesk(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: const Color(
                                                            0xFFF0ECE4))),
                                            Text('@${ci.seller}',
                                                style:
                                                    GoogleFonts.familjenGrotesk(
                                                        fontSize: 11,
                                                        color: const Color(
                                                            0xFF7A7060))),
                                          ])),
                                      Text('R\$ ${ci.price.toInt()}',
                                          style: GoogleFonts.bebasNeue(
                                              fontSize: 16,
                                              color: const Color(0xFFD4A020),
                                              letterSpacing: 1)),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                          onTap: () {
                                            setState(
                                                () => _cart.removeAt(index));
                                            setSheet(() {});
                                          },
                                          child: const Icon(Icons.close_rounded,
                                              color: Color(0xFF7A7060),
                                              size: 18)),
                                    ]));
                              })),
                  if (_cart.isNotEmpty) ...[
                    const Divider(color: Color(0xFF2E2A22)),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${_cart.length} itens',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 13,
                                        color: const Color(0xFF7A7060))),
                                Text(
                                    'R\$ ${_cart.fold<double>(0, (s, i) => s + i.price).toInt()}',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 22,
                                        color: const Color(0xFFD4A020),
                                        letterSpacing: 1)),
                              ]),
                          const SizedBox(height: 12),
                          SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() => _cart.clear());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Pedido confirmado! 🎉',
                                              style:
                                                  GoogleFonts.familjenGrotesk(
                                                      fontSize: 13)),
                                          backgroundColor:
                                              const Color(0xFF4CAF7A),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD4622A),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    elevation: 0),
                                child: Text('FINALIZAR COMPRA',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 18,
                                        letterSpacing: 2,
                                        color: Colors.white)),
                              )),
                        ])),
                  ],
                ]),
              )),
    );
  }
}

// ══════════════════════════════════════
// CARD LISTA (mobile padrão)
// ══════════════════════════════════════
class _ListItemCard extends StatelessWidget {
  final _MarketItem item;
  final VoidCallback onBuy, onFavorite, onMessage;
  const _ListItemCard(
      {required this.item,
      required this.onBuy,
      required this.onFavorite,
      required this.onMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: item.isSold
                  ? const Color(0xFF3A3428)
                  : const Color(0xFF2E2A22))),
      child: Row(children: [
        // Imagem
        ClipRRect(
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(13)),
          child: Stack(children: [
            Container(
                width: 110,
                height: 110,
                color: const Color(0xFF242018),
                child: Center(
                    child: Text(item.emoji,
                        style: const TextStyle(fontSize: 52)))),
            if (item.isSold)
              Container(
                  width: 110,
                  height: 110,
                  color: Colors.black.withOpacity(0.6),
                  child: Center(
                      child: Text('VENDIDO',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 1)))),
            Positioned(
                top: 6,
                left: 6,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(item.condition,
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 8, color: Colors.white)))),
          ]),
        ),
        // Info
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                            child: Text(item.name,
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFF0ECE4)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)),
                        GestureDetector(
                            onTap: onFavorite,
                            child: Icon(
                                item.isFavorited
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: item.isFavorited
                                    ? const Color(0xFFD4622A)
                                    : const Color(0xFF7A7060),
                                size: 18)),
                      ]),
                      const SizedBox(height: 2),
                      Row(children: [
                        Text(item.sellerEmoji,
                            style: const TextStyle(fontSize: 11)),
                        const SizedBox(width: 4),
                        Text('@${item.seller}',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 11, color: const Color(0xFF7A7060)))
                      ]),
                      const SizedBox(height: 6),
                      Text(item.description,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 11, color: const Color(0xFF7A7060)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 8),
                      Row(children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.originalPrice != null)
                                Text('R\$ ${item.originalPrice!.toInt()}',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 10,
                                        color: const Color(0xFF4A4438),
                                        decoration:
                                            TextDecoration.lineThrough)),
                              Text('R\$ ${item.price.toInt()}',
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 18,
                                      color: const Color(0xFFD4A020),
                                      letterSpacing: 1)),
                            ]),
                        const Spacer(),
                        if (!item.isSold) ...[
                          GestureDetector(
                              onTap: onMessage,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF242018),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: const Color(0xFF3A3428))),
                                  child: const Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      color: Color(0xFFF0ECE4),
                                      size: 14))),
                          const SizedBox(width: 6),
                          GestureDetector(
                              onTap: onBuy,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD4622A),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text('COMPRAR',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 12,
                                          letterSpacing: 1,
                                          color: Colors.white)))),
                        ] else
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF2E2A22),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('VENDIDO',
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 11,
                                      color: const Color(0xFF4A4438)))),
                      ]),
                    ]))),
      ]),
    );
  }
}

// ══════════════════════════════════════
// CARD GRID (desktop / toggle)
// ══════════════════════════════════════
class _GridItemCard extends StatelessWidget {
  final _MarketItem item;
  final VoidCallback onBuy, onFavorite, onMessage;
  const _GridItemCard(
      {required this.item,
      required this.onBuy,
      required this.onFavorite,
      required this.onMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: item.isSold
                  ? const Color(0xFF3A3428)
                  : const Color(0xFF2E2A22))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Imagem
        Stack(children: [
          Container(
              height: 140,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0xFF242018),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(13))),
              child: Center(
                  child:
                      Text(item.emoji, style: const TextStyle(fontSize: 60)))),
          if (item.isSold)
            Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(13))),
                    child: Center(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                color: const Color(0xFFD44A4A),
                                borderRadius: BorderRadius.circular(6)),
                            child: Text('VENDIDO',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 14, color: Colors.white)))))),
          Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                  onTap: onFavorite,
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle),
                      child: Icon(
                          item.isFavorited
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: item.isFavorited
                              ? const Color(0xFFD4622A)
                              : Colors.white,
                          size: 16)))),
          Positioned(
              top: 8,
              left: 8,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(item.condition,
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 8, color: Colors.white)))),
        ]),
        // Info
        Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.name,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF0ECE4)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Row(children: [
                Text(item.sellerEmoji, style: const TextStyle(fontSize: 10)),
                const SizedBox(width: 3),
                Text('@${item.seller}',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 10, color: const Color(0xFF7A7060)))
              ]),
              const SizedBox(height: 6),
              if (item.originalPrice != null)
                Text('R\$ ${item.originalPrice!.toInt()}',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 9,
                        color: const Color(0xFF4A4438),
                        decoration: TextDecoration.lineThrough)),
              Text('R\$ ${item.price.toInt()}',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 16,
                      color: const Color(0xFFD4A020),
                      letterSpacing: 1)),
              const SizedBox(height: 8),
              if (!item.isSold)
                Row(children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: onMessage,
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF242018),
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: const Color(0xFF3A3428))),
                              child: Center(
                                  child: const Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      color: Color(0xFFF0ECE4),
                                      size: 14))))),
                  const SizedBox(width: 6),
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                          onTap: onBuy,
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFD4622A),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                  child: Text('COMPRAR',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 12,
                                          letterSpacing: 1,
                                          color: Colors.white)))))),
                ])
              else
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                        color: const Color(0xFF2E2A22),
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                        child: Text('INDISPONÍVEL',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 11,
                                color: const Color(0xFF4A4438))))),
            ])),
      ]),
    );
  }
}

// ── Toggle Button ──
class _ToggleBtn extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _ToggleBtn(
      {required this.icon, required this.active, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 30,
          height: 28,
          decoration: BoxDecoration(
              color: active ? const Color(0xFFD4622A) : Colors.transparent,
              borderRadius: BorderRadius.circular(6)),
          child: Icon(icon,
              color: active ? Colors.white : const Color(0xFF7A7060), size: 15),
        ));
  }
}

// ── Modelos ──
class _MarketItem {
  final String id,
      name,
      seller,
      sellerEmoji,
      emoji,
      category,
      condition,
      description;
  final double price;
  final double? originalPrice;
  bool isSold, isFavorited;
  _MarketItem(
      {required this.id,
      required this.name,
      required this.seller,
      required this.sellerEmoji,
      required this.emoji,
      required this.category,
      required this.condition,
      required this.description,
      required this.price,
      required this.originalPrice,
      required this.isSold,
      required this.isFavorited});
}

class _CartItem {
  final String id, name, emoji, seller;
  final double price;
  const _CartItem(
      {required this.id,
      required this.name,
      required this.emoji,
      required this.seller,
      required this.price});
}
