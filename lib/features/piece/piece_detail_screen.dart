import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieceDetailScreen extends StatefulWidget {
  const PieceDetailScreen({super.key});

  @override
  State<PieceDetailScreen> createState() => _PieceDetailScreenState();
}

class _PieceDetailScreenState extends State<PieceDetailScreen> {
  int _currentPhoto = 0;
  bool _liked = false;
  bool _showValue = true;
  bool _showPricePaid = false;
  bool _isPublic = true;
  bool _isForTrade = false;
  bool _isSealed = true;
  bool _editingNotes = false;

  final List<String> _photos = ['🐲', '🎴', '✨'];
  final _commentController = TextEditingController();
  final _notesController = TextEditingController(
      text:
          'Comprado na feira do Bixiga em março de 2022. Vendedor garantiu autenticidade.');

  final List<_Comment> _comments = [
    _Comment(
        username: 'vinyl_br',
        emoji: '🎸',
        text: 'Incrível! Quanto tempo procurando esse?',
        time: '2h'),
    _Comment(
        username: 'hq_collector',
        emoji: '🦸',
        text: 'Um dos melhores cards já feitos 🔥',
        time: '5h'),
  ];

  final List<_UserLike> _likers = [
    _UserLike(username: 'vinyl_br', emoji: '🎸', garage: 'Garagem do Vinil'),
    _UserLike(username: 'hq_collector', emoji: '🦸', garage: 'HQ Garage'),
    _UserLike(username: 'trains_sp', emoji: '🚂', garage: 'Trainz Collection'),
    _UserLike(username: 'stamps_br', emoji: '📮', garage: 'Selos do Brasil'),
  ];

  // ✅ Dados financeiros
  final double _pricePaid = 800.0;
  final double _marketValue = 2400.0;

  double get _appreciation => ((_marketValue - _pricePaid) / _pricePaid) * 100;
  bool get _appreciated => _marketValue >= _pricePaid;

  void _openLikes() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: const Color(0xFF3A3428),
                    borderRadius: BorderRadius.circular(2))),
            Text('${384 + (_liked ? 1 : 0)} CURTIDAS',
                style: GoogleFonts.bebasNeue(
                    fontSize: 18,
                    color: const Color(0xFFF0ECE4),
                    letterSpacing: 2)),
            const Divider(color: Color(0xFF2E2A22)),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _likers.length + (_liked ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_liked && index == 0) {
                    return _LikerRow(
                        username: 'você',
                        emoji: '🏎️',
                        garage: 'Minha Garagem',
                        isMe: true,
                        onTap: () {});
                  }
                  final i = _liked ? index - 1 : index;
                  return _LikerRow(
                      username: _likers[i].username,
                      emoji: _likers[i].emoji,
                      garage: _likers[i].garage,
                      isMe: false,
                      onTap: () => Navigator.pop(context));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) => Column(
            children: [
              Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFF3A3428),
                      borderRadius: BorderRadius.circular(2))),
              Text('COMENTÁRIOS',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 18,
                      color: const Color(0xFFF0ECE4),
                      letterSpacing: 2)),
              const Divider(color: Color(0xFF2E2A22)),
              Expanded(
                child: _comments.isEmpty
                    ? Center(
                        child: Text(
                            'Nenhum comentário ainda.\nSeja o primeiro!',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 13, color: const Color(0xFF7A7060)),
                            textAlign: TextAlign.center))
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _comments.length,
                        itemBuilder: (context, index) => _CommentRow(
                            comment: _comments[index],
                            onTap: () => Navigator.pop(context))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    top: 8),
                child: Row(
                  children: [
                    Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF242018)),
                        child: const Center(
                            child:
                                Text('🏎️', style: TextStyle(fontSize: 14)))),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        autofocus: true,
                        style: GoogleFonts.familjenGrotesk(
                            color: const Color(0xFFF0ECE4), fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Adicione um comentário...',
                          hintStyle: GoogleFonts.familjenGrotesk(
                              color: const Color(0xFF4A4438), fontSize: 14),
                          filled: true,
                          fillColor: const Color(0xFF242018),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        if (_commentController.text.trim().isNotEmpty) {
                          setModalState(() {
                            _comments.add(_Comment(
                                username: 'você',
                                emoji: '🏎️',
                                text: _commentController.text.trim(),
                                time: 'agora'));
                            _commentController.clear();
                          });
                          setState(() {});
                        }
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xFFD4622A),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.send_rounded,
                              color: Colors.white, size: 18)),
                    ),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: Column(
          children: [
            // ── TOPBAR ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF2E2A22))),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFFF0ECE4), size: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('DETALHES DA PEÇA',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2)),
                  const Spacer(),
                  const Icon(Icons.more_horiz,
                      color: Color(0xFF7A7060), size: 24),
                ],
              ),
            ),

            Expanded(
              child: isDesktop
                  ? _buildDesktopLayout(screenWidth)
                  : _buildMobileLayout(screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════
  // LAYOUT DESKTOP — duas colunas
  // ══════════════════════════════════════
  Widget _buildDesktopLayout(double screenWidth) {
    return Center(
      child: SizedBox(
        width: 900,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Coluna esquerda: fotos + ações sociais
            SizedBox(
              width: 380,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCarousel(380),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildSocialRow(),
                          const SizedBox(height: 16),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(width: 1, color: const Color(0xFF2E2A22)),

            // ✅ Coluna direita: infos + gerenciamento
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPieceHeader(),
                    const SizedBox(height: 16),
                    _buildInfoCards(),
                    const SizedBox(height: 16),
                    _buildMetaTags(),
                    const SizedBox(height: 20),
                    _buildStateSection(),
                    const SizedBox(height: 20),
                    _buildFinancialSection(),
                    const SizedBox(height: 20),
                    _buildPrivateManagement(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════
  // LAYOUT MOBILE — coluna única
  // ══════════════════════════════════════
  Widget _buildMobileLayout(double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCarousel(screenWidth),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPieceHeader(),
                const SizedBox(height: 16),
                _buildInfoCards(),
                const SizedBox(height: 16),
                _buildMetaTags(),
                const SizedBox(height: 20),
                _buildStateSection(),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFF2E2A22)),
                const SizedBox(height: 12),
                _buildSocialRow(),
                const SizedBox(height: 20),
                _buildActionButtons(),
                const SizedBox(height: 28),
                _buildFinancialSection(),
                const SizedBox(height: 20),
                _buildPrivateManagement(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── CAROUSEL ──
  Widget _buildCarousel(double size) {
    return Stack(
      children: [
        SizedBox(
          width: size,
          height: size * 0.85,
          child: PageView.builder(
            itemCount: _photos.length,
            onPageChanged: (i) => setState(() => _currentPhoto = i),
            itemBuilder: (context, index) => Container(
              color: const Color(0xFF1a0800),
              child: Center(
                  child: Text(_photos[index],
                      style: const TextStyle(fontSize: 100))),
            ),
          ),
        ),
        // ✅ Badge de estado no canto superior esquerdo
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _isSealed
                  ? const Color(0xFF4CAF7A).withOpacity(0.9)
                  : const Color(0xFFD4622A).withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(_isSealed ? '🔒' : '🔓',
                    style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 4),
                Text(_isSealed ? 'LACRADO' : 'ABERTO',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 11, letterSpacing: 1, color: Colors.white)),
              ],
            ),
          ),
        ),
        // Dots
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                _photos.length,
                (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _currentPhoto == i ? 20 : 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: _currentPhoto == i
                            ? const Color(0xFFD4622A)
                            : const Color(0xFF3A3428),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    )),
          ),
        ),
      ],
    );
  }

  // ── HEADER DA PEÇA ──
  Widget _buildPieceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF7A).withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF4CAF7A).withOpacity(0.3)),
          ),
          child: Text('✦ NEAR MINT',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: const Color(0xFF4CAF7A),
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 10),
        Text('CHARIZARD HOLO\nBASE SET',
            style: GoogleFonts.bebasNeue(
                fontSize: 32,
                color: const Color(0xFFF0ECE4),
                letterSpacing: 2,
                height: 1.1)),
        const SizedBox(height: 4),
        Text('Pokémon TCG · 1999 · Nº 4/102',
            style: GoogleFonts.familjenGrotesk(
                fontSize: 13, color: const Color(0xFF7A7060))),
      ],
    );
  }

  // ── INFO CARDS ──
  Widget _buildInfoCards() {
    return Row(
      children: [
        Expanded(
            child:
                _InfoCard(label: 'ITEM', value: 'Charizard Holo', icon: '🎴')),
        const SizedBox(width: 10),
        Expanded(
            child: _InfoCard(
                label: 'SÉRIE / COLEÇÃO', value: 'Base Set', icon: '📦')),
      ],
    );
  }

  // ── META TAGS ──
  Widget _buildMetaTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _MetaTag(label: 'Ano', value: '1999'),
        _MetaTag(label: 'Editora', value: 'Wizards'),
        _MetaTag(label: 'Idioma', value: 'EN'),
        _MetaTag(label: 'Adquirido', value: 'Mar 2022'),
        _MetaTag(label: 'Categoria', value: 'Cards'),
        _MetaTag(label: 'Número', value: '4/102'),
      ],
    );
  }

  // ✅ SEÇÃO DE ESTADO — Lacrado / Aberto
  Widget _buildStateSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isSealed
              ? const Color(0xFF4CAF7A).withOpacity(0.3)
              : const Color(0xFFD4622A).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _isSealed
                  ? const Color(0xFF4CAF7A).withOpacity(0.1)
                  : const Color(0xFFD4622A).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(_isSealed ? '🔒' : '🔓',
                    style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_isSealed ? 'LACRADO' : 'ABERTO',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 16,
                        letterSpacing: 1.5,
                        color: _isSealed
                            ? const Color(0xFF4CAF7A)
                            : const Color(0xFFD4622A))),
                Text(
                    _isSealed
                        ? 'Item original nunca aberto'
                        : 'Item foi aberto ou usado',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12, color: const Color(0xFF7A7060))),
              ],
            ),
          ),
          // ✅ Toggle inline
          GestureDetector(
            onTap: () => setState(() => _isSealed = !_isSealed),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF242018),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF3A3428)),
              ),
              child: Text('ALTERAR',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 11,
                      letterSpacing: 1,
                      color: const Color(0xFF7A7060))),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ SEÇÃO FINANCEIRA — valor pago vs mercado com variação
  Widget _buildFinancialSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart_rounded,
                  color: Color(0xFF7A7060), size: 14),
              const SizedBox(width: 6),
              Text('VALORES',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: const Color(0xFF7A7060),
                      letterSpacing: 1.5)),
            ],
          ),
          const SizedBox(height: 16),

          // ✅ Comparativo lado a lado
          Row(
            children: [
              // Valor pago
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PAGUEI',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9,
                            color: const Color(0xFF7A7060),
                            letterSpacing: 1)),
                    const SizedBox(height: 4),
                    Text(
                      _showPricePaid
                          ? 'R\$ ${_pricePaid.toStringAsFixed(0)}'
                          : '••••••',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 24,
                          color: _showPricePaid
                              ? const Color(0xFFF0ECE4)
                              : const Color(0xFF3A3428),
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ),

              // Seta de valorização
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _appreciated
                      ? const Color(0xFF4CAF7A).withOpacity(0.1)
                      : const Color(0xFFD44A4A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      _appreciated
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      color: _appreciated
                          ? const Color(0xFF4CAF7A)
                          : const Color(0xFFD44A4A),
                      size: 20,
                    ),
                    Text(
                      '${_appreciated ? '+' : ''}${_appreciation.toStringAsFixed(0)}%',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 12,
                          color: _appreciated
                              ? const Color(0xFF4CAF7A)
                              : const Color(0xFFD44A4A),
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),

              // Valor de mercado
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('MERCADO',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9,
                            color: const Color(0xFF7A7060),
                            letterSpacing: 1)),
                    const SizedBox(height: 4),
                    Text(
                      _showValue
                          ? 'R\$ ${_marketValue.toStringAsFixed(0)}'
                          : '••••••',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 24,
                          color: _showValue
                              ? const Color(0xFFD4A020)
                              : const Color(0xFF3A3428),
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (_showPricePaid && _showValue) ...[
            const SizedBox(height: 12),
            // ✅ Barra de valorização
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_pricePaid / _marketValue).clamp(0.0, 1.0),
                backgroundColor: const Color(0xFF4CAF7A).withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF2E2A22)),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Valorizou R\$ ${(_marketValue - _pricePaid).toStringAsFixed(0)} desde a compra',
                style: GoogleFonts.familjenGrotesk(
                    fontSize: 12,
                    color: const Color(0xFF4CAF7A),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── LINHA SOCIAL ──
  Widget _buildSocialRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _liked = !_liked),
          child: Icon(
            _liked ? Icons.favorite : Icons.favorite_border,
            color: _liked ? const Color(0xFFD4622A) : const Color(0xFF7A7060),
            size: 22,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: _openLikes,
          child: Text('${384 + (_liked ? 1 : 0)} curtidas',
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 13,
                  color: const Color(0xFF7A7060),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF7A7060))),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: _openComments,
          child: const Icon(Icons.chat_bubble_outline,
              color: Color(0xFF7A7060), size: 22),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: _openComments,
          child: Text('${_comments.length} comentários',
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 13,
                  color: const Color(0xFF7A7060),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF7A7060))),
        ),
      ],
    );
  }

  // ── BOTÕES DE AÇÃO ──
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFF0ECE4),
              side: const BorderSide(color: Color(0xFF3A3428)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text('✏️ EDITAR',
                style: GoogleFonts.bebasNeue(fontSize: 15, letterSpacing: 1.5)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4622A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
            ),
            child: Text('🔄 PROPOR TROCA',
                style: GoogleFonts.bebasNeue(fontSize: 15, letterSpacing: 1.5)),
          ),
        ),
      ],
    );
  }

  // ── GERENCIAMENTO PRIVADO ──
  Widget _buildPrivateManagement() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lock_outline_rounded,
                  color: Color(0xFF7A7060), size: 14),
              const SizedBox(width: 6),
              Text('GERENCIAMENTO PRIVADO',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: const Color(0xFF7A7060),
                      letterSpacing: 1.5)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2E2A22)),
          const SizedBox(height: 12),
          Text('VISIBILIDADE',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: const Color(0xFF7A7060),
                  letterSpacing: 1.5)),
          const SizedBox(height: 12),
          _ToggleRow(
              label: 'Peça pública',
              subtitle: 'Aparece na sua garagem para seguidores',
              value: _isPublic,
              onChanged: (v) => setState(() => _isPublic = v)),
          const SizedBox(height: 10),
          _ToggleRow(
              label: 'Mostrar valor de mercado',
              subtitle: 'Visitantes veem o valor estimado',
              value: _showValue,
              onChanged: (v) => setState(() => _showValue = v)),
          const SizedBox(height: 10),
          _ToggleRow(
              label: 'Mostrar valor pago',
              subtitle: 'Visitantes veem quanto você pagou',
              value: _showPricePaid,
              onChanged: (v) => setState(() => _showPricePaid = v)),
          const SizedBox(height: 10),
          _ToggleRow(
              label: 'Disponível para troca',
              subtitle: 'Aparece como disponível na wishlist',
              value: _isForTrade,
              onChanged: (v) => setState(() => _isForTrade = v)),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2E2A22)),
          const SizedBox(height: 12),

          // ✅ NOTAS PRIVADAS EDITÁVEIS
          Row(
            children: [
              Text('NOTAS PRIVADAS',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: const Color(0xFF7A7060),
                      letterSpacing: 1.5)),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _editingNotes = !_editingNotes),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _editingNotes
                        ? const Color(0xFFD4622A)
                        : const Color(0xFF242018),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: _editingNotes
                            ? const Color(0xFFD4622A)
                            : const Color(0xFF3A3428)),
                  ),
                  child: Text(_editingNotes ? 'SALVAR' : 'EDITAR',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 11,
                          letterSpacing: 1,
                          color: _editingNotes
                              ? Colors.white
                              : const Color(0xFF7A7060))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _editingNotes
              // ✅ Modo edição inline
              ? TextField(
                  controller: _notesController,
                  maxLines: 4,
                  autofocus: true,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 13,
                      color: const Color(0xFFF0ECE4),
                      height: 1.5),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF0F0E0B),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD4622A))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF2E2A22))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD4622A))),
                    contentPadding: const EdgeInsets.all(12),
                    hintText: 'Onde comprou, história da peça, observações...',
                    hintStyle: GoogleFonts.familjenGrotesk(
                        fontSize: 13, color: const Color(0xFF4A4438)),
                  ),
                )
              // ✅ Modo leitura
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F0E0B),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF2E2A22)),
                  ),
                  child: _notesController.text.isEmpty
                      ? Text('Nenhuma nota. Toque em EDITAR para adicionar.',
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 13,
                              color: const Color(0xFF4A4438),
                              fontStyle: FontStyle.italic))
                      : Text(_notesController.text,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 13,
                              color: const Color(0xFF7A7060),
                              fontStyle: FontStyle.italic,
                              height: 1.5)),
                ),
        ],
      ),
    );
  }
}

// ── LIKER ROW ──
class _LikerRow extends StatefulWidget {
  final String username, emoji, garage;
  final bool isMe;
  final VoidCallback onTap;

  const _LikerRow(
      {required this.username,
      required this.emoji,
      required this.garage,
      required this.isMe,
      required this.onTap});

  @override
  State<_LikerRow> createState() => _LikerRowState();
}

class _LikerRowState extends State<_LikerRow> {
  bool _following = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF242018),
                  border:
                      Border.all(color: const Color(0xFFD4622A), width: 1.5)),
              child: Center(
                  child:
                      Text(widget.emoji, style: const TextStyle(fontSize: 20))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.username,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF0ECE4))),
                  Text(widget.garage,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11, color: const Color(0xFF7A7060))),
                ],
              ),
            ),
            if (!widget.isMe)
              GestureDetector(
                onTap: () => setState(() => _following = !_following),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
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
                          color: _following
                              ? const Color(0xFF7A7060)
                              : Colors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── COMMENT ROW ──
class _CommentRow extends StatelessWidget {
  final _Comment comment;
  final VoidCallback onTap;

  const _CommentRow({required this.comment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF242018),
                  border: Border.all(color: const Color(0xFF3A3428))),
              child: Center(
                  child: Text(comment.emoji,
                      style: const TextStyle(fontSize: 18))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(comment.username,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFF0ECE4))),
                      const SizedBox(width: 6),
                      Text(comment.time,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 10, color: const Color(0xFF7A7060))),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(comment.text,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 13, color: const Color(0xFFB0A898))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── INFO CARD ──
class _InfoCard extends StatelessWidget {
  final String label, value, icon;
  const _InfoCard(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: const Color(0xFF7A7060),
                  letterSpacing: 1)),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Expanded(
                  child: Text(value,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF0ECE4)),
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── TOGGLE ROW ──
class _ToggleRow extends StatelessWidget {
  final String label, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow(
      {required this.label,
      required this.subtitle,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF0ECE4))),
              Text(subtitle,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 11, color: const Color(0xFF7A7060))),
            ],
          ),
        ),
        Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFD4622A),
            activeTrackColor: const Color(0xFFD4622A).withOpacity(0.3),
            inactiveThumbColor: const Color(0xFF4A4438),
            inactiveTrackColor: const Color(0xFF2E2A22)),
      ],
    );
  }
}

// ── META TAG ──
class _MetaTag extends StatelessWidget {
  final String label, value;
  const _MetaTag({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: '$label: ',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 10, color: const Color(0xFF7A7060))),
            TextSpan(
                text: value,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: const Color(0xFFF0ECE4),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

// ── MODELOS ──
class _Comment {
  final String username, emoji, text, time;
  const _Comment(
      {required this.username,
      required this.emoji,
      required this.text,
      required this.time});
}

class _UserLike {
  final String username, emoji, garage;
  const _UserLike(
      {required this.username, required this.emoji, required this.garage});
}
