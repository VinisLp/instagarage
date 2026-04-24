import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../feed/feed_screen.dart';
import '../explore/explore_screen.dart';
import '../dm/dm_screen.dart';
import '../piece/ai_scan_screen.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'Todos';

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
        description:
            'Card original 1999, sem marcas, sleeve desde que recebi. Autenticidade garantida.',
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
        description:
            'Reprodução certificada, emoldurada. Perfeita para decoração.',
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
        description: 'Escala 1:18, lacrada na caixa original. Raridade!',
        isSold: false,
        isFavorited: false),
  ];

  final List<_Album> _albums = [
    _Album(
      id: 'a1',
      title: 'Álbum da Semana — Pokémon Base Set',
      seller: 'pokemon_rafael',
      sellerEmoji: '🏎️',
      description:
          'Os três starters holográficos da Base Set original de 1999. Todos avaliados e autenticados. Oportunidade única para completar sua coleção.',
      deadline: DateTime.now().add(const Duration(hours: 18)),
      isSold: false,
      isFavorited: true,
      items: [
        _MarketItem(
            id: 'a1i1',
            emoji: '🐲',
            name: 'Charizard Holo',
            seller: 'pokemon_rafael',
            sellerEmoji: '🏎️',
            price: 2400,
            originalPrice: null,
            category: 'Cards',
            condition: 'Near Mint',
            description: 'Sem marcas visíveis, guardado em sleeve desde 1999.',
            isSold: false,
            isFavorited: false),
        _MarketItem(
            id: 'a1i2',
            emoji: '🐢',
            name: 'Blastoise Holo',
            seller: 'pokemon_rafael',
            sellerEmoji: '🏎️',
            price: 1800,
            originalPrice: null,
            category: 'Cards',
            condition: 'Near Mint',
            description: 'Excelente estado, pequena marca no canto inferior.',
            isSold: false,
            isFavorited: false),
        _MarketItem(
            id: 'a1i3',
            emoji: '🌿',
            name: 'Venusaur Holo',
            seller: 'pokemon_rafael',
            sellerEmoji: '🏎️',
            price: 1600,
            originalPrice: null,
            category: 'Cards',
            condition: 'Good',
            description: 'Bom estado geral, leve whitening nas bordas.',
            isSold: true,
            isFavorited: false),
      ],
    ),
    _Album(
      id: 'a2',
      title: 'Álbum do Dia — Vinils Raros',
      seller: 'vinyl_br',
      sellerEmoji: '🎸',
      description:
          'Dois clássicos absolutos do rock progressivo em vinil original. Prensagens britânicas raras, ideais para colecionadores exigentes.',
      deadline: DateTime.now().add(const Duration(hours: 5)),
      isSold: false,
      isFavorited: false,
      items: [
        _MarketItem(
            id: 'a2i1',
            emoji: '🎸',
            name: 'Pink Floyd - The Wall',
            seller: 'vinyl_br',
            sellerEmoji: '🎸',
            price: 950,
            originalPrice: null,
            category: 'Vinils',
            condition: 'Good',
            description:
                'Duplo álbum, prensagem UK 1979. Capa com desgaste leve.',
            isSold: false,
            isFavorited: false),
        _MarketItem(
            id: 'a2i2',
            emoji: '🎵',
            name: 'Beatles - Abbey Road',
            seller: 'vinyl_br',
            sellerEmoji: '🎸',
            price: 800,
            originalPrice: null,
            category: 'Vinils',
            condition: 'Near Mint',
            description: 'Prensagem original 1969, disco sem arranhões.',
            isSold: false,
            isFavorited: false),
      ],
    ),
  ];

  final List<_Auction> _auctions = [
    _Auction(
        id: 'au1',
        emoji: '🎴',
        name: 'Black Lotus - Magic Alpha 1993',
        seller: 'magic_sp',
        sellerEmoji: '🎴',
        startPrice: 50000,
        currentBid: 78000,
        bids: 12,
        deadline: DateTime.now().add(const Duration(hours: 2, minutes: 34)),
        category: 'Cards',
        condition: 'Near Mint',
        description:
            'Um dos cards mais raros do mundo. Autenticidade verificada por PSA. Grau 8.5.',
        isSold: false,
        isFavorited: true),
    _Auction(
        id: 'au2',
        emoji: '👕',
        name: 'Camisa Seleção Brasil Copa 1970',
        seller: 'shirts_br',
        sellerEmoji: '👕',
        startPrice: 2000,
        currentBid: 3200,
        bids: 7,
        deadline: DateTime.now().add(const Duration(hours: 11)),
        category: 'Camisas',
        condition: 'Good',
        description:
            'Camisa histórica da Copa do Mundo de 1970. Com certificado de autenticidade.',
        isSold: false,
        isFavorited: false),
    _Auction(
        id: 'au3',
        emoji: '🚂',
        name: 'Hot Wheels Redline 1968',
        seller: 'trains_sp',
        sellerEmoji: '🚂',
        startPrice: 500,
        currentBid: 950,
        bids: 15,
        deadline: DateTime.now().add(const Duration(minutes: 45)),
        category: 'Miniaturas',
        condition: 'Good',
        description:
            'Raridade original dos anos 60. Pintura original preservada. Rodas Redline intactas.',
        isSold: true,
        isFavorited: false),
  ];

  final List<_FavoriteItem> _favorites = [];

  // ✅ Carrinho de compras
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: Column(
          children: [
            // ── TOPBAR ✅ padding top maior ──
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MARKETPLACE',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 26,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 3,
                        ),
                      ),
                      Text(
                        'Compre, venda e arremate',
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 11,
                          color: const Color(0xFF7A7060),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // ✅ Botão Carrinho
                  GestureDetector(
                    onTap: _openCart,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF2E2A22)),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: Color(0xFFF0ECE4),
                            size: 20,
                          ),
                          if (_cart.isNotEmpty)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD4622A),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${_cart.length}',
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Botão Favoritos
                  GestureDetector(
                    onTap: _openFavorites,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF2E2A22)),
                      ),
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.favorite_border_rounded,
                            color: Color(0xFFF0ECE4),
                            size: 20,
                          ),
                          if (_favorites.isNotEmpty)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD4622A),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── ABAS ──
            TabBar(
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
                Tab(text: 'VENDA DIRETA'),
                Tab(text: 'ÁLBUNS'),
                Tab(text: 'LEILÕES'),
              ],
            ),

            // ✅ Espaço entre abas e filtros
            const SizedBox(height: 4),

            // ── FILTROS ✅ padding melhorado ──
            SizedBox(
              height: 46,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 6),
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
                              : const Color(0xFF2E2A22),
                        ),
                      ),
                      child: Text(
                        cat,
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF7A7060),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ✅ Espaço entre filtros e conteúdo
            const SizedBox(height: 4),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDirectSales(),
                  _buildAlbums(),
                  _buildAuctions(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: 4,
        onTap: (index) {
          if (index == 0)
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const FeedScreen()));
          else if (index == 1)
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ExploreScreen()));
          else if (index == 2)
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AiScanScreen()));
          else if (index == 3)
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const DmScreen()));
        },
      ),
    );
  }

  // ══════════════════════════════════════
  // ABA — VENDA DIRETA
  // ══════════════════════════════════════
  Widget _buildDirectSales() {
    final filtered = _directItems
        .where((i) =>
            _selectedCategory == 'Todos' || i.category == _selectedCategory)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return _DirectItemCard(
          item: item,
          onBuy: () {
            // ✅ Adiciona ao carrinho
            if (!_cart.any((c) => c.id == item.id)) {
              setState(() {
                _cart.add(_CartItem(
                  id: item.id,
                  name: item.name,
                  emoji: item.emoji,
                  price: item.price,
                  seller: item.seller,
                ));
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  '${item.emoji} ${item.name} adicionado ao carrinho!',
                  style: GoogleFonts.familjenGrotesk(fontSize: 13),
                ),
                backgroundColor: const Color(0xFF4CAF7A),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'VER CARRINHO',
                  textColor: Colors.white,
                  onPressed: _openCart,
                ),
              ));
            }
          },
          onFavorite: () {
            setState(() => item.isFavorited = !item.isFavorited);
            if (item.isFavorited) {
              _favorites.add(_FavoriteItem(
                  id: item.id,
                  name: item.name,
                  emoji: item.emoji,
                  type: 'item',
                  seller: item.seller));
            } else {
              _favorites.removeWhere((f) => f.id == item.id);
            }
          },
          onMessage: () => _openMessageSheet(item.seller, item.sellerEmoji),
        );
      },
    );
  }

  // ══════════════════════════════════════
  // ABA — ÁLBUNS
  // ══════════════════════════════════════
  Widget _buildAlbums() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _albums.length,
      itemBuilder: (context, index) {
        final album = _albums[index];
        return _AlbumCard(
          album: album,
          onFavorite: () {
            setState(() => album.isFavorited = !album.isFavorited);
            if (album.isFavorited) {
              _favorites.add(_FavoriteItem(
                  id: album.id,
                  name: album.title,
                  emoji: '📦',
                  type: 'album',
                  seller: album.seller));
            } else {
              _favorites.removeWhere((f) => f.id == album.id);
            }
          },
          onTap: () => _openAlbumSheet(album),
        );
      },
    );
  }

  // ══════════════════════════════════════
  // ABA — LEILÕES
  // ══════════════════════════════════════
  Widget _buildAuctions() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: _auctions.length,
      itemBuilder: (context, index) {
        final auction = _auctions[index];
        return _AuctionCard(
          auction: auction,
          onFavorite: () {
            setState(() => auction.isFavorited = !auction.isFavorited);
            if (auction.isFavorited) {
              _favorites.add(_FavoriteItem(
                  id: auction.id,
                  name: auction.name,
                  emoji: auction.emoji,
                  type: 'auction',
                  seller: auction.seller));
            } else {
              _favorites.removeWhere((f) => f.id == auction.id);
            }
          },
          onTap: () => _openAuctionSheet(auction),
        );
      },
    );
  }

  // ── MENSAGEM AO VENDEDOR ──
  void _openMessageSheet(String seller, String sellerEmoji) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final controller = TextEditingController(
          text: 'Olá! Tenho interesse neste item. Ainda está disponível?',
        );
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: const Color(0xFF3A3428),
                    borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF242018),
                      border: Border.all(
                          color: const Color(0xFFD4622A), width: 1.5),
                    ),
                    child: Center(
                        child: Text(sellerEmoji,
                            style: const TextStyle(fontSize: 20))),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MENSAGEM',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: const Color(0xFFF0ECE4),
                            letterSpacing: 2),
                      ),
                      Text(
                        '@$seller',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12, color: const Color(0xFF7A7060)),
                      ),
                    ],
                  ),
                ],
              ),
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
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Mensagem enviada para @$seller! 💬',
                          style: GoogleFonts.familjenGrotesk(fontSize: 13)),
                      backgroundColor: const Color(0xFF4CAF7A),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4622A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.send_rounded,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'ENVIAR MENSAGEM',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 16,
                            letterSpacing: 2,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── ABRIR ÁLBUM ──
  void _openAlbumSheet(_Album album) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F0E0B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) => StatefulBuilder(
          builder: (context, setSheetState) => Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: const Color(0xFF3A3428),
                    borderRadius: BorderRadius.circular(2)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text('📦', style: TextStyle(fontSize: 32)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            album.title,
                            style: GoogleFonts.bebasNeue(
                                fontSize: 18,
                                letterSpacing: 1,
                                color: const Color(0xFFF0ECE4)),
                          ),
                          Row(
                            children: [
                              Text(album.sellerEmoji,
                                  style: const TextStyle(fontSize: 12)),
                              const SizedBox(width: 4),
                              Text(
                                '@${album.seller}',
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 12,
                                    color: const Color(0xFFD4622A)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close_rounded,
                          color: Color(0xFF7A7060), size: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFF2E2A22)),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined,
                            color: Color(0xFFD4622A), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Prazo: ${_formatDeadline(album.deadline)}',
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 12,
                              color: const Color(0xFFD4622A),
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          '${album.items.length} itens',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 10, color: const Color(0xFF7A7060)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2E2A22)),
                      ),
                      child: Text(
                        album.description,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 13,
                            color: const Color(0xFFB0A898),
                            height: 1.6),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A020).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color(0xFFD4A020).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline_rounded,
                              color: Color(0xFFD4A020), size: 13),
                          const SizedBox(width: 6),
                          Text(
                            'Pagamento em 24h após reserva',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 11, color: const Color(0xFFD4A020)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ITENS DO ÁLBUM',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 9,
                          color: const Color(0xFF7A7060),
                          letterSpacing: 1.5),
                    ),
                    const SizedBox(height: 10),
                    ...album.items.map((item) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1814),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: item.isSold
                                    ? const Color(0xFF3A3428)
                                    : const Color(0xFF2E2A22)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF242018),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(item.emoji,
                                        style: const TextStyle(fontSize: 28))),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: item.isSold
                                              ? const Color(0xFF4A4438)
                                              : const Color(0xFFF0ECE4)),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF2E2A22),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            item.condition,
                                            style: GoogleFonts.jetBrainsMono(
                                                fontSize: 8,
                                                color: const Color(0xFF7A7060)),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'R\$ ${item.price.toInt()}',
                                          style: GoogleFonts.bebasNeue(
                                              fontSize: 16,
                                              color: item.isSold
                                                  ? const Color(0xFF4A4438)
                                                  : const Color(0xFFD4A020),
                                              letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                    if (item.description.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        item.description,
                                        style: GoogleFonts.familjenGrotesk(
                                            fontSize: 11,
                                            color: const Color(0xFF7A7060)),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (item.isSold)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD44A4A)
                                        .withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFFD44A4A)
                                            .withOpacity(0.4)),
                                  ),
                                  child: Text(
                                    'RESERVADO',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 11,
                                        letterSpacing: 1,
                                        color: const Color(0xFFD44A4A)),
                                  ),
                                )
                              else
                                GestureDetector(
                                  onTap: () {
                                    setSheetState(() => item.isSold = true);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFD4622A),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      'QUERO',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 13,
                                          letterSpacing: 1.5,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )),
                    if (album.items.every((i) => i.isSold)) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF7A).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF4CAF7A)),
                        ),
                        child: Center(
                            child: Text(
                          '✦ ÁLBUM COMPLETO',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 16,
                              letterSpacing: 2,
                              color: const Color(0xFF4CAF7A)),
                        )),
                      ),
                    ],
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

  // ── ABRIR LEILÃO ──
  void _openAuctionSheet(_Auction auction) {
    final bidController =
        TextEditingController(text: (auction.currentBid + 100).toString());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F0E0B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) => StatefulBuilder(
          builder: (context, setSheetState) {
            final isUrgent =
                auction.deadline.difference(DateTime.now()).inHours < 1;
            return Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFF3A3428),
                      borderRadius: BorderRadius.circular(2)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(auction.emoji, style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auction.name,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  color: const Color(0xFFF0ECE4)),
                            ),
                            Row(
                              children: [
                                Text(auction.sellerEmoji,
                                    style: const TextStyle(fontSize: 12)),
                                const SizedBox(width: 4),
                                Text(
                                  '@${auction.seller}',
                                  style: GoogleFonts.familjenGrotesk(
                                      fontSize: 12,
                                      color: const Color(0xFFD4622A)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close_rounded,
                            color: Color(0xFF7A7060), size: 24),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFF2E2A22)),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: auction.isSold
                                ? const Color(0xFF3A3428)
                                : isUrgent
                                    ? const Color(0xFFD4622A).withOpacity(0.5)
                                    : const Color(0xFF2E2A22),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                                child: Text(auction.emoji,
                                    style: const TextStyle(fontSize: 90))),
                            if (auction.isSold)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF4CAF7A),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'ARREMATADO 🏆',
                                        style: GoogleFonts.bebasNeue(
                                            fontSize: 22,
                                            letterSpacing: 2,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (!auction.isSold)
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isUrgent
                                        ? const Color(0xFFD4622A)
                                        : Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                          isUrgent
                                              ? Icons
                                                  .local_fire_department_rounded
                                              : Icons.timer_outlined,
                                          color: Colors.white,
                                          size: 12),
                                      const SizedBox(width: 4),
                                      Text(
                                        _formatDeadline(auction.deadline),
                                        style: GoogleFonts.jetBrainsMono(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: const Color(0xFF2E2A22),
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              auction.condition,
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10, color: const Color(0xFF7A7060)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: const Color(0xFF2E2A22),
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              auction.category,
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10, color: const Color(0xFF7A7060)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2E2A22)),
                        ),
                        child: Text(
                          auction.description,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 13,
                              color: const Color(0xFFB0A898),
                              height: 1.6),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2E2A22)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _BidStat(
                                label: 'Lance inicial',
                                value:
                                    'R\$ ${_formatPrice(auction.startPrice)}'),
                            Container(
                                width: 1,
                                height: 32,
                                color: const Color(0xFF2E2A22)),
                            _BidStat(
                                label: 'Lance atual',
                                value:
                                    'R\$ ${_formatPrice(auction.currentBid)}'),
                            Container(
                                width: 1,
                                height: 32,
                                color: const Color(0xFF2E2A22)),
                            _BidStat(label: 'Lances', value: '${auction.bids}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4A020).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color(0xFFD4A020).withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline_rounded,
                                color: Color(0xFFD4A020), size: 13),
                            const SizedBox(width: 6),
                            Text(
                              'Pagamento em 24h após arremate',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 11, color: const Color(0xFFD4A020)),
                            ),
                          ],
                        ),
                      ),
                      if (!auction.isSold) ...[
                        const SizedBox(height: 16),
                        Text(
                          'SEU LANCE (R\$)',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 9,
                              color: const Color(0xFF7A7060),
                              letterSpacing: 1.5),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: bidController,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.bebasNeue(
                              fontSize: 28,
                              color: const Color(0xFFF0ECE4),
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF242018),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFF3A3428))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFF3A3428))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFFD4622A))),
                            prefixText: 'R\$ ',
                            prefixStyle: GoogleFonts.bebasNeue(
                                fontSize: 28, color: const Color(0xFF7A7060)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        ),

                        // ✅ BOTÕES DE LANCE RÁPIDO
                        const SizedBox(height: 12),
                        Text(
                          'LANCE RÁPIDO',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 9,
                              color: const Color(0xFF7A7060),
                              letterSpacing: 1.5),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [100, 500, 1000, 5000].map((increment) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  final current =
                                      int.tryParse(bidController.text) ??
                                          auction.currentBid;
                                  bidController.text =
                                      (current + increment).toString();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF242018),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xFF3A3428)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+${increment >= 1000 ? '${increment ~/ 1000}k' : increment}',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 14,
                                          color: const Color(0xFFD4622A),
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              final bid = int.tryParse(bidController.text) ?? 0;
                              if (bid > auction.currentBid) {
                                setSheetState(() {
                                  auction.currentBid = bid;
                                  auction.bids++;
                                });
                                setState(() {});
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Lance de R\$ ${_formatPrice(bid)} registrado! 🏆',
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 13)),
                                  backgroundColor: const Color(0xFF4CAF7A),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD4622A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            child: Text(
                              'CONFIRMAR LANCE',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 18,
                                  letterSpacing: 2,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── FAVORITOS ──
  // ── CARRINHO ──
  void _openCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.92,
          expand: false,
          builder: (context, scrollController) => Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: const Color(0xFF3A3428),
                    borderRadius: BorderRadius.circular(2)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined,
                        color: Color(0xFFD4622A), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'CARRINHO',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2),
                    ),
                    const SizedBox(width: 8),
                    if (_cart.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: const Color(0xFFD4622A),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          '${_cart.length}',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(color: Color(0xFF2E2A22)),
              Expanded(
                child: _cart.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🛒', style: TextStyle(fontSize: 48)),
                            const SizedBox(height: 12),
                            Text(
                              'CARRINHO VAZIO',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: const Color(0xFF4A4438),
                                  letterSpacing: 2),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Adicione itens da venda direta',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 12, color: const Color(0xFF4A4438)),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _cart.length,
                        itemBuilder: (context, index) {
                          final cartItem = _cart[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF242018),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFF3A3428)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF1A1814),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(cartItem.emoji,
                                          style:
                                              const TextStyle(fontSize: 24))),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem.name,
                                        style: GoogleFonts.familjenGrotesk(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFF0ECE4)),
                                      ),
                                      Text(
                                        '@${cartItem.seller}',
                                        style: GoogleFonts.familjenGrotesk(
                                            fontSize: 11,
                                            color: const Color(0xFF7A7060)),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'R\$ ${cartItem.price.toInt()}',
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 16,
                                      color: const Color(0xFFD4A020),
                                      letterSpacing: 1),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    setState(() => _cart.removeAt(index));
                                    setSheetState(() {});
                                  },
                                  child: const Icon(Icons.close_rounded,
                                      color: Color(0xFF7A7060), size: 18),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              if (_cart.isNotEmpty) ...[
                const Divider(color: Color(0xFF2E2A22)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_cart.length} ${_cart.length == 1 ? 'item' : 'itens'}',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 13, color: const Color(0xFF7A7060)),
                          ),
                          Text(
                            'R\$ ${_cart.fold<double>(0, (s, i) => s + i.price).toInt()}',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 22,
                                color: const Color(0xFFD4A020),
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // ✅ Botão Finalizar Compra
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _openCheckout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4622A),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag_outlined,
                                  color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'FINALIZAR COMPRA',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 18,
                                    letterSpacing: 2,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ── CHECKOUT — RESUMO + PAGAMENTO ──
  void _openCheckout() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F0E0B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  color: const Color(0xFF3A3428),
                  borderRadius: BorderRadius.circular(2)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF2E2A22)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFFF0ECE4), size: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'RESUMO DO PEDIDO',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                        color: const Color(0xFFF0ECE4),
                        letterSpacing: 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFF2E2A22)),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'ITENS',
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        color: const Color(0xFF7A7060),
                        letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 10),
                  ..._cart.map((cartItem) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
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
                                  color: const Color(0xFF242018),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(cartItem.emoji,
                                      style: const TextStyle(fontSize: 22))),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.name,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFF0ECE4)),
                                  ),
                                  Text(
                                    '@${cartItem.seller}',
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 11,
                                        color: const Color(0xFF7A7060)),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'R\$ ${cartItem.price.toInt()}',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: const Color(0xFFD4A020),
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  // ── RESUMO FINANCEIRO ──
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1814),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFF2E2A22)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal (${_cart.length} ${_cart.length == 1 ? 'item' : 'itens'})',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 13, color: const Color(0xFF7A7060)),
                            ),
                            Text(
                              'R\$ ${_cart.fold<double>(0, (s, i) => s + i.price).toInt()}',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 13,
                                  color: const Color(0xFFF0ECE4),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: Color(0xFF2E2A22)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TOTAL',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 18,
                                  color: const Color(0xFFF0ECE4),
                                  letterSpacing: 1),
                            ),
                            Text(
                              'R\$ ${_cart.fold<double>(0, (s, i) => s + i.price).toInt()}',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 22,
                                  color: const Color(0xFFD4A020),
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4A020).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xFFD4A020).withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded,
                            color: Color(0xFFD4A020), size: 14),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Após confirmar, o vendedor tem 24h para aceitar e você 24h para pagar.',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 12,
                                color: const Color(0xFFD4A020),
                                height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // ✅ Botão FAZER PAGAMENTO
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() => _cart.clear());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Pedido confirmado! Aguarde o vendedor aceitar. 🎉',
                            style: GoogleFonts.familjenGrotesk(fontSize: 13),
                          ),
                          backgroundColor: const Color(0xFF4CAF7A),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          duration: const Duration(seconds: 3),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4622A),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.payment_rounded,
                              color: Colors.white, size: 22),
                          const SizedBox(width: 10),
                          Text(
                            'FAZER PAGAMENTO',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                letterSpacing: 2,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── FAVORITOS COM ABAS ──
  void _openFavorites() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DefaultTabController(
        length: 4,
        child: DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.92,
          expand: false,
          builder: (context, scrollController) => Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: const Color(0xFF3A3428),
                    borderRadius: BorderRadius.circular(2)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.favorite_rounded,
                        color: Color(0xFFD4622A), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'FAVORITOS',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2),
                    ),
                    const SizedBox(width: 8),
                    if (_favorites.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: const Color(0xFFD4622A),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          '${_favorites.length}',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // ✅ Abas de favoritos
              TabBar(
                indicatorColor: const Color(0xFFD4622A),
                indicatorWeight: 2,
                labelColor: const Color(0xFFD4622A),
                unselectedLabelColor: const Color(0xFF7A7060),
                labelStyle:
                    GoogleFonts.bebasNeue(fontSize: 12, letterSpacing: 1),
                unselectedLabelStyle:
                    GoogleFonts.bebasNeue(fontSize: 12, letterSpacing: 1),
                tabs: const [
                  Tab(text: 'TODOS'),
                  Tab(text: 'VENDA'),
                  Tab(text: 'ÁLBUNS'),
                  Tab(text: 'LEILÕES'),
                ],
              ),
              const Divider(color: Color(0xFF2E2A22), height: 1),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildFavoritesTab(null, scrollController),
                    _buildFavoritesTab('item', scrollController),
                    _buildFavoritesTab('album', scrollController),
                    _buildFavoritesTab('auction', scrollController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesTab(String? type, ScrollController scrollController) {
    final filtered = type == null
        ? _favorites
        : _favorites.where((f) => f.type == type).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('❤️', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(
              'NENHUM FAVORITO',
              style: GoogleFonts.bebasNeue(
                  fontSize: 16,
                  color: const Color(0xFF4A4438),
                  letterSpacing: 2),
            ),
            const SizedBox(height: 6),
            Text(
              'Toque em ♡ nos itens para favoritar',
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 12, color: const Color(0xFF4A4438)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final fav = filtered[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF242018),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF3A3428)),
          ),
          child: Row(
            children: [
              Text(fav.emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fav.name,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF0ECE4)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '@${fav.seller}',
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11, color: const Color(0xFF7A7060)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: const Color(0xFFD4622A).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  fav.type == 'album'
                      ? '📦 ÁLBUM'
                      : fav.type == 'auction'
                          ? '🔨 LEILÃO'
                          : '🏷️ VENDA',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 8, color: const Color(0xFFD4622A)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
    }
    return price.toString();
  }

  String _formatDeadline(DateTime deadline) {
    final diff = deadline.difference(DateTime.now());
    if (diff.inHours > 0) return '${diff.inHours}h ${diff.inMinutes % 60}min';
    return '${diff.inMinutes}min';
  }
}

// ══════════════════════════════════════
// CARD — VENDA DIRETA
// ══════════════════════════════════════
class _DirectItemCard extends StatelessWidget {
  final _MarketItem item;
  final VoidCallback onBuy;
  final VoidCallback onFavorite;
  final VoidCallback onMessage;

  const _DirectItemCard({
    required this.item,
    required this.onBuy,
    required this.onFavorite,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: item.isSold
                ? const Color(0xFF3A3428)
                : const Color(0xFF2E2A22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF242018),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Center(
                    child:
                        Text(item.emoji, style: const TextStyle(fontSize: 72))),
              ),
              if (item.isSold)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD44A4A),
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Text(
                          'VENDIDO',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 22,
                              letterSpacing: 3,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onFavorite,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle),
                    child: Icon(
                      item.isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: item.isFavorited
                          ? const Color(0xFFD4622A)
                          : Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    item.condition,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 9, color: Colors.white, letterSpacing: 0.5),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 18,
                      letterSpacing: 1,
                      color: const Color(0xFFF0ECE4)),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(item.sellerEmoji,
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      '@${item.seller}',
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11, color: const Color(0xFF7A7060)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 12,
                      color: const Color(0xFFB0A898),
                      height: 1.5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.originalPrice != null)
                          Text(
                            'R\$ ${item.originalPrice!.toInt()}',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 11,
                                color: const Color(0xFF4A4438),
                                decoration: TextDecoration.lineThrough),
                          ),
                        Text(
                          'R\$ ${item.price.toInt()}',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 24,
                              color: const Color(0xFFD4A020),
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (!item.isSold) ...[
                      GestureDetector(
                        onTap: onMessage,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 11),
                          decoration: BoxDecoration(
                            color: const Color(0xFF242018),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF3A3428)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.chat_bubble_outline_rounded,
                                  color: Color(0xFFF0ECE4), size: 15),
                              const SizedBox(width: 6),
                              Text(
                                'MENSAGEM',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 13,
                                    letterSpacing: 1,
                                    color: const Color(0xFFF0ECE4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onBuy,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 11),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4622A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'COMPRAR',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 16,
                                letterSpacing: 1.5,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ] else
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 11),
                        decoration: BoxDecoration(
                            color: const Color(0xFF2E2A22),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'INDISPONÍVEL',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 14,
                              letterSpacing: 1,
                              color: const Color(0xFF4A4438)),
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
// CARD — ÁLBUM
// ══════════════════════════════════════
class _AlbumCard extends StatefulWidget {
  final _Album album;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  const _AlbumCard(
      {required this.album, required this.onFavorite, required this.onTap});

  @override
  State<_AlbumCard> createState() => _AlbumCardState();
}

class _AlbumCardState extends State<_AlbumCard> {
  int _previewIndex = 0;

  String _formatDeadline(DateTime deadline) {
    final diff = deadline.difference(DateTime.now());
    if (diff.inHours > 0) return '${diff.inHours}h ${diff.inMinutes % 60}min';
    return '${diff.inMinutes}min';
  }

  @override
  Widget build(BuildContext context) {
    final allSold = widget.album.items.every((i) => i.isSold);
    final soldCount = widget.album.items.where((i) => i.isSold).length;
    final currentItem = widget.album.items[_previewIndex];

    return GestureDetector(
      onTap: widget.onTap,
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
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF242018),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  child: Center(
                    child: Opacity(
                      opacity: currentItem.isSold ? 0.3 : 1.0,
                      child: Text(currentItem.emoji,
                          style: const TextStyle(fontSize: 90)),
                    ),
                  ),
                ),
                if (currentItem.isSold)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD44A4A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'RESERVADO',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 18,
                                letterSpacing: 2,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (_previewIndex > 0)
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => setState(() => _previewIndex--),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_left_rounded,
                              color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ),
                if (_previewIndex < widget.album.items.length - 1)
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => setState(() => _previewIndex++),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_right_rounded,
                              color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        widget.album.items.length,
                        (i) => Container(
                              width: i == _previewIndex ? 16 : 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: i == _previewIndex
                                    ? const Color(0xFFD4622A)
                                    : Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            )),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      currentItem.name,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: widget.onFavorite,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle),
                      child: Icon(
                        widget.album.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.album.isFavorited
                            ? const Color(0xFFD4622A)
                            : Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.album.title,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 16,
                        letterSpacing: 1,
                        color: const Color(0xFFF0ECE4)),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(widget.album.sellerEmoji,
                          style: const TextStyle(fontSize: 11)),
                      const SizedBox(width: 4),
                      Text(
                        '@${widget.album.seller}',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 11, color: const Color(0xFF7A7060)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.album.description,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12,
                        color: const Color(0xFF7A7060),
                        height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4622A).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: const Color(0xFFD4622A).withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.timer_outlined,
                                color: Color(0xFFD4622A), size: 12),
                            const SizedBox(width: 4),
                            Text(
                              _formatDeadline(widget.album.deadline),
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10, color: const Color(0xFFD4622A)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: const Color(0xFF2E2A22),
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          '${widget.album.items.length} itens',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 10, color: const Color(0xFF7A7060)),
                        ),
                      ),
                      if (soldCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD44A4A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$soldCount reservado${soldCount > 1 ? 's' : ''}',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 10, color: const Color(0xFFD44A4A)),
                          ),
                        ),
                      ],
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: allSold
                              ? const Color(0xFF4CAF7A).withOpacity(0.12)
                              : const Color(0xFFD4622A),
                          borderRadius: BorderRadius.circular(8),
                          border: allSold
                              ? Border.all(color: const Color(0xFF4CAF7A))
                              : null,
                        ),
                        child: Text(
                          allSold ? '✦ COMPLETO' : 'VER ÁLBUM',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 13,
                              letterSpacing: 1.5,
                              color: allSold
                                  ? const Color(0xFF4CAF7A)
                                  : Colors.white),
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
}

// ══════════════════════════════════════
// CARD — LEILÃO
// ══════════════════════════════════════
class _AuctionCard extends StatelessWidget {
  final _Auction auction;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  const _AuctionCard(
      {required this.auction, required this.onFavorite, required this.onTap});

  String _formatPrice(int price) {
    return 'R\$ ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  String _formatDeadline(DateTime deadline) {
    final diff = deadline.difference(DateTime.now());
    if (diff.inHours > 0) return '${diff.inHours}h ${diff.inMinutes % 60}min';
    return '${diff.inMinutes}min';
  }

  @override
  Widget build(BuildContext context) {
    final isUrgent = auction.deadline.difference(DateTime.now()).inHours < 1;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: auction.isSold
                ? const Color(0xFF3A3428)
                : isUrgent
                    ? const Color(0xFFD4622A).withOpacity(0.5)
                    : const Color(0xFF2E2A22),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF242018),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(auction.emoji,
                            style: const TextStyle(fontSize: 28))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auction.name,
                          style: GoogleFonts.bebasNeue(
                              fontSize: 16,
                              letterSpacing: 1,
                              color: const Color(0xFFF0ECE4)),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Text(auction.sellerEmoji,
                                style: const TextStyle(fontSize: 11)),
                            const SizedBox(width: 4),
                            Text(
                              '@${auction.seller}',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 11, color: const Color(0xFF7A7060)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onFavorite,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        auction.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: auction.isFavorited
                            ? const Color(0xFFD4622A)
                            : const Color(0xFF7A7060),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Text(
                auction.description,
                style: GoogleFonts.familjenGrotesk(
                    fontSize: 12, color: const Color(0xFF7A7060), height: 1.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isUrgent
                          ? const Color(0xFFD4622A)
                          : const Color(0xFF2E2A22),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                            isUrgent
                                ? Icons.local_fire_department_rounded
                                : Icons.timer_outlined,
                            color: isUrgent
                                ? Colors.white
                                : const Color(0xFF7A7060),
                            size: 12),
                        const SizedBox(width: 4),
                        Text(
                          auction.isSold
                              ? 'ENCERRADO'
                              : _formatDeadline(auction.deadline),
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              color: isUrgent
                                  ? Colors.white
                                  : const Color(0xFF7A7060)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${auction.bids} lances',
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 10, color: const Color(0xFF7A7060)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lance atual',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9,
                            color: const Color(0xFF7A7060),
                            letterSpacing: 1),
                      ),
                      Text(
                        _formatPrice(auction.currentBid),
                        style: GoogleFonts.bebasNeue(
                            fontSize: 22,
                            color: const Color(0xFFD4A020),
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (auction.isSold)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF7A).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF4CAF7A)),
                      ),
                      child: Text(
                        'ARREMATADO 🏆',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 13,
                            letterSpacing: 1,
                            color: const Color(0xFF4CAF7A)),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 11),
                      decoration: BoxDecoration(
                          color: const Color(0xFFD4622A),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'DAR LANCE',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 15,
                            letterSpacing: 1.5,
                            color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── BID STAT ──
class _BidStat extends StatelessWidget {
  final String label;
  final String value;
  const _BidStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.bebasNeue(
              fontSize: 16, color: const Color(0xFFF0ECE4), letterSpacing: 1),
        ),
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
              fontSize: 9, color: const Color(0xFF7A7060), letterSpacing: 1),
        ),
      ],
    );
  }
}

// ── BOTTOM NAV ──
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1814),
        border: Border(top: BorderSide(color: Color(0xFF2E2A22))),
      ),
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
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 26),
                  ),
                ],
              ),
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
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? const Color(0xFFD4622A) : const Color(0xFF7A7060),
              size: 22,
            ),
            if (label.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 8,
                  color: active
                      ? const Color(0xFFD4622A)
                      : const Color(0xFF7A7060),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── MODELOS ──
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

  _MarketItem({
    required this.id,
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
    required this.isFavorited,
  });
}

class _Album {
  final String id, title, seller, sellerEmoji, description;
  final DateTime deadline;
  bool isSold, isFavorited;
  final List<_MarketItem> items;

  _Album({
    required this.id,
    required this.title,
    required this.seller,
    required this.sellerEmoji,
    required this.description,
    required this.deadline,
    required this.isSold,
    required this.isFavorited,
    required this.items,
  });
}

class _Auction {
  final String id,
      name,
      seller,
      sellerEmoji,
      emoji,
      category,
      condition,
      description;
  final int startPrice;
  int currentBid, bids;
  final DateTime deadline;
  bool isSold, isFavorited;

  _Auction({
    required this.id,
    required this.name,
    required this.seller,
    required this.sellerEmoji,
    required this.emoji,
    required this.category,
    required this.condition,
    required this.description,
    required this.startPrice,
    required this.currentBid,
    required this.bids,
    required this.deadline,
    required this.isSold,
    required this.isFavorited,
  });
}

class _FavoriteItem {
  final String id, name, emoji, type, seller;
  const _FavoriteItem({
    required this.id,
    required this.name,
    required this.emoji,
    required this.type,
    required this.seller,
  });
}

// ✅ Modelo do Carrinho
class _CartItem {
  final String id, name, emoji, seller;
  final double price;
  const _CartItem({
    required this.id,
    required this.name,
    required this.emoji,
    required this.seller,
    required this.price,
  });
}
