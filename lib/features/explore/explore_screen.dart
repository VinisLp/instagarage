import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/main_layout.dart';

// ── Cores globais ──
const _bg = Color(0xFF0F0E0B);
const _card = Color(0xFF1A1814);
const _card2 = Color(0xFF242018);
const _border = Color(0xFF2E2A22);
const _border2 = Color(0xFF3A3428);
const _primary = Color(0xFFD4622A);
const _gold = Color(0xFFD4A020);
const _text = Color(0xFFF0ECE4);
const _muted = Color(0xFF7A7060);
const _muted2 = Color(0xFF4A4438);
const _green = Color(0xFF4CAF7A);
const _blue = Color(0xFF4A8FD4);

// ── Helper: dialog centralizado ──
void _showCenteredDialog(BuildContext context, Widget child) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.75),
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 680),
        child: ClipRRect(borderRadius: BorderRadius.circular(20), child: child),
      ),
    ),
  );
}

// ── Helper: barra filtro + busca padronizada ──
Widget _FilterBar({
  required BuildContext context,
  required String filterLabel,
  required bool filterActive,
  required VoidCallback onFilterTap,
  required TextEditingController searchCtrl,
  required VoidCallback onSearchChanged,
  VoidCallback? onClearFilter,
  Widget? extraRight,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // Botão filtro
      GestureDetector(
        onTap: onFilterTap,
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: filterActive ? _primary.withOpacity(0.12) : _card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: filterActive ? _primary : _border),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.filter_list_rounded,
                size: 14, color: filterActive ? _primary : _muted),
            const SizedBox(width: 6),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 90),
                child: Text(filterLabel,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: filterActive ? _primary : _muted),
                    overflow: TextOverflow.ellipsis)),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 15, color: filterActive ? _primary : _muted),
          ]),
        ),
      ),
      if (filterActive && onClearFilter != null) ...[
        const SizedBox(width: 6),
        GestureDetector(
            onTap: onClearFilter,
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: _card,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _border)),
                child:
                    const Icon(Icons.close_rounded, color: _muted, size: 13))),
      ],
      const SizedBox(width: 8),
      // Busca
      Expanded(
          child: Container(
        height: 38,
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _border)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.search_rounded, color: _muted, size: 16)),
          Expanded(
              child: TextField(
            controller: searchCtrl,
            onChanged: (_) => onSearchChanged(),
            style: GoogleFonts.familjenGrotesk(color: _text, fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Buscar...',
              hintStyle:
                  GoogleFonts.familjenGrotesk(color: _muted2, fontSize: 12),
              border: InputBorder.none,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
            ),
          )),
        ]),
      )),
      if (extraRight != null) ...[const SizedBox(width: 8), extraRight],
    ]),
  );
}

// ════════════════════════════════════════
// TELA PRINCIPAL
// ════════════════════════════════════════
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return MainLayout(
      currentIndex: NavIndex.explore,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text('EXPLORAR',
              style: GoogleFonts.bebasNeue(
                  fontSize: isDesktop ? 28 : 24,
                  color: _text,
                  letterSpacing: 3)),
        ),
        TabBar(
          controller: _tabController,
          indicatorColor: _primary,
          indicatorWeight: 2,
          dividerColor: Colors.transparent,
          labelColor: _primary,
          unselectedLabelColor: _muted,
          labelStyle: GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5),
          unselectedLabelStyle:
              GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5),
          tabs: const [
            Tab(text: 'ITENS'),
            Tab(text: 'EVENTOS'),
            Tab(text: 'COMUNIDADES'),
            Tab(text: 'PERFIS')
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
            child: TabBarView(controller: _tabController, children: [
          _ItemsTab(isDesktop: isDesktop),
          _EventsTab(isDesktop: isDesktop),
          _CommunitiesTab(isDesktop: isDesktop),
          _ProfilesTab(isDesktop: isDesktop),
        ])),
      ]),
    );
  }
}

// ════════════════════════════════════════
// ABA ITENS — feed de posts quadrado
// ════════════════════════════════════════
class _ItemsTab extends StatefulWidget {
  final bool isDesktop;
  const _ItemsTab({required this.isDesktop});
  @override
  State<_ItemsTab> createState() => _ItemsTabState();
}

class _ItemsTabState extends State<_ItemsTab> {
  String _cat = 'Todos';
  final _searchCtrl = TextEditingController();

  static const _allCats = [
    'Todos',
    'Cards TCG',
    'Action Figures',
    'Vinils & CDs',
    'Quadrinhos & HQs',
    'Miniaturas',
    'Selos & Moedas',
    'Camisas & Futebol',
    'Funko Pop',
    'Lego',
    'Brinquedos Antigos',
    'Jogos & Consoles',
    'Livros Raros',
    'Tênis & Sneakers',
    'Arte & Pinturas',
    'Outros'
  ];

  final List<_Post> _posts = [
    _Post(
        emoji: '🐲',
        user: 'pokemon_rafael',
        uEmoji: '🏎️',
        name: 'Charizard Holo Base Set',
        caption: 'Finalmente consegui o meu! Near Mint 🔥',
        cat: 'Cards TCG',
        likes: 284,
        isVideo: false,
        cond: 'Near Mint'),
    _Post(
        emoji: '🎸',
        user: 'vinyl_br',
        uEmoji: '🎸',
        name: 'Led Zeppelin IV - 1971',
        caption: 'Prensagem original UK 🎵',
        cat: 'Vinils & CDs',
        likes: 156,
        isVideo: true,
        cond: 'Good'),
    _Post(
        emoji: '🦸',
        user: 'hq_collector',
        uEmoji: '🦸',
        name: 'Spider-Man #1',
        caption: 'Marvel 1990 🕷️',
        cat: 'Quadrinhos & HQs',
        likes: 98,
        isVideo: false,
        cond: 'Very Fine'),
    _Post(
        emoji: '🚀',
        user: 'trains_sp',
        uEmoji: '🚂',
        name: 'Hot Wheels Redline 1968',
        caption: 'Raridade dos anos 60! ✨',
        cat: 'Miniaturas',
        likes: 201,
        isVideo: false,
        cond: 'Good'),
    _Post(
        emoji: '⚡',
        user: 'pokemon_rafael',
        uEmoji: '🏎️',
        name: 'Pikachu Promo 1998',
        caption: 'Menos de 500 no mundo 😱',
        cat: 'Cards TCG',
        likes: 892,
        isVideo: true,
        cond: 'Mint'),
    _Post(
        emoji: '👕',
        user: 'shirts_br',
        uEmoji: '👕',
        name: 'Camisa Brasil 1970',
        caption: 'Com certificado CBF 🇧🇷',
        cat: 'Camisas & Futebol',
        likes: 445,
        isVideo: false,
        cond: 'Good'),
    _Post(
        emoji: '🎴',
        user: 'magic_sp',
        uEmoji: '🎴',
        name: 'Black Lotus Alpha 1993',
        caption: 'PSA 8.5 💎',
        cat: 'Cards TCG',
        likes: 1203,
        isVideo: true,
        cond: 'Near Mint'),
    _Post(
        emoji: '🏎️',
        user: 'cars_col',
        uEmoji: '🚗',
        name: 'Ferrari 250 GTO Burago',
        caption: 'Lacrada 1:18 🏎️',
        cat: 'Miniaturas',
        likes: 167,
        isVideo: false,
        cond: 'Perfeito'),
  ];

  List<_Post> get _filtered => _posts.where((p) {
        final matchCat = _cat == 'Todos' || p.cat == _cat;
        final q = _searchCtrl.text.toLowerCase();
        return matchCat &&
            (q.isEmpty ||
                p.name.toLowerCase().contains(q) ||
                p.user.toLowerCase().contains(q));
      }).toList();

  void _pickCat() {
    showModalBottomSheet(
        context: context,
        backgroundColor: _card,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            expand: false,
            builder: (ctx, sc) => Column(children: [
                  Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: _border2,
                          borderRadius: BorderRadius.circular(2))),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        Text('CATEGORIA',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20, color: _text, letterSpacing: 2)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Navigator.pop(ctx),
                            child: const Icon(Icons.close_rounded,
                                color: _muted, size: 22)),
                      ])),
                  const SizedBox(height: 8),
                  const Divider(color: _border),
                  Expanded(
                      child: ListView.builder(
                          controller: sc,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          itemCount: _allCats.length,
                          itemBuilder: (ctx2, i) {
                            final cat = _allCats[i];
                            final sel = _cat == cat;
                            return GestureDetector(
                                onTap: () {
                                  setState(() => _cat = cat);
                                  Navigator.pop(ctx);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    decoration: BoxDecoration(
                                        color: sel
                                            ? _primary.withOpacity(0.12)
                                            : _card2,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: sel ? _primary : _border)),
                                    child: Row(children: [
                                      Text(cat,
                                          style: GoogleFonts.familjenGrotesk(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: sel ? _primary : _text)),
                                      const Spacer(),
                                      if (sel)
                                        const Icon(Icons.check_circle_rounded,
                                            color: _primary, size: 18)
                                    ])));
                          })),
                ])));
  }

  @override
  Widget build(BuildContext context) {
    final posts = _filtered;
    // Grid quadrado 1:1 — igual Instagram
    final crossCount = widget.isDesktop ? 5 : 3;
    return Column(children: [
      _FilterBar(
          context: context,
          filterLabel: _cat,
          filterActive: _cat != 'Todos',
          onFilterTap: _pickCat,
          searchCtrl: _searchCtrl,
          onSearchChanged: () => setState(() {}),
          onClearFilter: () => setState(() => _cat = 'Todos')),
      Expanded(
          child: posts.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text('🔍', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 12),
                      Text('NENHUM POST ENCONTRADO',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 16, color: _muted2, letterSpacing: 2))
                    ]))
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      childAspectRatio: 1.0),
                  itemCount: posts.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                      onTap: () =>
                          _showCenteredDialog(ctx, _PostDialog(post: posts[i])),
                      child: _PostTile(post: posts[i])))),
    ]);
  }
}

// Tile quadrado 1:1
class _PostTile extends StatelessWidget {
  final _Post post;
  const _PostTile({required this.post});
  @override
  Widget build(BuildContext context) => Stack(children: [
        Container(
            color: _card2,
            child: Center(
                child: Text(post.emoji,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width >= 900
                            ? 44
                            : 32)))),
        if (post.isVideo)
          Positioned(
              top: 5,
              right: 5,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.play_circle_filled_rounded,
                        color: _primary, size: 10),
                    const SizedBox(width: 2),
                    Text('VID',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 7, color: Colors.white))
                  ]))),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 14, 6, 5),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black.withOpacity(0.85),
                    Colors.transparent
                  ])),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.name,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Row(children: [
                      Text('@${post.user}',
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 8, color: Colors.white60)),
                      const Spacer(),
                      const Icon(Icons.favorite,
                          color: Colors.white70, size: 9),
                      const SizedBox(width: 2),
                      Text('${post.likes}',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 7, color: Colors.white60))
                    ]),
                  ]),
            )),
      ]);
}

// Dialog do post
class _PostDialog extends StatefulWidget {
  final _Post post;
  const _PostDialog({required this.post});
  @override
  State<_PostDialog> createState() => _PostDialogState();
}

class _PostDialogState extends State<_PostDialog> {
  bool _liked = false;
  final _ctrl = TextEditingController();
  final List<String> _comments = [
    'Incrível peça! Onde conseguiu?',
    'Que raridade! 🔥'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: _card,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Header
          Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
              child: Row(children: [
                Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _card2,
                        border: Border.all(color: _primary, width: 1.5)),
                    child: Center(
                        child: Text(widget.post.uEmoji,
                            style: const TextStyle(fontSize: 16)))),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(widget.post.user,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _text)),
                      Text(widget.post.cat,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 9, color: _muted)),
                    ])),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                        color: _card2, borderRadius: BorderRadius.circular(5)),
                    child: Text(widget.post.cond,
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 7, color: _muted))),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close_rounded,
                        color: _muted, size: 18)),
              ])),
          const SizedBox(height: 10),
          // Mídia — altura fixa para não estourar o dialog
          SizedBox(
              height: 200,
              child: Stack(children: [
                Container(
                    width: double.infinity,
                    color: _card2,
                    child: Center(
                        child: Text(widget.post.emoji,
                            style: const TextStyle(fontSize: 80)))),
                if (widget.post.isVideo)
                  Positioned.fill(
                      child: Center(
                          child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.play_arrow_rounded,
                                  color: Colors.white, size: 30)))),
                if (widget.post.isVideo)
                  Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            const Icon(Icons.videocam_rounded,
                                color: _primary, size: 11),
                            const SizedBox(width: 3),
                            Text('VÍDEO',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 8, color: Colors.white))
                          ]))),
              ])),
          // Ações
          Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
              child: Row(children: [
                GestureDetector(
                    onTap: () => setState(() => _liked = !_liked),
                    child: Icon(_liked ? Icons.favorite : Icons.favorite_border,
                        color: _liked ? _primary : _muted, size: 22)),
                const SizedBox(width: 5),
                Text('${widget.post.likes + (_liked ? 1 : 0)}',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12, color: _muted)),
                const SizedBox(width: 14),
                const Icon(Icons.chat_bubble_outline_rounded,
                    color: _muted, size: 20),
                const SizedBox(width: 5),
                Text('${_comments.length}',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12, color: _muted)),
                const SizedBox(width: 14),
                const Icon(Icons.share_outlined, color: _muted, size: 20),
              ])),
          // Legenda com espaço abaixo
          Padding(
              padding: const EdgeInsets.fromLTRB(14, 2, 14, 14),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${widget.post.user} ',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _text)),
                TextSpan(
                    text: widget.post.caption,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12, color: const Color(0xFFB0A898))),
              ]))),
          const Divider(color: _border, height: 1),
          // Comentários
          SizedBox(
              height: 110,
              child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
                  itemCount: _comments.length,
                  itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: _card2),
                                child: const Center(
                                    child: Text('👤',
                                        style: TextStyle(fontSize: 12)))),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: _card2,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(_comments[i],
                                        style: GoogleFonts.familjenGrotesk(
                                            fontSize: 12, color: _text)))),
                          ])))),
          const Divider(color: _border, height: 1),
          // Input comentário
          Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: _ctrl,
                  onChanged: (_) => setState(() {}),
                  style:
                      GoogleFonts.familjenGrotesk(color: _text, fontSize: 12),
                  decoration: InputDecoration(
                      hintText: 'Adicionar comentário...',
                      hintStyle: GoogleFonts.familjenGrotesk(
                          color: _muted2, fontSize: 12),
                      filled: true,
                      fillColor: _card2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: _border)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: _border)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: _primary)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      isDense: true),
                )),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {
                      if (_ctrl.text.trim().isNotEmpty) {
                        setState(() {
                          _comments.add(_ctrl.text.trim());
                          _ctrl.clear();
                        });
                      }
                    },
                    child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                            color: _ctrl.text.trim().isNotEmpty
                                ? _primary
                                : _card2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(Icons.send_rounded,
                            color: _ctrl.text.trim().isNotEmpty
                                ? Colors.white
                                : _muted2,
                            size: 15))),
              ])),
        ]));
  }
}

// ════════════════════════════════════════
// ABA EVENTOS
// ════════════════════════════════════════
class _EventsTab extends StatefulWidget {
  final bool isDesktop;
  const _EventsTab({required this.isDesktop});
  @override
  State<_EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<_EventsTab> {
  String _type = 'Todos';
  final _searchCtrl = TextEditingController();
  static const _types = [
    'Todos',
    'Presencial',
    'Online',
    'Feira',
    'Live',
    'Swap Meet'
  ];

  static final _events = [
    _Event(
        emoji: '🎴',
        title: 'Feira de Cards SP 2025',
        organizer: 'Garage TCG',
        oEmoji: '🏎️',
        date: '15 Mai 2025',
        time: '09:00 - 18:00',
        location: 'São Paulo · Expo Center Norte',
        address: 'Av. Otto Baumgart, 1000 - Santana, SP',
        attendees: 342,
        type: 'Presencial',
        desc:
            'Maior feira de cards colecionáveis do Brasil. Pokémon, Magic, Yu-Gi-Oh. Entrada gratuita.',
        cat: 'Cards TCG'),
    _Event(
        emoji: '🎸',
        title: 'Encontro de Vinil',
        organizer: 'Garagem do Vinil',
        oEmoji: '🎸',
        date: '22 Mai 2025',
        time: '14:00 - 20:00',
        location: 'Rio de Janeiro · Lapa',
        address: 'Rua do Lavradio, 180 - Lapa, RJ',
        attendees: 128,
        type: 'Presencial',
        desc:
            'Troca, venda e apreciação de discos raros. Rolagem ao vivo com DJ convidado.',
        cat: 'Vinils & CDs'),
    _Event(
        emoji: '🦸',
        title: 'Live: HQs Raras',
        organizer: 'HQ Garage',
        oEmoji: '🦸',
        date: '18 Mai 2025',
        time: '20:00 - 22:00',
        location: 'Online · YouTube Live',
        address: 'youtube.com/hq_garage',
        attendees: 891,
        type: 'Online',
        desc: 'Avaliação ao vivo de quadrinhos raros enviados pela comunidade.',
        cat: 'Quadrinhos & HQs'),
    _Event(
        emoji: '🏎️',
        title: 'Swap Meet: Miniaturas',
        organizer: 'Cars Collection',
        oEmoji: '🚗',
        date: '01 Jun 2025',
        time: '10:00 - 17:00',
        location: 'Curitiba · Shopping Mueller',
        address: 'Rua Comendador Araújo, 570 - Centro, Curitiba',
        attendees: 215,
        type: 'Presencial',
        desc: 'Evento de troca de miniaturas. Hot Wheels, Matchbox, Burago.',
        cat: 'Miniaturas'),
    _Event(
        emoji: '🐲',
        title: 'Pokémon Regional SP',
        organizer: 'Pokémon TCG BR',
        oEmoji: '🐲',
        date: '10 Jun 2025',
        time: '08:00 - 20:00',
        location: 'São Paulo · Arena Anhembi',
        address: 'Av. Olavo Fontoura, 1209 - Santana, SP',
        attendees: 1200,
        type: 'Presencial',
        desc: 'Torneio regional oficial Pokémon TCG. Premiação para top 8.',
        cat: 'Cards TCG'),
    _Event(
        emoji: '🎮',
        title: 'Live: Consoles Retrô',
        organizer: 'Retro Games BR',
        oEmoji: '🎮',
        date: '25 Mai 2025',
        time: '19:00 - 21:00',
        location: 'Online · Twitch',
        address: 'twitch.tv/retrogames_br',
        attendees: 432,
        type: 'Online',
        desc: 'Avaliação ao vivo de consoles e jogos retrô raros.',
        cat: 'Jogos & Consoles'),
  ];

  List<_Event> get _filtered => _events.where((e) {
        final matchType = _type == 'Todos' || e.type == _type;
        final q = _searchCtrl.text.toLowerCase();
        return matchType &&
            (q.isEmpty ||
                e.title.toLowerCase().contains(q) ||
                e.organizer.toLowerCase().contains(q));
      }).toList();

  void _pickType() {
    showModalBottomSheet(
        context: context,
        backgroundColor: _card,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.3,
            maxChildSize: 0.7,
            expand: false,
            builder: (ctx, sc) => Column(children: [
                  Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: _border2,
                          borderRadius: BorderRadius.circular(2))),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        Text('TIPO DE EVENTO',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20, color: _text, letterSpacing: 2)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Navigator.pop(ctx),
                            child: const Icon(Icons.close_rounded,
                                color: _muted, size: 22))
                      ])),
                  const SizedBox(height: 8),
                  const Divider(color: _border),
                  Expanded(
                      child: ListView.builder(
                          controller: sc,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          itemCount: _types.length,
                          itemBuilder: (ctx2, i) {
                            final t = _types[i];
                            final sel = _type == t;
                            return GestureDetector(
                                onTap: () {
                                  setState(() => _type = t);
                                  Navigator.pop(ctx);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                        color: sel
                                            ? _primary.withOpacity(0.12)
                                            : _card2,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: sel ? _primary : _border)),
                                    child: Row(children: [
                                      Text(t,
                                          style: GoogleFonts.familjenGrotesk(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: sel ? _primary : _text)),
                                      const Spacer(),
                                      if (sel)
                                        const Icon(Icons.check_circle_rounded,
                                            color: _primary, size: 18)
                                    ])));
                          })),
                ])));
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    final crossCount = widget.isDesktop ? 3 : 2;
    return Column(children: [
      _FilterBar(
          context: context,
          filterLabel: _type,
          filterActive: _type != 'Todos',
          onFilterTap: _pickType,
          searchCtrl: _searchCtrl,
          onSearchChanged: () => setState(() {}),
          onClearFilter: () => setState(() => _type = 'Todos')),
      Expanded(
          child: items.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text('📅', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 12),
                      Text('NENHUM EVENTO ENCONTRADO',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 16, color: _muted2, letterSpacing: 2))
                    ]))
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: widget.isDesktop ? 1.6 : 1.3),
                  itemCount: items.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                      onTap: () => Navigator.of(ctx).push(MaterialPageRoute(
                          builder: (_) => _EventPage(event: items[i]))),
                      child: _EventCard(event: items[i])))),
    ]);
  }
}

class _EventCard extends StatelessWidget {
  final _Event event;
  const _EventCard({required this.event});
  @override
  Widget build(BuildContext context) {
    final online = event.type == 'Online';
    final typeColor = online ? _blue : _green;
    return Container(
      decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          Container(
              height: 56,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: _card2,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(11))),
              child: Center(
                  child:
                      Text(event.emoji, style: const TextStyle(fontSize: 26)))),
          Positioned(
              top: 6,
              right: 6,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: typeColor)),
                  child: Text(event.type,
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 8, color: typeColor)))),
        ]),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title,
                          style: GoogleFonts.bebasNeue(
                              fontSize: 15, letterSpacing: 0.5, color: _text),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 5),
                      Row(children: [
                        const Icon(Icons.calendar_today_rounded,
                            color: _primary, size: 11),
                        const SizedBox(width: 4),
                        Text(event.date,
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 12, color: _text))
                      ]),
                      const SizedBox(height: 3),
                      Row(children: [
                        const Icon(Icons.location_on_rounded,
                            color: _muted, size: 11),
                        const SizedBox(width: 4),
                        Expanded(
                            child: Text(event.location,
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 11, color: _muted),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis))
                      ]),
                      const Spacer(),
                      Row(children: [
                        const Icon(Icons.people_rounded,
                            color: _muted, size: 12),
                        const SizedBox(width: 3),
                        Text('${event.attendees}',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 11, color: _muted)),
                        const Spacer(),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                color: _primary,
                                borderRadius: BorderRadius.circular(6)),
                            child: Text('VER',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 13,
                                    letterSpacing: 1,
                                    color: Colors.white)))
                      ]),
                    ]))),
      ]),
    );
  }
}

class _EventPage extends StatefulWidget {
  final _Event event;
  const _EventPage({required this.event});
  @override
  State<_EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<_EventPage> {
  bool _attending = false;
  final List<String> _attendees = [
    'pokemon_rafael 🏎️',
    'vinyl_br 🎸',
    'hq_collector 🦸',
    'magic_sp 🎴',
    'shirts_br 👕'
  ];

  void _showParticipants(BuildContext context) {
    final searchCtrl = TextEditingController();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: _card,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => StatefulBuilder(
            builder: (ctx, setSheet) => DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.4,
                  maxChildSize: 0.9,
                  expand: false,
                  builder: (ctx2, sc) {
                    final filtered = searchCtrl.text.isEmpty
                        ? _attendees
                        : _attendees
                            .where((a) => a
                                .toLowerCase()
                                .contains(searchCtrl.text.toLowerCase()))
                            .toList();
                    return Column(children: [
                      Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: _border2,
                              borderRadius: BorderRadius.circular(2))),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(children: [
                            Text('PARTICIPANTES',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: _text,
                                    letterSpacing: 2)),
                            const SizedBox(width: 8),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    color: _primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    '${widget.event.attendees + (_attending ? 1 : 0)}',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 10, color: Colors.white))),
                            const Spacer(),
                            GestureDetector(
                                onTap: () => Navigator.pop(ctx),
                                child: const Icon(Icons.close_rounded,
                                    color: _muted, size: 22)),
                          ])),
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                  color: _card2,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: _border)),
                              child: Row(children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(Icons.search_rounded,
                                        color: _muted, size: 16)),
                                Expanded(
                                    child: TextField(
                                        controller: searchCtrl,
                                        onChanged: (_) => setSheet(() {}),
                                        style: GoogleFonts.familjenGrotesk(
                                            color: _text, fontSize: 13),
                                        decoration: InputDecoration(
                                            hintText: 'Buscar participante...',
                                            hintStyle:
                                                GoogleFonts.familjenGrotesk(
                                                    color: _muted2,
                                                    fontSize: 13),
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 10),
                                            isDense: true)))
                              ]))),
                      const SizedBox(height: 8),
                      const Divider(color: _border),
                      Expanded(
                          child: ListView.builder(
                              controller: sc,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              itemCount: filtered.length,
                              itemBuilder: (_, i) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                      color: _card2,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: _border)),
                                  child: Text(filtered[i],
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 13, color: _text))))),
                    ]);
                  },
                )));
  }

  @override
  Widget build(BuildContext context) {
    final online = widget.event.type == 'Online';
    final typeColor = online ? _blue : _green;
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
          child: Column(children: [
        Stack(children: [
          Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF1a0800), Color(0xFF3a1800)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Center(
                  child: Text(widget.event.emoji,
                      style: const TextStyle(fontSize: 80)))),
          Positioned(
              top: 12,
              left: 12,
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: Colors.white, size: 20)))),
          Positioned(
              top: 12,
              right: 12,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: typeColor)),
                  child: Text(widget.event.type,
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 10, color: typeColor)))),
        ]),
        Expanded(child: LayoutBuilder(builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 700;
          // Sidebar esquerda com info + participantes, área direita scrollável com detalhes
          return isDesktop
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Sidebar esquerda — textos grandes + botões verticais
                  SizedBox(
                      width: 300,
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.event.title,
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 26,
                                        letterSpacing: 1.5,
                                        color: _text)),
                                const SizedBox(height: 6),
                                Row(children: [
                                  Text(widget.event.oEmoji,
                                      style: const TextStyle(fontSize: 15)),
                                  const SizedBox(width: 6),
                                  Text('por ${widget.event.organizer}',
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 14, color: _primary))
                                ]),
                                const SizedBox(height: 16),
                                _ICard(
                                    icon: Icons.calendar_today_rounded,
                                    label: 'DATA',
                                    value: widget.event.date,
                                    color: _primary),
                                const SizedBox(height: 8),
                                _ICard(
                                    icon: Icons.access_time_rounded,
                                    label: 'HORÁRIO',
                                    value: widget.event.time,
                                    color: _gold),
                                const SizedBox(height: 8),
                                _ICard(
                                    icon: Icons.location_on_rounded,
                                    label: 'LOCAL',
                                    value: widget.event.location,
                                    color: _green,
                                    subtitle: widget.event.address),
                                const SizedBox(height: 8),
                                _ICard(
                                    icon: Icons.category_rounded,
                                    label: 'CATEGORIA',
                                    value: widget.event.cat,
                                    color: _muted),
                                const SizedBox(height: 16),
                                Text('SOBRE',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 10,
                                        color: _muted,
                                        letterSpacing: 1.5)),
                                const SizedBox(height: 8),
                                Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                        color: _card,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: _border)),
                                    child: Text(widget.event.desc,
                                        style: GoogleFonts.familjenGrotesk(
                                            fontSize: 13,
                                            color: const Color(0xFFB0A898),
                                            height: 1.5))),
                                const SizedBox(height: 16),
                                // Botões verticais
                                SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () => setState(
                                          () => _attending = !_attending),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: _attending
                                              ? _green.withOpacity(0.12)
                                              : _primary,
                                          foregroundColor: _attending
                                              ? _green
                                              : Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: _attending
                                                  ? const BorderSide(
                                                      color: _green)
                                                  : BorderSide.none),
                                          elevation: 0),
                                      child: Text(
                                          _attending
                                              ? '✓ CONFIRMADO'
                                              : 'PARTICIPAR',
                                          style: GoogleFonts.bebasNeue(
                                              fontSize: 15, letterSpacing: 2)),
                                    )),
                                const SizedBox(height: 8),
                                SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Link copiado! 🔗',
                                                    style: GoogleFonts
                                                        .familjenGrotesk(
                                                            fontSize: 13)),
                                                backgroundColor: _green,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: _card,
                                          foregroundColor: _text,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                  color: _border2)),
                                          elevation: 0),
                                      child: Text('CONVIDAR',
                                          style: GoogleFonts.bebasNeue(
                                              fontSize: 15, letterSpacing: 2)),
                                    )),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => _showParticipants(context),
                                  child: Row(children: [
                                    Text('PARTICIPANTES',
                                        style: GoogleFonts.jetBrainsMono(
                                            fontSize: 10,
                                            color: _muted,
                                            letterSpacing: 1.5)),
                                    const SizedBox(width: 8),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: _primary,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                            '${widget.event.attendees + (_attending ? 1 : 0)}',
                                            style: GoogleFonts.jetBrainsMono(
                                                fontSize: 10,
                                                color: Colors.white))),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward_ios_rounded,
                                        color: _muted, size: 12),
                                  ]),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: _attendees
                                        .take(3)
                                        .map((a) => GestureDetector(
                                            onTap: () =>
                                                _showParticipants(context),
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                    color: _card,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: _border)),
                                                child: Text(a,
                                                    style: GoogleFonts
                                                        .familjenGrotesk(
                                                            fontSize: 12,
                                                            color: _text)))))
                                        .toList()),
                                if (_attendees.length > 3)
                                  GestureDetector(
                                      onTap: () => _showParticipants(context),
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text('Ver todos →',
                                              style:
                                                  GoogleFonts.familjenGrotesk(
                                                      fontSize: 13,
                                                      color: _primary,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          _primary)))),
                                const SizedBox(height: 20),
                              ]))),
                  const VerticalDivider(width: 1, color: _border),
                  Expanded(
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                        const Text('📸', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text('FOTOS DO EVENTO',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 16,
                                color: _muted2,
                                letterSpacing: 2)),
                        const SizedBox(height: 8),
                        Text('Em breve...',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 12, color: _muted2)),
                      ]))),
                ])
              // Mobile — scroll único
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.event.title,
                            style: GoogleFonts.bebasNeue(
                                fontSize: 22,
                                letterSpacing: 1.5,
                                color: _text)),
                        const SizedBox(height: 4),
                        Row(children: [
                          Text(widget.event.oEmoji,
                              style: const TextStyle(fontSize: 13)),
                          const SizedBox(width: 6),
                          Text('por ${widget.event.organizer}',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 12, color: _primary))
                        ]),
                        const SizedBox(height: 14),
                        Row(children: [
                          Expanded(
                              child: _ICard(
                                  icon: Icons.calendar_today_rounded,
                                  label: 'DATA',
                                  value: widget.event.date,
                                  color: _primary)),
                          const SizedBox(width: 8),
                          Expanded(
                              child: _ICard(
                                  icon: Icons.access_time_rounded,
                                  label: 'HORÁRIO',
                                  value: widget.event.time,
                                  color: _gold))
                        ]),
                        const SizedBox(height: 8),
                        _ICard(
                            icon: Icons.location_on_rounded,
                            label: 'LOCAL',
                            value: widget.event.location,
                            color: _green,
                            subtitle: widget.event.address),
                        const SizedBox(height: 8),
                        _ICard(
                            icon: Icons.category_rounded,
                            label: 'CATEGORIA',
                            value: widget.event.cat,
                            color: _muted),
                        const SizedBox(height: 14),
                        Text('SOBRE O EVENTO',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 9,
                                color: _muted,
                                letterSpacing: 1.5)),
                        const SizedBox(height: 8),
                        Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: _card,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: _border)),
                            child: Text(widget.event.desc,
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 12,
                                    color: const Color(0xFFB0A898),
                                    height: 1.5))),
                        const SizedBox(height: 14),
                        GestureDetector(
                            onTap: () => _showParticipants(context),
                            child: Row(children: [
                              Text('PARTICIPANTES',
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 9,
                                      color: _muted,
                                      letterSpacing: 1.5)),
                              const SizedBox(width: 8),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: _primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                      '${widget.event.attendees + (_attending ? 1 : 0)}',
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 9, color: Colors.white))),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  color: _muted, size: 12)
                            ])),
                        const SizedBox(height: 10),
                        Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _attendees
                                .map((a) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: _card,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: _border)),
                                    child: Text(a,
                                        style: GoogleFonts.familjenGrotesk(
                                            fontSize: 12, color: _text))))
                                .toList()),
                        const SizedBox(height: 32),
                      ]));
        })),
        // Botões mobile ficam na barra inferior
        Builder(builder: (ctx) {
          final isDesktop = MediaQuery.of(ctx).size.width >= 700;
          if (isDesktop) return const SizedBox.shrink();
          return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(children: [
                Expanded(
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () =>
                                setState(() => _attending = !_attending),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _attending
                                    ? _green.withOpacity(0.12)
                                    : _primary,
                                foregroundColor:
                                    _attending ? _green : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: _attending
                                        ? const BorderSide(color: _green)
                                        : BorderSide.none),
                                elevation: 0),
                            child: Text(
                                _attending ? '✓ CONFIRMADO' : 'PARTICIPAR',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 16, letterSpacing: 2))))),
                const SizedBox(width: 10),
                Expanded(
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _card,
                                foregroundColor: _text,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(color: _border2)),
                                elevation: 0),
                            child: Text('CONVIDAR',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 16, letterSpacing: 2))))),
              ]));
        }),
      ])),
    );
  }
}

class _ICard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  final String? subtitle;
  const _ICard(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color,
      this.subtitle});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _border)),
        child: Row(children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(label,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 8, color: _muted, letterSpacing: 1)),
                Text(value,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _text)),
                if (subtitle != null)
                  Text(subtitle!,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 10, color: _muted)),
              ]))
        ]),
      );
}

// ════════════════════════════════════════
// ABA COMUNIDADES
// ════════════════════════════════════════
class _CommunitiesTab extends StatefulWidget {
  final bool isDesktop;
  const _CommunitiesTab({required this.isDesktop});
  @override
  State<_CommunitiesTab> createState() => _CommunitiesTabState();
}

class _CommunitiesTabState extends State<_CommunitiesTab> {
  String _cat = 'Todas';
  final _searchCtrl = TextEditingController();
  static const _cats = [
    'Todas',
    'Cards TCG',
    'Vinils & CDs',
    'Quadrinhos',
    'Miniaturas',
    'Camisas',
    'Tênis',
    'Jogos & Consoles'
  ];

  static final _communities = [
    _Comm(
        emoji: '🐲',
        name: 'Pokémon TCG Brasil',
        members: 12400,
        posts: 342,
        cat: 'Cards TCG',
        desc:
            'A maior comunidade de Pokémon TCG do Brasil! Compartilhe coleções, trades e fique por dentro das novidades.',
        tags: ['Pokémon', 'Cards', 'TCG', 'Trade']),
    _Comm(
        emoji: '🎸',
        name: 'Vinil & Records',
        members: 8900,
        posts: 98,
        cat: 'Vinils & CDs',
        desc:
            'Para apaixonados por música em vinil. Rarezas, conservação e troca entre colecionadores.',
        tags: ['Vinil', 'Música', 'Records', 'Raridades']),
    _Comm(
        emoji: '🦸',
        name: 'HQs & Comics Brasil',
        members: 6700,
        posts: 76,
        cat: 'Quadrinhos',
        desc:
            'Quadrinhos e HQs de todas as editoras. Marvel, DC, Abril e independentes.',
        tags: ['HQ', 'Comics', 'Marvel', 'DC']),
    _Comm(
        emoji: '🚗',
        name: 'Miniaturas Collectors',
        members: 4200,
        posts: 54,
        cat: 'Miniaturas',
        desc:
            'Hot Wheels, Matchbox, Burago, Corgi — se tem roda e é miniatura, é aqui!',
        tags: ['Hot Wheels', 'Miniatura', 'Matchbox']),
    _Comm(
        emoji: '🎴',
        name: 'Magic The Gathering BR',
        members: 9800,
        posts: 201,
        cat: 'Cards TCG',
        desc:
            'Magic no Brasil. Alpha, Beta, Commander, Modern, Legacy. Trades e torneios.',
        tags: ['Magic', 'MTG', 'Cards', 'Torneio']),
    _Comm(
        emoji: '👟',
        name: 'Sneakers & Kicks BR',
        members: 15000,
        posts: 430,
        cat: 'Tênis',
        desc:
            'A maior comunidade de tênis e sneakers do Brasil. Nike, Adidas, Jordan.',
        tags: ['Sneakers', 'Nike', 'Jordan']),
  ];

  List<_Comm> get _filtered => _communities.where((c) {
        final matchCat = _cat == 'Todas' || c.cat == _cat;
        final q = _searchCtrl.text.toLowerCase();
        return matchCat &&
            (q.isEmpty ||
                c.name.toLowerCase().contains(q) ||
                c.cat.toLowerCase().contains(q));
      }).toList();

  void _pickCat() {
    showModalBottomSheet(
        context: context,
        backgroundColor: _card,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            expand: false,
            builder: (ctx, sc) => Column(children: [
                  Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: _border2,
                          borderRadius: BorderRadius.circular(2))),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        Text('CATEGORIA',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20, color: _text, letterSpacing: 2)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Navigator.pop(ctx),
                            child: const Icon(Icons.close_rounded,
                                color: _muted, size: 22))
                      ])),
                  const SizedBox(height: 8),
                  const Divider(color: _border),
                  Expanded(
                      child: ListView.builder(
                          controller: sc,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          itemCount: _cats.length,
                          itemBuilder: (ctx2, i) {
                            final c = _cats[i];
                            final sel = _cat == c;
                            return GestureDetector(
                                onTap: () {
                                  setState(() => _cat = c);
                                  Navigator.pop(ctx);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                        color: sel
                                            ? _primary.withOpacity(0.12)
                                            : _card2,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: sel ? _primary : _border)),
                                    child: Row(children: [
                                      Text(c,
                                          style: GoogleFonts.familjenGrotesk(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: sel ? _primary : _text)),
                                      const Spacer(),
                                      if (sel)
                                        const Icon(Icons.check_circle_rounded,
                                            color: _primary, size: 18)
                                    ])));
                          })),
                ])));
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    final crossCount = widget.isDesktop ? 3 : 2;
    return Column(children: [
      _FilterBar(
          context: context,
          filterLabel: _cat,
          filterActive: _cat != 'Todas',
          onFilterTap: _pickCat,
          searchCtrl: _searchCtrl,
          onSearchChanged: () => setState(() {}),
          onClearFilter: () => setState(() => _cat = 'Todas')),
      Expanded(
          child: items.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text('👥', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 12),
                      Text('NENHUMA COMUNIDADE',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 16, color: _muted2, letterSpacing: 2))
                    ]))
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: widget.isDesktop ? 1.4 : 1.15),
                  itemCount: items.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                      onTap: () => Navigator.of(ctx).push(MaterialPageRoute(
                          builder: (_) => _CommPage(comm: items[i]))),
                      child: _CommCard(comm: items[i])))),
    ]);
  }
}

class _CommCard extends StatelessWidget {
  final _Comm comm;
  const _CommCard({required this.comm});
  String _fmt(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              height: 58,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: _card2,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(11))),
              child: Center(
                  child:
                      Text(comm.emoji, style: const TextStyle(fontSize: 28)))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comm.name,
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: _text),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 3),
                        Text(
                            '${_fmt(comm.members)} membros · ${comm.posts} posts hoje',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 9, color: _muted)),
                        const Spacer(),
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                                color: _primary,
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                                child: Text('VER',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 12,
                                        letterSpacing: 1.5,
                                        color: Colors.white)))),
                      ]))),
        ]),
      );
}

// Página da comunidade com layout lateral desktop
class _CommPage extends StatefulWidget {
  final _Comm comm;
  const _CommPage({required this.comm});
  @override
  State<_CommPage> createState() => _CommPageState();
}

class _CommPageState extends State<_CommPage>
    with SingleTickerProviderStateMixin {
  bool _joined = false;
  late TabController _tab;
  final _postCtrl = TextEditingController();
  String _postType = 'texto';
  String _fmt(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';

  void _showMembers(BuildContext context) {
    final searchCtrl = TextEditingController();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: _card,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => StatefulBuilder(
            builder: (ctx, setSheet) => DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.4,
                  maxChildSize: 0.9,
                  expand: false,
                  builder: (ctx2, sc) {
                    final filtered = searchCtrl.text.isEmpty
                        ? _members
                        : _members
                            .where((m) => m
                                .toLowerCase()
                                .contains(searchCtrl.text.toLowerCase()))
                            .toList();
                    return Column(children: [
                      Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: _border2,
                              borderRadius: BorderRadius.circular(2))),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(children: [
                            Text('MEMBROS',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: _text,
                                    letterSpacing: 2)),
                            const SizedBox(width: 8),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    color: _primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('${_members.length}',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 10, color: Colors.white))),
                            const Spacer(),
                            GestureDetector(
                                onTap: () => Navigator.pop(ctx),
                                child: const Icon(Icons.close_rounded,
                                    color: _muted, size: 22)),
                          ])),
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                  color: _card2,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: _border)),
                              child: Row(children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(Icons.search_rounded,
                                        color: _muted, size: 16)),
                                Expanded(
                                    child: TextField(
                                        controller: searchCtrl,
                                        onChanged: (_) => setSheet(() {}),
                                        style: GoogleFonts.familjenGrotesk(
                                            color: _text, fontSize: 13),
                                        decoration: InputDecoration(
                                            hintText: 'Buscar membro...',
                                            hintStyle:
                                                GoogleFonts.familjenGrotesk(
                                                    color: _muted2,
                                                    fontSize: 13),
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 10),
                                            isDense: true)))
                              ]))),
                      const SizedBox(height: 8),
                      const Divider(color: _border),
                      Expanded(
                          child: ListView.builder(
                              controller: sc,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              itemCount: filtered.length,
                              itemBuilder: (_, i) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                      color: _card2,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: _border)),
                                  child: Text(filtered[i],
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 13, color: _text))))),
                    ]);
                  },
                )));
  }

  final List<Map<String, dynamic>> _posts = [
    {
      'user': 'pokemon_rafael',
      'emoji': '🏎️',
      'type': 'foto',
      'content': '🐲',
      'text': 'Acabei de adicionar minha nova aquisição à coleção!',
      'likes': 47,
      'time': '2h'
    },
    {
      'user': 'magic_sp',
      'emoji': '🎴',
      'type': 'texto',
      'content': '',
      'text':
          'Alguém tem interesse em troca? Tenho cartas alpha disponíveis para negociação.',
      'likes': 23,
      'time': '4h'
    },
    {
      'user': 'vinyl_br',
      'emoji': '🎸',
      'type': 'video',
      'content': '🐲',
      'text': 'Abrindo pack ao vivo! Quem aí conseguiu o Charizard Holo?',
      'likes': 89,
      'time': '6h'
    },
    {
      'user': 'shirts_br',
      'emoji': '👕',
      'type': 'foto',
      'content': '👕',
      'text': 'Nova camisa chegou! Brasil 1958 🇧🇷',
      'likes': 34,
      'time': '8h'
    },
  ];

  final List<String> _members = [
    'pokemon_rafael 🏎️',
    'magic_sp 🎴',
    'vinyl_br 🎸',
    'hq_collector 🦸',
    'shirts_br 👕',
    'cars_col 🚗',
    'trains_sp 🚂'
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Widget _buildPostInput() {
    if (!_joined) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _border)),
      child: Column(children: [
        Row(children: [
          for (final type in ['texto', 'foto', 'video'])
            GestureDetector(
                onTap: () => setState(() => _postType = type),
                child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: _postType == type ? _primary : _card2,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(
                          type == 'texto'
                              ? Icons.text_fields_rounded
                              : type == 'foto'
                                  ? Icons.photo_rounded
                                  : Icons.videocam_rounded,
                          size: 12,
                          color: _postType == type ? Colors.white : _muted),
                      const SizedBox(width: 4),
                      Text(type.toUpperCase(),
                          style: GoogleFonts.bebasNeue(
                              fontSize: 10,
                              letterSpacing: 1,
                              color:
                                  _postType == type ? Colors.white : _muted)),
                    ]))),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
              child: TextField(
                  controller: _postCtrl,
                  onChanged: (_) => setState(() {}),
                  style:
                      GoogleFonts.familjenGrotesk(color: _text, fontSize: 12),
                  decoration: InputDecoration(
                      hintText: 'Compartilhe algo...',
                      hintStyle: GoogleFonts.familjenGrotesk(
                          color: _muted2, fontSize: 12),
                      filled: true,
                      fillColor: _card2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _border)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _border)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _primary)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      isDense: true))),
          const SizedBox(width: 8),
          GestureDetector(
              onTap: () {
                if (_postCtrl.text.trim().isNotEmpty) {
                  setState(() {
                    _posts.insert(0, {
                      'user': 'rafael',
                      'emoji': '🏎️',
                      'type': _postType,
                      'content': '',
                      'text': _postCtrl.text.trim(),
                      'likes': 0,
                      'time': 'agora'
                    });
                    _postCtrl.clear();
                  });
                }
              },
              child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                      color: _primary, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.white, size: 16))),
        ]),
      ]),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
            child: Row(children: [
              Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: _card2),
                  child: Center(
                      child: Text(p['emoji'],
                          style: const TextStyle(fontSize: 15)))),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(p['user'],
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _text))),
              Text(p['time'],
                  style:
                      GoogleFonts.familjenGrotesk(fontSize: 10, color: _muted)),
            ])),
        if (p['content'].isNotEmpty)
          AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(color: _card2),
                child: Center(
                    child: Stack(alignment: Alignment.center, children: [
                  Text(p['content'], style: const TextStyle(fontSize: 60)),
                  if (p['type'] == 'video')
                    Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: 26)),
                ])),
              )),
        if (p['text'].isNotEmpty)
          Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
              child: Text(p['text'],
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 12, color: const Color(0xFFB0A898)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
            child: Row(children: [
              const Icon(Icons.favorite_border, color: _muted, size: 15),
              const SizedBox(width: 4),
              Text('${p['likes']}',
                  style:
                      GoogleFonts.familjenGrotesk(fontSize: 11, color: _muted)),
              const SizedBox(width: 12),
              const Icon(Icons.chat_bubble_outline_rounded,
                  color: _muted, size: 14)
            ])),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
          child: Column(children: [
        // Banner
        Stack(children: [
          Container(
              height: 140,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF1a0800),
                Color(0xFF3a1800),
                Color(0xFF6a2800)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Center(
                  child: Text(widget.comm.emoji,
                      style: const TextStyle(fontSize: 56)))),
          Positioned(
              top: 12,
              left: 12,
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: Colors.white, size: 18)))),
        ]),
        // Info header
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.comm.name,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 22, color: _text, letterSpacing: 1)),
              Text(
                  '${_fmt(widget.comm.members)} membros · ${widget.comm.posts} posts hoje',
                  style:
                      GoogleFonts.familjenGrotesk(fontSize: 12, color: _muted)),
            ])),
        const SizedBox(height: 8),
        // Layout
        Expanded(
            child: isDesktop
                // Desktop: lateral esquerda info/membros + direita posts
                ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // Sidebar esquerda — textos maiores + botões verticais
                    SizedBox(
                        width: 300,
                        child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SOBRE',
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 10,
                                          color: _muted,
                                          letterSpacing: 1.5)),
                                  const SizedBox(height: 8),
                                  Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                          color: _card,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(color: _border)),
                                      child: Text(widget.comm.desc,
                                          style: GoogleFonts.familjenGrotesk(
                                              fontSize: 13,
                                              color: const Color(0xFFB0A898),
                                              height: 1.5))),
                                  const SizedBox(height: 14),
                                  Text('TAGS',
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 10,
                                          color: _muted,
                                          letterSpacing: 1.5)),
                                  const SizedBox(height: 8),
                                  Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children: widget.comm.tags
                                          .map((t) => Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                  color:
                                                      _primary.withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: _primary
                                                          .withOpacity(0.3))),
                                              child: Text('#$t',
                                                  style:
                                                      GoogleFonts.jetBrainsMono(
                                                          fontSize: 10,
                                                          color: _primary))))
                                          .toList()),
                                  const SizedBox(height: 16),
                                  // Botões verticais
                                  SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            setState(() => _joined = !_joined),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: _joined
                                                ? Colors.transparent
                                                : _primary,
                                            foregroundColor:
                                                _joined ? _muted : Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: _joined
                                                    ? const BorderSide(
                                                        color: _border2)
                                                    : BorderSide.none),
                                            elevation: 0),
                                        child: Text(
                                            _joined
                                                ? 'PARTICIPANDO'
                                                : 'PARTICIPAR',
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: 15,
                                                letterSpacing: 2)),
                                      )),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Link da comunidade copiado! 🔗',
                                                      style: GoogleFonts
                                                          .familjenGrotesk(
                                                              fontSize: 13)),
                                                  backgroundColor: _green,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: _card2,
                                            foregroundColor: _text,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    color: _border2)),
                                            elevation: 0),
                                        child: Text('CONVIDAR',
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: 15,
                                                letterSpacing: 2)),
                                      )),
                                  const SizedBox(height: 16),
                                  // Membros clicáveis com busca
                                  GestureDetector(
                                    onTap: () => _showMembers(context),
                                    child: Row(children: [
                                      Text('MEMBROS (${_members.length})',
                                          style: GoogleFonts.jetBrainsMono(
                                              fontSize: 10,
                                              color: _muted,
                                              letterSpacing: 1.5)),
                                      const Spacer(),
                                      const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: _muted,
                                          size: 12),
                                    ]),
                                  ),
                                  const SizedBox(height: 8),
                                  ..._members.take(4).map((m) =>
                                      GestureDetector(
                                          onTap: () => _showMembers(context),
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 6),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 9),
                                              decoration: BoxDecoration(
                                                  color: _card,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: _border)),
                                              child: Text(m,
                                                  style: GoogleFonts
                                                      .familjenGrotesk(
                                                          fontSize: 13,
                                                          color: _text))))),
                                  if (_members.length > 4)
                                    GestureDetector(
                                        onTap: () => _showMembers(context),
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: Text('Ver todos →',
                                                style:
                                                    GoogleFonts.familjenGrotesk(
                                                        fontSize: 13,
                                                        color: _primary,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            _primary)))),
                                ]))),
                    const VerticalDivider(width: 1, color: _border),
                    // Posts
                    Expanded(
                        child: Column(children: [
                      _buildPostInput(),
                      Expanded(
                          child: ListView.builder(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 12, 16, 16),
                              itemCount: _posts.length,
                              itemBuilder: (_, i) =>
                                  _buildPostCard(_posts[i]))),
                    ])),
                  ])
                // Mobile: abas
                : Column(children: [
                    TabBar(
                        controller: _tab,
                        dividerColor: Colors.transparent,
                        indicatorColor: _primary,
                        indicatorWeight: 2,
                        labelColor: _primary,
                        unselectedLabelColor: _muted,
                        labelStyle: GoogleFonts.bebasNeue(
                            fontSize: 12, letterSpacing: 1.5),
                        unselectedLabelStyle: GoogleFonts.bebasNeue(
                            fontSize: 12, letterSpacing: 1.5),
                        tabs: const [
                          Tab(text: 'POSTS'),
                          Tab(text: 'MEMBROS'),
                          Tab(text: 'SOBRE')
                        ]),
                    Expanded(
                        child: TabBarView(controller: _tab, children: [
                      Column(children: [
                        _buildPostInput(),
                        Expanded(
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 12, 16, 16),
                                itemCount: _posts.length,
                                itemBuilder: (_, i) =>
                                    _buildPostCard(_posts[i])))
                      ]),
                      ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _members.length,
                          itemBuilder: (_, i) => Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                  color: _card,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: _border)),
                              child: Text(_members[i],
                                  style: GoogleFonts.familjenGrotesk(
                                      fontSize: 12, color: _text)))),
                      SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SOBRE',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 9,
                                        color: _muted,
                                        letterSpacing: 1.5)),
                                const SizedBox(height: 8),
                                Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: _card,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: _border)),
                                    child: Text(widget.comm.desc,
                                        style: GoogleFonts.familjenGrotesk(
                                            fontSize: 12,
                                            color: const Color(0xFFB0A898),
                                            height: 1.5))),
                                const SizedBox(height: 12),
                                Text('TAGS',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 9,
                                        color: _muted,
                                        letterSpacing: 1.5)),
                                const SizedBox(height: 8),
                                Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: widget.comm.tags
                                        .map((t) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                                color:
                                                    _primary.withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: _primary
                                                        .withOpacity(0.3))),
                                            child: Text('#$t',
                                                style:
                                                    GoogleFonts.jetBrainsMono(
                                                        fontSize: 9,
                                                        color: _primary))))
                                        .toList()),
                              ])),
                    ])),
                  ])),
      ])),
    );
  }
}

// ════════════════════════════════════════
// ABA PERFIS
// ════════════════════════════════════════
class _ProfilesTab extends StatefulWidget {
  final bool isDesktop;
  const _ProfilesTab({required this.isDesktop});
  @override
  State<_ProfilesTab> createState() => _ProfilesTabState();
}

class _ProfilesTabState extends State<_ProfilesTab> {
  String _cat = 'Todos';
  final _searchCtrl = TextEditingController();
  static const _cats = [
    'Todos',
    'Cards TCG',
    'Vinils',
    'Quadrinhos',
    'Miniaturas',
    'Camisas',
    'Tênis'
  ];

  static final _profiles = [
    _Profile(
        emoji: '🏎️',
        name: 'Garage TCG',
        handle: '@pokemon_rafael',
        pieces: 347,
        followers: 1200,
        cat: 'Cards TCG / Miniaturas',
        city: 'São Paulo',
        bio:
            'Colecionador de Pokémon desde 1999. Especialista em cartas PSA. Trader ativo.'),
    _Profile(
        emoji: '🎸',
        name: 'Garagem do Vinil',
        handle: '@vinyl_br',
        pieces: 128,
        followers: 890,
        cat: 'Vinils & CDs',
        city: 'São Paulo',
        bio:
            'Apaixonado por vinil desde os 15 anos. Foco em rock clássico e MPB.'),
    _Profile(
        emoji: '🦸',
        name: 'HQ Garage',
        handle: '@hq_collector',
        pieces: 89,
        followers: 654,
        cat: 'Quadrinhos / Action Figures',
        city: 'Rio de Janeiro',
        bio: 'Colecionador de HQs raras. Marvel e DC. 20 anos no hobby.'),
    _Profile(
        emoji: '🚂',
        name: 'Trainz Collection',
        handle: '@trains_sp',
        pieces: 214,
        followers: 432,
        cat: 'Miniaturas',
        city: 'Curitiba',
        bio: 'Miniaturas de trens e carros. Peças raras dos anos 60-80.'),
    _Profile(
        emoji: '👕',
        name: 'Shirts Brasil',
        handle: '@shirts_br',
        pieces: 67,
        followers: 987,
        cat: 'Camisas / Selos',
        city: 'Belo Horizonte',
        bio:
            'Camisas históricas do futebol. Copas do Mundo e clubes brasileiros.'),
    _Profile(
        emoji: '🎴',
        name: 'Magic SP',
        handle: '@magic_sp',
        pieces: 503,
        followers: 2100,
        cat: 'Cards TCG',
        city: 'São Paulo',
        bio: 'Magic The Gathering desde 1995. Alpha, Beta, Legends.'),
  ];

  List<_Profile> get _filtered => _profiles.where((p) {
        final matchCat = _cat == 'Todos' || p.cat == _cat;
        final q = _searchCtrl.text.toLowerCase();
        return matchCat &&
            (q.isEmpty ||
                p.name.toLowerCase().contains(q) ||
                p.handle.toLowerCase().contains(q));
      }).toList();

  void _pickCat() {
    showModalBottomSheet(
        context: context,
        backgroundColor: _card,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            expand: false,
            builder: (ctx, sc) => Column(children: [
                  Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: _border2,
                          borderRadius: BorderRadius.circular(2))),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        Text('CATEGORIA',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20, color: _text, letterSpacing: 2)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Navigator.pop(ctx),
                            child: const Icon(Icons.close_rounded,
                                color: _muted, size: 22))
                      ])),
                  const SizedBox(height: 8),
                  const Divider(color: _border),
                  Expanded(
                      child: ListView.builder(
                          controller: sc,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          itemCount: _cats.length,
                          itemBuilder: (ctx2, i) {
                            final c = _cats[i];
                            final sel = _cat == c;
                            return GestureDetector(
                                onTap: () {
                                  setState(() => _cat = c);
                                  Navigator.pop(ctx);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                        color: sel
                                            ? _primary.withOpacity(0.12)
                                            : _card2,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: sel ? _primary : _border)),
                                    child: Row(children: [
                                      Text(c,
                                          style: GoogleFonts.familjenGrotesk(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: sel ? _primary : _text)),
                                      const Spacer(),
                                      if (sel)
                                        const Icon(Icons.check_circle_rounded,
                                            color: _primary, size: 18)
                                    ])));
                          })),
                ])));
  }

  String _fmt(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    final crossCount = widget.isDesktop ? 4 : 2;
    return Column(children: [
      _FilterBar(
          context: context,
          filterLabel: _cat,
          filterActive: _cat != 'Todos',
          onFilterTap: _pickCat,
          searchCtrl: _searchCtrl,
          onSearchChanged: () => setState(() {}),
          onClearFilter: () => setState(() => _cat = 'Todos')),
      Expanded(
          child: items.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text('👤', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 12),
                      Text('NENHUM PERFIL ENCONTRADO',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 16, color: _muted2, letterSpacing: 2))
                    ]))
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: widget.isDesktop ? 0.9 : 0.78),
                  itemCount: items.length,
                  itemBuilder: (ctx, i) {
                    final p = items[i];
                    return GestureDetector(
                        onTap: () => _showCenteredDialog(
                            ctx, _ProfileDialog(profile: p)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: _card,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: _border)),
                          child: Column(children: [
                            // Banner pequeno com avatar
                            Container(
                                height: 56,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF1a0800),
                                          Color(0xFF3a1800)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(11))),
                                child: Center(
                                    child: Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _card2,
                                            border: Border.all(
                                                color: _primary, width: 2)),
                                        child: Center(
                                            child: Text(p.emoji,
                                                style: const TextStyle(
                                                    fontSize: 22)))))),
                            // Info preenchendo o card
                            Expanded(
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(p.name,
                                              style:
                                                  GoogleFonts.familjenGrotesk(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: _text),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center),
                                          Text(p.handle,
                                              style:
                                                  GoogleFonts.familjenGrotesk(
                                                      fontSize: 11,
                                                      color: _muted),
                                              textAlign: TextAlign.center),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('${p.pieces}',
                                                    style:
                                                        GoogleFonts.bebasNeue(
                                                            fontSize: 16,
                                                            color: _primary)),
                                                Text(' pç',
                                                    style: GoogleFonts
                                                        .familjenGrotesk(
                                                            fontSize: 10,
                                                            color: _muted)),
                                                const SizedBox(width: 8),
                                                Container(
                                                    width: 1,
                                                    height: 14,
                                                    color: _border),
                                                const SizedBox(width: 8),
                                                Text(_fmt(p.followers),
                                                    style:
                                                        GoogleFonts.bebasNeue(
                                                            fontSize: 16,
                                                            color: _text)),
                                                Text(' seg',
                                                    style: GoogleFonts
                                                        .familjenGrotesk(
                                                            fontSize: 10,
                                                            color: _muted)),
                                              ]),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                  color: _card2,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(p.cat,
                                                  style:
                                                      GoogleFonts.jetBrainsMono(
                                                          fontSize: 10,
                                                          color: _muted),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center)),
                                        ]))),
                          ]),
                        ));
                  })),
    ]);
  }
}

// Dialog preview do perfil
class _ProfileDialog extends StatefulWidget {
  final _Profile profile;
  const _ProfileDialog({required this.profile});
  @override
  State<_ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<_ProfileDialog> {
  bool _following = false;
  String _fmt(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';
  @override
  Widget build(BuildContext context) {
    final p = widget.profile;
    return Container(
        color: _card,
        child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Banner SEM avatar
          Stack(children: [
            Container(
                height: 90,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xFF1a0800),
                  Color(0xFF3a1800),
                  Color(0xFF6a2800)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight))),
            Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.close_rounded,
                            color: Colors.white, size: 14)))),
          ]),
          const SizedBox(height: 12),
          // Nome + handle
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(children: [
                Text(p.name,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 20, color: _text, letterSpacing: 1),
                    textAlign: TextAlign.center),
                Text(p.handle,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 11, color: _muted),
                    textAlign: TextAlign.center),
                const SizedBox(height: 10),
                // Avatar maior + botões na mesma linha
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _card2,
                          border: Border.all(color: _primary, width: 2)),
                      child: Center(
                          child: Text(p.emoji,
                              style: const TextStyle(fontSize: 28)))),
                  const SizedBox(width: 10),
                  Expanded(
                      child: GestureDetector(
                          onTap: () => setState(() => _following = !_following),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                                color:
                                    _following ? Colors.transparent : _primary,
                                borderRadius: BorderRadius.circular(8),
                                border: _following
                                    ? Border.all(color: _border2)
                                    : null),
                            child: Center(
                                child: Text(_following ? 'SEGUINDO' : 'SEGUIR',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 13,
                                        letterSpacing: 1.5,
                                        color: _following
                                            ? _muted
                                            : Colors.white))),
                          ))),
                  const SizedBox(width: 8),
                  Expanded(
                      child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                                color: _card2,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: _border2)),
                            child: Center(
                                child: Text('VER PERFIL',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 13,
                                        letterSpacing: 1.5,
                                        color: _text))),
                          ))),
                ]),
                const SizedBox(height: 10),
                Text(p.bio,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 11, color: _muted, height: 1.4),
                    textAlign: TextAlign.center),
                const SizedBox(height: 4),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.location_on_rounded,
                      color: _muted, size: 11),
                  const SizedBox(width: 3),
                  Text(p.city,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 10, color: _muted))
                ]),
                const SizedBox(height: 12),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: _card2,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _border)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _Stat(value: '${p.pieces}', label: 'PEÇAS'),
                          Container(width: 1, height: 22, color: _border),
                          _Stat(value: _fmt(p.followers), label: 'SEGUIDORES'),
                          Container(width: 1, height: 22, color: _border),
                          _Stat(value: 'R\$ 12k', label: 'VALOR'),
                        ])),
                const SizedBox(height: 12),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('PEÇAS RECENTES',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 8, color: _muted, letterSpacing: 1.5))),
                const SizedBox(height: 8),
                GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 1.0,
                    children: List.generate(
                        6,
                        (_) => Container(
                            color: _card2,
                            child: Center(
                                child: Text(p.emoji,
                                    style: const TextStyle(fontSize: 22)))))),
                const SizedBox(height: 14),
              ])),
        ])));
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(children: [
        Text(value,
            style: GoogleFonts.bebasNeue(
                fontSize: 18, color: _text, letterSpacing: 1)),
        Text(label,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 8, color: _muted, letterSpacing: 1)),
      ]);
}

// ════════════════════════════════════════
// MODELOS
// ════════════════════════════════════════
class _Post {
  final String emoji, user, uEmoji, name, caption, cat, cond;
  final int likes;
  final bool isVideo;
  const _Post(
      {required this.emoji,
      required this.user,
      required this.uEmoji,
      required this.name,
      required this.caption,
      required this.cat,
      required this.likes,
      required this.isVideo,
      required this.cond});
}

class _Event {
  final String emoji,
      title,
      organizer,
      oEmoji,
      date,
      time,
      location,
      address,
      type,
      desc,
      cat;
  final int attendees;
  const _Event(
      {required this.emoji,
      required this.title,
      required this.organizer,
      required this.oEmoji,
      required this.date,
      required this.time,
      required this.location,
      required this.address,
      required this.attendees,
      required this.type,
      required this.desc,
      required this.cat});
}

class _Comm {
  final String emoji, name, cat, desc;
  final List<String> tags;
  final int members, posts;
  const _Comm(
      {required this.emoji,
      required this.name,
      required this.members,
      required this.posts,
      required this.cat,
      required this.desc,
      required this.tags});
}

class _Profile {
  final String emoji, name, handle, cat, city, bio;
  final int pieces, followers;
  const _Profile(
      {required this.emoji,
      required this.name,
      required this.handle,
      required this.pieces,
      required this.followers,
      required this.cat,
      required this.city,
      required this.bio});
}
