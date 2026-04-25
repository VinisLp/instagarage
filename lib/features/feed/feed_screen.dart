import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../piece/ai_scan_screen.dart';
import '../explore/explore_screen.dart';
import '../dm/dm_screen.dart';
import '../marketplace/marketplace_screen.dart';
import '../garage/garage_screen.dart';
import 'collection_screen.dart';

// ═══════════════════════════════════════════════════════════════════
// TELA DE PERFIL
// ═══════════════════════════════════════════════════════════════════
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
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
              Positioned(
                  top: 12,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 18)),
                  )),
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
                    Text(
                        'Colecionador apaixonado por raridades desde 2001. SP 🔥',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 13,
                            color: const Color(0xFFB0A898),
                            height: 1.5)),
                    const SizedBox(height: 16),
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

// ═══════════════════════════════════════════════════════════════════
// STORY DIALOG — centro da tela, navegação entre stories, emojis
// ═══════════════════════════════════════════════════════════════════
class _StoryDialog extends StatefulWidget {
  final int initialIndex;
  const _StoryDialog({required this.initialIndex});
  @override
  State<_StoryDialog> createState() => _StoryDialogState();
}

class _StoryDialogState extends State<_StoryDialog>
    with SingleTickerProviderStateMixin {
  late int _storyIndex; // qual story (pessoa)
  int _photoIndex = 0; // qual foto dentro do story
  bool _paused = false;
  final _replyController = TextEditingController();
  bool _showEmojis = false;
  late AnimationController _progressCtrl;

  static const _emojis = [
    '❤️',
    '🔥',
    '😍',
    '👏',
    '💎',
    '🏆',
    '😂',
    '😮',
    '🙌',
    '💯',
    '🎯',
    '⚡'
  ];

  // Cada story tem N fotos
  static const _storyPhotos = [
    ['🏎️', '🏆', '🔥'], // rafael — 3 fotos
    ['🎸', '🎵', '🎶'], // vinyl_br — 3 fotos
    ['🦸', '🦸‍♂️', '🦸‍♀️'], // marvels — 3 fotos
    ['🚂', '🚃', '🚄'], // trains — 3 fotos
    ['📮', '✉️', '📬'], // stamps — 3 fotos
  ];

  @override
  void initState() {
    super.initState();
    _storyIndex = widget.initialIndex;
    _progressCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..forward();
    _progressCtrl.addStatusListener((s) {
      if (s == AnimationStatus.completed) _nextPhoto();
    });
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    _replyController.dispose();
    super.dispose();
  }

  List<String> get _currentPhotos =>
      _storyPhotos[_storyIndex.clamp(0, _storyPhotos.length - 1)];

  void _nextPhoto() {
    if (_photoIndex < _currentPhotos.length - 1) {
      setState(() => _photoIndex++);
      _progressCtrl.forward(from: 0);
    } else {
      // última foto: fecha o dialog
      Navigator.pop(context);
    }
  }

  void _prevPhoto() {
    if (_photoIndex > 0) {
      setState(() => _photoIndex--);
      _progressCtrl.forward(from: 0);
    }
  }

  void _pause() {
    setState(() => _paused = true);
    _progressCtrl.stop();
  }

  void _resume() {
    setState(() => _paused = false);
    _progressCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    final story = _stories[_storyIndex.clamp(0, _stories.length - 1)];
    final photos = _currentPhotos;
    final currentEmoji = photos[_photoIndex];
    final size = MediaQuery.of(context).size;
    final w = (size.width * 0.85).clamp(300.0, 480.0);
    final h = (size.height * 0.82).clamp(500.0, 820.0);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
              color: const Color(0xFF1A1814),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF2E2A22))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(children: [
              // ── Barras de progresso — uma por FOTO do story atual ──
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Row(
                  children: List.generate(
                      photos.length,
                      (i) => Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              height: 3,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF3A3428),
                                  borderRadius: BorderRadius.circular(2)),
                              child: i < _photoIndex
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFD4622A),
                                          borderRadius:
                                              BorderRadius.circular(2)))
                                  : i == _photoIndex
                                      ? AnimatedBuilder(
                                          animation: _progressCtrl,
                                          builder: (_, __) =>
                                              FractionallySizedBox(
                                                widthFactor:
                                                    _progressCtrl.value,
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFD4622A),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2))),
                                              ))
                                      : const SizedBox(),
                            ),
                          )),
                ),
              ),

              // ── Header ──
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                child: Row(children: [
                  Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF242018),
                          border: Border.all(
                              color: const Color(0xFFD4622A), width: 1.5)),
                      child: Center(
                          child: Text(story.emoji,
                              style: const TextStyle(fontSize: 18)))),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(story.name,
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFF0ECE4))),
                        Text('agora · foto ${_photoIndex + 1}/${photos.length}',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 10, color: const Color(0xFF7A7060))),
                      ])),
                  if (_paused)
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: const Color(0xFFD4A020).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                      child: Text('PAUSADO',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 8,
                              color: const Color(0xFFD4A020),
                              letterSpacing: 0.5)),
                    ),
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close_rounded,
                          color: Color(0xFF7A7060), size: 22)),
                ]),
              ),

              // ── Conteúdo — segurar para pausar, setas para fotos ──
              Expanded(
                  child: GestureDetector(
                onLongPressStart: (_) => _pause(),
                onLongPressEnd: (_) => _resume(),
                child: Stack(children: [
                  // Foto atual
                  Positioned.fill(
                      child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xFF242018),
                        borderRadius: BorderRadius.circular(14)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(currentEmoji,
                              style: const TextStyle(fontSize: 90)),
                          const SizedBox(height: 16),
                          Text('Nova peça na coleção! 🔥',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 20,
                                  color: const Color(0xFFF0ECE4),
                                  letterSpacing: 1)),
                          const SizedBox(height: 6),
                          Text('@${story.name}',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 12,
                                  color: const Color(0xFF7A7060))),
                          if (_paused) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.pause_rounded,
                                        color: Colors.white, size: 16),
                                    const SizedBox(width: 6),
                                    Text('Segurando...',
                                        style: GoogleFonts.familjenGrotesk(
                                            fontSize: 12, color: Colors.white)),
                                  ]),
                            ),
                          ],
                        ]),
                  )),

                  // Seta esquerda — foto anterior
                  if (_photoIndex > 0)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: _prevPhoto,
                        child: Container(
                          width: 56,
                          alignment: Alignment.center,
                          child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.45),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.chevron_left_rounded,
                                  color: Colors.white, size: 22)),
                        ),
                      ),
                    ),

                  // Seta direita — próxima foto
                  if (_photoIndex < photos.length - 1)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: _nextPhoto,
                        child: Container(
                          width: 56,
                          alignment: Alignment.center,
                          child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.45),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.chevron_right_rounded,
                                  color: Colors.white, size: 22)),
                        ),
                      ),
                    ),
                ]),
              )),

              // ── Emojis rápidos ──
              if (_showEmojis)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: const BoxDecoration(
                      border:
                          Border(top: BorderSide(color: Color(0xFF2E2A22)))),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: _emojis
                        .map((e) => GestureDetector(
                              onTap: () {
                                _replyController.text += e;
                                _replyController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _replyController.text.length));
                                setState(() {});
                              },
                              child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF242018),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                      child: Text(e,
                                          style:
                                              const TextStyle(fontSize: 18)))),
                            ))
                        .toList(),
                  ),
                ),

              // ── Input de resposta ──
              Container(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFF2E2A22)))),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => setState(() => _showEmojis = !_showEmojis),
                    child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            color: const Color(0xFF242018),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: _showEmojis
                                    ? const Color(0xFFD4622A)
                                    : const Color(0xFF3A3428))),
                        child: Center(
                            child: Text(_showEmojis ? '✕' : '😊',
                                style: TextStyle(
                                    fontSize: _showEmojis ? 15 : 20)))),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: TextField(
                    controller: _replyController,
                    style: GoogleFonts.familjenGrotesk(
                        color: const Color(0xFFF0ECE4), fontSize: 13),
                    decoration: InputDecoration(
                        hintText: 'Responder a ${story.name}...',
                        hintStyle: GoogleFonts.familjenGrotesk(
                            color: const Color(0xFF4A4438), fontSize: 13),
                        filled: true,
                        fillColor: const Color(0xFF242018),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8)),
                    onChanged: (_) => setState(() {}),
                  )),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      if (_replyController.text.trim().isNotEmpty) {
                        _replyController.clear();
                        setState(() => _showEmojis = false);
                        Navigator.pop(context);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: _replyController.text.trim().isNotEmpty
                              ? const Color(0xFFD4622A)
                              : const Color(0xFF2E2A22),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.send_rounded,
                          color: Colors.white, size: 17),
                    ),
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

// ═══════════════════════════════════════════════════════════════════
// FEED SCREEN PRINCIPAL
// ═══════════════════════════════════════════════════════════════════
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late List<_Notification> _generalNotifications;
  late List<_Notification> _personalNotifications;

  // ← controla AMBAS as sidebars
  bool _sidebarExpanded = true;

  bool _storiesVisible = true;
  final ScrollController _feedScrollController = ScrollController();
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _feedScrollController.addListener(_onFeedScroll);
    _generalNotifications = [
      _Notification(
          emoji: '❤️',
          text: 'vinyl_br curtiu sua peça "Led Zeppelin IV"',
          time: '2min',
          read: false,
          type: 'like',
          user: 'vinyl_br',
          userEmoji: '🎸',
          postIndex: 0),
      _Notification(
          emoji: '💬',
          text: 'pokemon_rafael comentou: "Incrível! Quanto você pagou?"',
          time: '15min',
          read: false,
          type: 'comment',
          user: 'pokemon_rafael',
          userEmoji: '🐲',
          postIndex: 1),
      _Notification(
          emoji: '👤',
          text: 'hq_collector começou a seguir você',
          time: '1h',
          read: false,
          type: 'follow',
          user: 'hq_collector',
          userEmoji: '🦸',
          postIndex: null),
      _Notification(
          emoji: '🎸',
          text: 'vinyl_br publicou uma nova peça',
          time: '2h',
          read: true,
          type: 'post',
          user: 'vinyl_br',
          userEmoji: '🎸',
          postIndex: 0),
      _Notification(
          emoji: '❤️',
          text: 'trains_sp curtiu seu post',
          time: '5h',
          read: true,
          type: 'like',
          user: 'trains_sp',
          userEmoji: '🚂',
          postIndex: 2),
    ];
    _personalNotifications = [
      _Notification(
          emoji: '🔄',
          text: 'hq_collector quer trocar seu Charizard',
          time: '5min',
          read: false,
          type: 'trade',
          user: 'hq_collector',
          userEmoji: '🦸',
          postIndex: null),
      _Notification(
          emoji: '🛒',
          text: 'magic_sp quer comprar "Led Zeppelin IV" por R\$ 1.200',
          time: '30min',
          read: false,
          type: 'buy',
          user: 'magic_sp',
          userEmoji: '🎴',
          postIndex: null),
      _Notification(
          emoji: '🔨',
          text: 'Novo lance R\$ 3.400 no leilão "Camisa Brasil 1970"',
          time: '1h',
          read: false,
          type: 'auction',
          user: 'shirts_br',
          userEmoji: '👕',
          postIndex: null),
      _Notification(
          emoji: '💬',
          text: 'Nova mensagem de vinyl_br',
          time: '2h',
          read: true,
          type: 'message',
          user: 'vinyl_br',
          userEmoji: '🎸',
          postIndex: null),
      _Notification(
          emoji: '✅',
          text: 'Sua peça "Ferrari 250 GTO" foi vendida!',
          time: '1d',
          read: true,
          type: 'sold',
          user: 'cars_col',
          userEmoji: '🚗',
          postIndex: null),
    ];
  }

  void _onFeedScroll() {
    final offset = _feedScrollController.offset;
    final down = offset > _lastScrollOffset;
    if (down && _storiesVisible && offset > 80)
      setState(() => _storiesVisible = false);
    else if (!down && !_storiesVisible && offset < 40)
      setState(() => _storiesVisible = true);
    _lastScrollOffset = offset;
  }

  @override
  void dispose() {
    _feedScrollController.removeListener(_onFeedScroll);
    _feedScrollController.dispose();
    super.dispose();
  }

  void _markAllGeneralAsRead() => setState(() => _generalNotifications.clear());
  void _markAllPersonalAsRead() =>
      setState(() => _personalNotifications.clear());
  void _deleteGeneralNotification(_Notification n) =>
      setState(() => _generalNotifications.remove(n));
  void _deletePersonalNotification(_Notification n) =>
      setState(() => _personalNotifications.remove(n));

  void _showTopToast(String message, {VoidCallback? onUndo}) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
        builder: (context) => Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFF242018),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF3A3428)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4))
                      ]),
                  child: Row(children: [
                    const Icon(Icons.check_circle_rounded,
                        color: Color(0xFF4CAF7A), size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(message,
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 13, color: const Color(0xFFF0ECE4)))),
                    if (onUndo != null)
                      GestureDetector(
                        onTap: () {
                          onUndo();
                          entry.remove();
                        },
                        child: Text('DESFAZER',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 13,
                                letterSpacing: 1,
                                color: const Color(0xFFD4622A))),
                      ),
                  ]),
                ),
              ),
            ));
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), () {
      if (entry.mounted) entry.remove();
    });
  }

  Color _notifColor(String type) {
    switch (type) {
      case 'like':
        return const Color(0xFFD4622A);
      case 'comment':
        return const Color(0xFF4A8FD4);
      case 'post':
        return const Color(0xFF4CAF7A);
      default:
        return const Color(0xFFD4622A);
    }
  }

  String _notifLabel(String type) {
    switch (type) {
      case 'like':
        return '❤️ CURTIU';
      case 'comment':
        return '💬 COMENTOU';
      case 'post':
        return '📸 PUBLICOU';
      default:
        return '🔔 NOTIF';
    }
  }

  void _openPostSheet(BuildContext ctx, _Notification n) {
    final post = n.postIndex != null && n.postIndex! < _posts.length
        ? _posts[n.postIndex!]
        : _posts[0];
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F0E0B),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, sc) => SingleChildScrollView(
            controller: sc,
            child: Column(children: [
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
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF242018),
                            border: Border.all(
                                color: const Color(0xFFD4622A), width: 1.5)),
                        child: Center(
                            child: Text(n.userEmoji,
                                style: const TextStyle(fontSize: 20)))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(n.user,
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFF0ECE4))),
                          Text(post.garage,
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 10,
                                  color: const Color(0xFF7A7060))),
                        ])),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: _notifColor(n.type).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: _notifColor(n.type).withOpacity(0.4))),
                        child: Text(_notifLabel(n.type),
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 9,
                                color: _notifColor(n.type),
                                letterSpacing: 0.5))),
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.close_rounded,
                                color: Color(0xFF7A7060), size: 22))),
                  ])),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFF2E2A22), height: 1),
              Container(
                  width: double.infinity,
                  height: 300,
                  color: post.bgColor,
                  child: Center(
                      child: Text(post.emoji,
                          style: const TextStyle(fontSize: 80)))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                  child: Row(children: [
                    const Icon(Icons.favorite_border,
                        color: Color(0xFF7A7060), size: 26),
                    const SizedBox(width: 16),
                    const Icon(Icons.chat_bubble_outline,
                        color: Color(0xFF7A7060), size: 24),
                    const SizedBox(width: 16),
                    const Icon(Icons.share_outlined,
                        color: Color(0xFF7A7060), size: 24),
                  ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 20),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${post.username} ',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF0ECE4))),
                    TextSpan(
                        text: post.caption,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12, color: const Color(0xFFB0A898))),
                  ]))),
            ])),
      ),
    );
  }

  void _handleGeneralNotificationTap(BuildContext ctx, _Notification n) {
    setState(() => n.read = true);
    Navigator.pop(ctx);
    switch (n.type) {
      case 'like':
      case 'comment':
      case 'post':
        _openPostSheet(context, n);
        break;
      case 'follow':
        _openUserProfile(n.user, n.userEmoji);
        break;
    }
  }

  void _handlePersonalNotificationTap(BuildContext ctx, _Notification n) {
    setState(() => n.read = true);
    Navigator.pop(ctx);
    switch (n.type) {
      case 'trade':
      case 'buy':
      case 'message':
      case 'sold':
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const DmScreen()));
        break;
      case 'auction':
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MarketplaceScreen()));
        break;
      case 'wishlist':
        _openUserProfile(n.user, n.userEmoji);
        break;
    }
  }

  void _openUserProfile(String user, String emoji) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, sc) => SingleChildScrollView(
            controller: sc,
            child: Column(children: [
              Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFF3A3428),
                      borderRadius: BorderRadius.circular(2))),
              Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF1a0800), Color(0xFF3a1800)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: Center(
                      child:
                          Text(emoji, style: const TextStyle(fontSize: 48)))),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Row(children: [
                      Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF242018),
                              border: Border.all(
                                  color: const Color(0xFF1A1814), width: 3)),
                          child: Center(
                              child: Text(emoji,
                                  style: const TextStyle(fontSize: 30)))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(user,
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: const Color(0xFFF0ECE4),
                                    letterSpacing: 1)),
                            Text('@$user',
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 12,
                                    color: const Color(0xFF7A7060))),
                          ])),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: const Color(0xFFD4622A),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text('SEGUIR',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                  color: Colors.white))),
                    ]),
                    const SizedBox(height: 16),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            color: const Color(0xFF242018),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF2E2A22))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _ProfileStat(value: '47', label: 'PEÇAS'),
                              Container(
                                  width: 1,
                                  height: 28,
                                  color: const Color(0xFF2E2A22)),
                              _ProfileStat(value: '384', label: 'SEGUIDORES'),
                              Container(
                                  width: 1,
                                  height: 28,
                                  color: const Color(0xFF2E2A22)),
                              _ProfileStat(value: 'R\$ 12k', label: 'VALOR'),
                            ])),
                    const SizedBox(height: 12),
                    Text('Colecionador apaixonado por raridades 🔥',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 13, color: const Color(0xFF7A7060))),
                    const SizedBox(height: 16),
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
                        children: [emoji, emoji, emoji, emoji, emoji, emoji]
                            .map((e) => Container(
                                color: const Color(0xFF242018),
                                child: Center(
                                    child: Text(e,
                                        style: const TextStyle(fontSize: 28)))))
                            .toList()),
                  ])),
            ])),
      ),
    );
  }

  void _openGeneralNotifications() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
          builder: (ctx, setSheetState) => DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.4,
                maxChildSize: 0.95,
                expand: false,
                builder: (ctx, sc) => Column(children: [
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
                        Text('NOTIFICAÇÕES',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                color: const Color(0xFFF0ECE4),
                                letterSpacing: 2)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            final removed =
                                List<_Notification>.from(_generalNotifications);
                            _markAllGeneralAsRead();
                            setSheetState(() {});
                            _showTopToast('Notificações limpas', onUndo: () {
                              setState(
                                  () => _generalNotifications.addAll(removed));
                              setSheetState(() {});
                            });
                          },
                          child: Text('LIMPAR TUDO',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 8,
                                  color: const Color(0xFFD4622A),
                                  letterSpacing: 0.5)),
                        ),
                      ])),
                  const SizedBox(height: 8),
                  const Divider(color: Color(0xFF2E2A22)),
                  Expanded(
                      child: _generalNotifications.isEmpty
                          ? Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  const Text('🔔',
                                      style: TextStyle(fontSize: 40)),
                                  const SizedBox(height: 12),
                                  Text('NENHUMA NOTIFICAÇÃO',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 16,
                                          color: const Color(0xFF4A4438),
                                          letterSpacing: 2)),
                                ]))
                          : ListView.builder(
                              controller: sc,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _generalNotifications.length,
                              itemBuilder: (context, index) =>
                                  _NotificationTile(
                                    notification: _generalNotifications[index],
                                    onTap: () {
                                      setSheetState(() {});
                                      _handleGeneralNotificationTap(
                                          ctx, _generalNotifications[index]);
                                    },
                                    onDelete: () {
                                      final removed =
                                          _generalNotifications[index];
                                      _deleteGeneralNotification(removed);
                                      setSheetState(() {});
                                      _showTopToast('Notificação removida',
                                          onUndo: () {
                                        setState(() => _generalNotifications
                                            .insert(index, removed));
                                        setSheetState(() {});
                                      });
                                    },
                                  ))),
                ]),
              )),
    );
  }

  void _openPersonalNotifications() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
          builder: (ctx, setSheetState) => DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.4,
                maxChildSize: 0.95,
                expand: false,
                builder: (ctx, sc) => Column(children: [
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
                        Text('MINHA ATIVIDADE',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                color: const Color(0xFFF0ECE4),
                                letterSpacing: 2)),
                        const SizedBox(width: 8),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                                color: const Color(0xFFD4622A),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                                '${_personalNotifications.where((n) => !n.read).length}',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700))),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            final removed = List<_Notification>.from(
                                _personalNotifications);
                            _markAllPersonalAsRead();
                            setSheetState(() {});
                            _showTopToast('Atividades limpas', onUndo: () {
                              setState(
                                  () => _personalNotifications.addAll(removed));
                              setSheetState(() {});
                            });
                          },
                          child: Text('LIMPAR TUDO',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 8,
                                  color: const Color(0xFFD4622A),
                                  letterSpacing: 0.5)),
                        ),
                      ])),
                  const SizedBox(height: 8),
                  const Divider(color: Color(0xFF2E2A22)),
                  Expanded(
                      child: _personalNotifications.isEmpty
                          ? Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  const Text('👤',
                                      style: TextStyle(fontSize: 40)),
                                  const SizedBox(height: 12),
                                  Text('NENHUMA ATIVIDADE',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 16,
                                          color: const Color(0xFF4A4438),
                                          letterSpacing: 2)),
                                ]))
                          : ListView.builder(
                              controller: sc,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _personalNotifications.length,
                              itemBuilder: (context, index) => Dismissible(
                                    key:
                                        Key(_personalNotifications[index].text),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (_) {
                                      final removed =
                                          _personalNotifications[index];
                                      _deletePersonalNotification(removed);
                                      setSheetState(() {});
                                      _showTopToast('Removido', onUndo: () {
                                        setState(() => _personalNotifications
                                            .insert(index, removed));
                                        setSheetState(() {});
                                      });
                                    },
                                    background: Container(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        color: const Color(0xFFD44A4A)
                                            .withOpacity(0.15),
                                        child: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: Color(0xFFD44A4A),
                                            size: 24)),
                                    child: _NotificationTile(
                                      notification:
                                          _personalNotifications[index],
                                      onTap: () {
                                        setSheetState(() {});
                                        _handlePersonalNotificationTap(
                                            ctx, _personalNotifications[index]);
                                      },
                                      onDelete: () {
                                        _deletePersonalNotification(
                                            _personalNotifications[index]);
                                        setSheetState(() {});
                                      },
                                    ),
                                  ))),
                ]),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final generalUnread = _generalNotifications.where((n) => !n.read).length;
    final personalUnread = _personalNotifications.where((n) => !n.read).length;
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return isDesktop
        ? _buildDesktopLayout(generalUnread, personalUnread)
        : _buildMobileLayout(generalUnread, personalUnread);
  }

  // ═══════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT — 3 COLUNAS EM CARDS ARREDONDADOS
  // ═══════════════════════════════════════════════════════════════════
  Widget _buildDesktopLayout(int generalUnread, int personalUnread) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── COLUNA 1 — SIDEBAR ESQUERDA FIXA (sem toggle) ──
            SizedBox(
              width: 240,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF1A1814),
                      borderRadius: BorderRadius.circular(16)),
                  child: _DesktopLeftSidebar(
                    generalUnread: generalUnread,
                    personalUnread: personalUnread,
                    onGeneralNotif: _openGeneralNotifications,
                    onPersonalNotif: _openPersonalNotifications,
                    onNavigate: (index) {
                      if (index == 1)
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ExploreScreen()));
                      else if (index == 2)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AiScanScreen()));
                      else if (index == 3)
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const DmScreen()));
                      else if (index == 4)
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MarketplaceScreen()));
                      else if (index == 5)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const GarageScreen()));
                      else if (index == 6)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CollectionScreen()));
                      else if (index == 7)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileScreen()));
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // ── COLUNA 2 — FEED CENTRAL com botão toggle na borda direita ──
            Expanded(
              child: Stack(clipBehavior: Clip.none, children: [
                // Card do feed
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(children: [
                      // Stories — fade + colapso suave ao rolar
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 380),
                        curve: Curves.easeInOut,
                        opacity: _storiesVisible ? 1.0 : 0.0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 420),
                          curve: Curves.easeInOut,
                          height: _storiesVisible ? 110 : 0,
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xFF2E2A22)))),
                            child: SizedBox(
                                height: 110,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  itemCount: _stories.length,
                                  itemBuilder: (context, index) => _StoryItem(
                                      story: _stories[index], isDesktop: true),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                          child: CustomScrollView(
                        controller: _feedScrollController,
                        slivers: [
                          const SliverToBoxAdapter(child: SizedBox(height: 8)),
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (context, index) => _PostCard(
                                      post: _posts[index], isDesktop: true),
                                  childCount: _posts.length)),
                          const SliverToBoxAdapter(child: SizedBox(height: 16)),
                        ],
                      )),
                    ]),
                  ),
                ),

                // ── Botão toggle: flutua na borda DIREITA do feed, sempre visível ──
                Positioned(
                  right: -14,
                  top: 24,
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _sidebarExpanded = !_sidebarExpanded),
                    child: Container(
                      width: 26,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF242018),
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(10)),
                        border: Border.all(color: const Color(0xFF2E2A22)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: 8)
                        ],
                      ),
                      child: Icon(
                        _sidebarExpanded
                            ? Icons.chevron_right_rounded
                            : Icons.chevron_left_rounded,
                        color: const Color(0xFF7A7060),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ]),
            ),

            const SizedBox(width: 8),

            // ── COLUNA 3 — SIDEBAR DIREITA (colapsável) ──
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              width: _sidebarExpanded ? 296 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: _sidebarExpanded ? 1.0 : 0.0,
                child: _sidebarExpanded
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF1A1814),
                              borderRadius: BorderRadius.circular(16)),
                          child: _DesktopRightSidebar(
                            onCollectionTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CollectionScreen())),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(int generalUnread, int personalUnread) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('FEED',
                style: GoogleFonts.bebasNeue(
                    fontSize: 26,
                    color: const Color(0xFFD4622A),
                    letterSpacing: 3)),
            Row(children: [
              _NotifButton(
                  icon: Icons.notifications_none_rounded,
                  count: generalUnread,
                  onTap: _openGeneralNotifications),
              const SizedBox(width: 8),
              _NotifButton(
                  icon: Icons.person_outline_rounded,
                  count: personalUnread,
                  onTap: _openPersonalNotifications),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen())),
                child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: const Color(0xFF242018),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFD4622A), width: 2)),
                    child: const Center(
                        child: Text('🏎️', style: TextStyle(fontSize: 17)))),
              ),
            ]),
          ]),
        ),
        SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              itemCount: _stories.length,
              itemBuilder: (context, index) =>
                  _StoryItem(story: _stories[index], isDesktop: false),
            )),
        const Divider(color: Color(0xFF2E2A22), height: 1),
        Expanded(
            child: CustomScrollView(slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _PostCard(post: _posts[index], isDesktop: false),
                  childCount: _posts.length)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ])),
      ])),
      bottomNavigationBar: _BottomNav(
          currentIndex: 0,
          onTap: (index) {
            if (index == 1)
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const ExploreScreen()));
            else if (index == 2)
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AiScanScreen()));
            else if (index == 3)
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const DmScreen()));
            else if (index == 4)
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MarketplaceScreen()));
          }),
    );
  }
}

// ═══════════════════════════════════════════════
// SIDEBAR ESQUERDA FIXA (sem toggle)
// ═══════════════════════════════════════════════
class _DesktopLeftSidebar extends StatelessWidget {
  final int generalUnread, personalUnread;
  final VoidCallback onGeneralNotif, onPersonalNotif;
  final Function(int) onNavigate;

  const _DesktopLeftSidebar({
    required this.generalUnread,
    required this.personalUnread,
    required this.onGeneralNotif,
    required this.onPersonalNotif,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Logo (sem botão toggle)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
          child: Text('INSTACOLLECTION',
              style: GoogleFonts.bebasNeue(
                  fontSize: 15,
                  color: const Color(0xFFD4622A),
                  letterSpacing: 2)),
        ),
        _SideNavItem(
            icon: Icons.home_rounded,
            label: 'FEED',
            active: true,
            onTap: () {}),
        _SideNavItem(
            icon: Icons.search_rounded,
            label: 'EXPLORAR',
            active: false,
            onTap: () => onNavigate(1)),
        _SideNavItem(
            icon: Icons.chat_bubble_rounded,
            label: 'DMs',
            active: false,
            onTap: () => onNavigate(3)),
        _SideNavItem(
            icon: Icons.storefront_rounded,
            label: 'MARKET',
            active: false,
            onTap: () => onNavigate(4)),
        _SideNavItem(
            icon: Icons.person_rounded,
            label: 'PERFIL',
            active: false,
            onTap: () => onNavigate(5)),
        _SideNavItem(
            icon: Icons.collections_bookmark_rounded,
            label: 'COLEÇÃO',
            active: false,
            onTap: () => onNavigate(6)),
        const SizedBox(height: 4),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Divider(color: Color(0xFF2E2A22), height: 16)),
        const SizedBox(height: 4),
        _SideNavItem(
            icon: Icons.notifications_none_rounded,
            label: 'NOTIFICAÇÕES',
            active: false,
            badge: generalUnread,
            onTap: onGeneralNotif),
        _SideNavItem(
            icon: Icons.person_outline_rounded,
            label: 'ATIVIDADE',
            active: false,
            badge: personalUnread,
            onTap: onPersonalNotif),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GestureDetector(
            onTap: () => onNavigate(2),
            child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFFD4622A),
                    borderRadius: BorderRadius.circular(12)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.add, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Text('NOVA PEÇA',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 14,
                          letterSpacing: 1.5,
                          color: Colors.white)),
                ])),
          ),
        ),
        GestureDetector(
          onTap: () => onNavigate(7),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: Row(children: [
              Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                      color: const Color(0xFF242018),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFFD4622A), width: 1.5)),
                  child: const Center(
                      child: Text('🏎️', style: TextStyle(fontSize: 15)))),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('rafael',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF0ECE4))),
                    Text('@rafael_col',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 10, color: const Color(0xFF7A7060))),
                  ])),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF4A4438), size: 12),
            ]),
          ),
        ),
      ])),
    );
  }
}

class _SideNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final int badge;
  final VoidCallback onTap;
  const _SideNavItem(
      {required this.icon,
      required this.label,
      required this.active,
      required this.onTap,
      this.badge = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            color: active
                ? const Color(0xFFD4622A).withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Icon(icon,
              color: active ? const Color(0xFFD4622A) : const Color(0xFF7A7060),
              size: 20),
          const SizedBox(width: 12),
          Expanded(
              child: Text(label,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 13,
                      letterSpacing: 1,
                      color: active
                          ? const Color(0xFFD4622A)
                          : const Color(0xFFB0A898)))),
          if (badge > 0)
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color(0xFFD4622A),
                    borderRadius: BorderRadius.circular(10)),
                child: Text('$badge',
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.w700))),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// SIDEBAR DIREITA
// ═══════════════════════════════════════════════
class _DesktopRightSidebar extends StatelessWidget {
  final VoidCallback onCollectionTap;
  const _DesktopRightSidebar({required this.onCollectionTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: double.infinity,
      child: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 8),
          Text('SUGERIDOS PARA VOCÊ',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: const Color(0xFF7A7060),
                  letterSpacing: 1.5)),
          const SizedBox(height: 12),
          ..._suggestedUsers.map((u) => _SuggestedUserTile(user: u)),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFF2E2A22)),
          const SizedBox(height: 16),
          Text('TRENDING HOJE',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: const Color(0xFF7A7060),
                  letterSpacing: 1.5)),
          const SizedBox(height: 12),
          ..._trendingCategories
              .asMap()
              .entries
              .map((e) => _TrendingTile(rank: e.key + 1, category: e.value)),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFF2E2A22)),
          const SizedBox(height: 16),
          Text('MINHA COLEÇÃO',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: const Color(0xFF7A7060),
                  letterSpacing: 1.5)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onCollectionTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color(0xFF242018),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFFD4622A).withOpacity(0.3))),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('VALOR TOTAL',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 9,
                              color: const Color(0xFF7A7060),
                              letterSpacing: 1)),
                      Row(children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color:
                                    const Color(0xFF4CAF7A).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6)),
                            child: Text('▲ 12%',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 9,
                                    color: const Color(0xFF4CAF7A)))),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFD4622A), size: 11),
                      ]),
                    ]),
                const SizedBox(height: 6),
                Text('R\$ 48.200',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 26,
                        color: const Color(0xFFF0ECE4),
                        letterSpacing: 1)),
                const SizedBox(height: 14),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _MiniCollStat(value: '127', label: 'PEÇAS', icon: '📦'),
                      _MiniCollStat(
                          value: '6', label: 'CATEGORIAS', icon: '🗂️'),
                      _MiniCollStat(value: '8', label: 'À VENDA', icon: '🏪'),
                    ]),
                const SizedBox(height: 14),
                const Divider(color: Color(0xFF2E2A22)),
                const SizedBox(height: 12),
                _CollSummaryRow(
                    emoji: '🐲', nome: 'Pokémon TCG', qtd: 34, pct: 0.27),
                const SizedBox(height: 6),
                _CollSummaryRow(
                    emoji: '🎸', nome: 'Vinil & Records', qtd: 28, pct: 0.22),
                const SizedBox(height: 6),
                _CollSummaryRow(
                    emoji: '🦸', nome: 'HQs & Comics', qtd: 22, pct: 0.17),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('+ 3 categorias',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 9,
                          color: const Color(0xFFD4622A),
                          letterSpacing: 0.5)),
                ]),
              ]),
            ),
          ),
          const SizedBox(height: 20),
        ]),
      )),
    );
  }
}

class _MiniCollStat extends StatelessWidget {
  final String value, label, icon;
  const _MiniCollStat(
      {required this.value, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(icon, style: const TextStyle(fontSize: 14)),
      const SizedBox(height: 4),
      Text(value,
          style: GoogleFonts.bebasNeue(
              fontSize: 16,
              color: const Color(0xFFD4622A),
              letterSpacing: 0.5)),
      Text(label,
          style: GoogleFonts.jetBrainsMono(
              fontSize: 7, color: const Color(0xFF7A7060), letterSpacing: 0.5)),
    ]);
  }
}

class _CollSummaryRow extends StatelessWidget {
  final String emoji, nome;
  final int qtd;
  final double pct;
  const _CollSummaryRow(
      {required this.emoji,
      required this.nome,
      required this.qtd,
      required this.pct});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(emoji, style: const TextStyle(fontSize: 13)),
      const SizedBox(width: 8),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
              child: Text(nome,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 11, color: const Color(0xFFB0A898)))),
          Text('$qtd',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9, color: const Color(0xFF7A7060))),
        ]),
        const SizedBox(height: 3),
        ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
                value: pct,
                backgroundColor: const Color(0xFF2E2A22),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFFD4622A)),
                minHeight: 3)),
      ])),
    ]);
  }
}

class _SuggestedUserTile extends StatefulWidget {
  final _SuggestedUser user;
  const _SuggestedUserTile({required this.user});
  @override
  State<_SuggestedUserTile> createState() => _SuggestedUserTileState();
}

class _SuggestedUserTileState extends State<_SuggestedUserTile> {
  bool _following = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(children: [
          Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF242018),
                  border: Border.all(color: const Color(0xFF2E2A22))),
              child: Center(
                  child: Text(widget.user.emoji,
                      style: const TextStyle(fontSize: 18)))),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(widget.user.name,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0ECE4))),
                Text(widget.user.subtitle,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 10, color: const Color(0xFF7A7060))),
              ])),
          GestureDetector(
            onTap: () => setState(() => _following = !_following),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    color: _following
                        ? Colors.transparent
                        : const Color(0xFFD4622A),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: _following
                            ? const Color(0xFF4A4438)
                            : const Color(0xFFD4622A))),
                child: Text(_following ? 'SEGUINDO' : 'SEGUIR',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 11,
                        letterSpacing: 1,
                        color: _following
                            ? const Color(0xFF7A7060)
                            : Colors.white))),
          ),
        ]));
  }
}

class _TrendingTile extends StatelessWidget {
  final int rank;
  final _TrendingCategory category;
  const _TrendingTile({required this.rank, required this.category});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(children: [
          SizedBox(
              width: 20,
              child: Text('$rank',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      color: const Color(0xFF4A4438),
                      fontWeight: FontWeight.w700))),
          const SizedBox(width: 8),
          Text(category.emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(category.name,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0ECE4))),
                Text('${category.posts} posts hoje',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 10, color: const Color(0xFF7A7060))),
              ])),
        ]));
  }
}

// ── NOTIF BUTTON ──
class _NotifButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback onTap;
  const _NotifButton(
      {required this.icon, required this.count, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2E2A22))),
            child: Stack(clipBehavior: Clip.none, children: [
              Icon(icon, color: const Color(0xFFF0ECE4), size: 20),
              if (count > 0)
                Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                            color: Color(0xFFD4622A), shape: BoxShape.circle),
                        child: Center(
                            child: Text('$count',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700))))),
            ])));
  }
}

// ── PROFILE STAT ──
class _ProfileStat extends StatelessWidget {
  final String value, label;
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

// ── NOTIFICATION TILE ──
class _NotificationTile extends StatelessWidget {
  final _Notification notification;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  const _NotificationTile(
      {required this.notification, required this.onTap, this.onDelete});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF2E2A22))),
                color: Colors.transparent),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: const Color(0xFF242018),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: notification.read
                              ? const Color(0xFF2E2A22)
                              : const Color(0xFFD4622A),
                          width: 1.5)),
                  child: Center(
                      child: Text(notification.emoji,
                          style: const TextStyle(fontSize: 19)))),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(notification.text,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 13,
                            color: notification.read
                                ? const Color(0xFF7A7060)
                                : const Color(0xFFF0ECE4),
                            height: 1.4)),
                    const SizedBox(height: 4),
                    Text(notification.time,
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9, color: const Color(0xFF4A4438))),
                  ])),
              const SizedBox(width: 8),
              if (!notification.read)
                Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: const BoxDecoration(
                        color: Color(0xFFD4622A), shape: BoxShape.circle)),
              if (onDelete != null)
                GestureDetector(
                    onTap: onDelete,
                    child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD44A4A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:
                                    const Color(0xFFD44A4A).withOpacity(0.3))),
                        child: const Icon(Icons.close_rounded,
                            color: Color(0xFFD44A4A), size: 16))),
            ])));
  }
}

// ── STORY ITEM ──
class _StoryItem extends StatelessWidget {
  final _Story story;
  final bool isDesktop;
  const _StoryItem({required this.story, this.isDesktop = false});
  @override
  Widget build(BuildContext context) {
    final size = isDesktop ? 62.0 : 58.0;
    return GestureDetector(
      onTap: () {
        final idx = _stories.indexWhere((s) => s.name == story.name);
        showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(0.88),
          builder: (context) => _StoryDialog(initialIndex: idx < 0 ? 0 : idx),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 10 : 7),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: story.seen
                          ? [const Color(0xFF3A3428), const Color(0xFF3A3428)]
                          : [const Color(0xFFD4622A), const Color(0xFFD4A020)]),
                  border: Border.all(color: const Color(0xFF0F0E0B), width: 2)),
              child: Center(
                  child: Text(story.emoji,
                      style: TextStyle(fontSize: isDesktop ? 28.0 : 26.0)))),
          const SizedBox(height: 5),
          SizedBox(
              width: isDesktop ? 68.0 : 62.0,
              child: Text(story.name,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: isDesktop ? 10.0 : 9.0,
                      color: const Color(0xFF7A7060)),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis)),
        ]),
      ),
    );
  }
}

// ── POST CARD ──
class _PostCard extends StatefulWidget {
  final _Post post;
  final bool isDesktop;
  const _PostCard({required this.post, this.isDesktop = false});
  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> with TickerProviderStateMixin {
  bool _liked = false;
  final List<String> _comments = [];
  late AnimationController _heartController;
  late Animation<double> _heartScale;
  late AnimationController _commentController2;
  late Animation<double> _commentScale;
  late AnimationController _doubleTapController;
  late Animation<double> _doubleTapScale;
  late Animation<double> _doubleTapOpacity;
  bool _showDoubleTapHeart = false;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _heartScale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(
        CurvedAnimation(parent: _heartController, curve: Curves.easeInOut));
    _commentController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _commentScale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.1), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 30),
    ]).animate(
        CurvedAnimation(parent: _commentController2, curve: Curves.easeOut));
    _doubleTapController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _doubleTapScale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.3), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 30),
    ]).animate(
        CurvedAnimation(parent: _doubleTapController, curve: Curves.easeOut));
    _doubleTapOpacity = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_doubleTapController);
    _doubleTapController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        setState(() => _showDoubleTapHeart = false);
    });
  }

  @override
  void dispose() {
    _heartController.dispose();
    _commentController2.dispose();
    _doubleTapController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() => _liked = !_liked);
    _heartController.forward(from: 0);
    HapticFeedback.lightImpact();
  }

  void _onDoubleTap() {
    if (!_liked) {
      setState(() => _liked = true);
      _heartController.forward(from: 0);
      HapticFeedback.mediumImpact();
    }
    setState(() => _showDoubleTapHeart = true);
    _doubleTapController.forward(from: 0);
  }

  // ── LISTA DE QUEM CURTIU (dialog central) ──
  void _openLikersList() {
    final count = widget.post.likes + (_liked ? 1 : 0);
    final likers = [
      'vinyl_br 🎸',
      'pokemon_rafael 🐲',
      'hq_collector 🦸',
      'trains_sp 🚂',
      'magic_sp 🎴'
    ];
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 420,
            constraints: const BoxConstraints(maxHeight: 500),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF2E2A22))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 16, 0),
                    child: Row(children: [
                      Text('CURTIDAS',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: const Color(0xFFF0ECE4),
                              letterSpacing: 2)),
                      const SizedBox(width: 10),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                              color: const Color(0xFFD4622A).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text('$count',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10,
                                  color: const Color(0xFFD4622A),
                                  fontWeight: FontWeight.w700))),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: const Color(0xFF242018),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0xFF2E2A22))),
                            child: const Icon(Icons.close_rounded,
                                color: Color(0xFF7A7060), size: 16)),
                      ),
                    ])),
                const SizedBox(height: 14),
                const Divider(color: Color(0xFF2E2A22), height: 1),
                Flexible(
                    child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: likers.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(children: [
                      Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF242018),
                              border:
                                  Border.all(color: const Color(0xFF3A3428))),
                          child: Center(
                              child: Text(likers[i].split(' ').last,
                                  style: const TextStyle(fontSize: 19)))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(likers[i].split(' ').first,
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFF0ECE4))),
                            Text('@${likers[i].split(' ').first}',
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 10,
                                    color: const Color(0xFF7A7060))),
                          ])),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF2E2A22)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text('SEGUIR',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 11,
                                  letterSpacing: 1,
                                  color: const Color(0xFFB0A898)))),
                    ]),
                  ),
                )),
                const SizedBox(height: 8),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  // ── COMENTÁRIOS (dialog central) ──
  void _openComments() {
    _commentController2.forward(from: 0);
    final replyController = TextEditingController();
    bool showEmojis = false;
    final emojis = [
      '❤️',
      '🔥',
      '😍',
      '👏',
      '💎',
      '🏆',
      '🎯',
      '🐲',
      '🎸',
      '🦸',
      '🚗',
      '😮',
      '💯',
      '⚡',
      '🙌',
      '🤩'
    ];

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.72),
      builder: (context) => StatefulBuilder(
        builder: (context, setD) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 520,
              height: MediaQuery.of(context).size.height * 0.78,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: const Color(0xFF1A1814),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2E2A22))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(children: [
                  // ── Header (mesmo padrão do Compartilhar) ──
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 16, 0),
                    child: Row(children: [
                      Text('COMENTÁRIOS',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: const Color(0xFFF0ECE4),
                              letterSpacing: 2)),
                      const SizedBox(width: 10),
                      if (_comments.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                              color: const Color(0xFF4A8FD4).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text('${_comments.length}',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10,
                                  color: const Color(0xFF4A8FD4),
                                  fontWeight: FontWeight.w700)),
                        ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: const Color(0xFF242018),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0xFF2E2A22))),
                            child: const Icon(Icons.close_rounded,
                                color: Color(0xFF7A7060), size: 16),
                          )),
                    ]),
                  ),
                  const SizedBox(height: 14),
                  const Divider(color: Color(0xFF2E2A22), height: 1),

                  // ── Lista de comentários ──
                  Expanded(
                      child: _comments.isEmpty
                          ? Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  const Text('💬',
                                      style: TextStyle(fontSize: 42)),
                                  const SizedBox(height: 14),
                                  Text('Nenhum comentário ainda.',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 16,
                                          color: const Color(0xFF4A4438),
                                          letterSpacing: 1)),
                                  const SizedBox(height: 4),
                                  Text('Seja o primeiro a comentar!',
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 12,
                                          color: const Color(0xFF7A7060))),
                                ]))
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              itemCount: _comments.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 34,
                                          height: 34,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(0xFF242018),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFF2E2A22))),
                                          child: const Center(
                                              child: Text('👤',
                                                  style: TextStyle(
                                                      fontSize: 15)))),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Row(children: [
                                              Text('você',
                                                  style: GoogleFonts
                                                      .familjenGrotesk(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: const Color(
                                                              0xFFD4622A))),
                                              const SizedBox(width: 8),
                                              Text('agora',
                                                  style:
                                                      GoogleFonts.jetBrainsMono(
                                                          fontSize: 9,
                                                          color: const Color(
                                                              0xFF4A4438))),
                                            ]),
                                            const SizedBox(height: 4),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF242018),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Text(_comments[index],
                                                  style: GoogleFonts
                                                      .familjenGrotesk(
                                                          fontSize: 13,
                                                          color: const Color(
                                                              0xFFF0ECE4),
                                                          height: 1.4)),
                                            ),
                                          ])),
                                    ]),
                              ),
                            )),

                  // ── Emojis rápidos ──
                  if (showEmojis)
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFF2E2A22)))),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: emojis
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    replyController.text += e;
                                    replyController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset:
                                                replyController.text.length));
                                    setD(() {});
                                  },
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF242018),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: const Color(0xFF2E2A22))),
                                      child: Center(
                                          child: Text(e,
                                              style: const TextStyle(
                                                  fontSize: 20)))),
                                ))
                            .toList(),
                      ),
                    ),

                  // ── Input (mesmo padrão visual dos outros dialogs) ──
                  Container(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                    decoration: const BoxDecoration(
                        border:
                            Border(top: BorderSide(color: Color(0xFF2E2A22)))),
                    child: Row(children: [
                      // Botão emoji
                      GestureDetector(
                        onTap: () => setD(() => showEmojis = !showEmojis),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                              color: showEmojis
                                  ? const Color(0xFFD4622A).withOpacity(0.15)
                                  : const Color(0xFF242018),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: showEmojis
                                      ? const Color(0xFFD4622A).withOpacity(0.5)
                                      : const Color(0xFF3A3428))),
                          child: Center(
                              child: Text(showEmojis ? '✕' : '😊',
                                  style: TextStyle(
                                      fontSize: showEmojis ? 16 : 22))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Campo de texto
                      Expanded(
                          child: TextField(
                        controller: replyController,
                        autofocus: true,
                        maxLines: null,
                        style: GoogleFonts.familjenGrotesk(
                            color: const Color(0xFFF0ECE4), fontSize: 14),
                        decoration: InputDecoration(
                            hintText: 'Escreva um comentário...',
                            hintStyle: GoogleFonts.familjenGrotesk(
                                color: const Color(0xFF4A4438), fontSize: 14),
                            filled: true,
                            fillColor: const Color(0xFF242018),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 11)),
                        onChanged: (_) => setD(() {}),
                      )),
                      const SizedBox(width: 10),
                      // Botão enviar
                      GestureDetector(
                        onTap: () {
                          if (replyController.text.trim().isNotEmpty) {
                            setState(() =>
                                _comments.add(replyController.text.trim()));
                            setD(() {
                              replyController.clear();
                              showEmojis = false;
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                              color: replyController.text.trim().isNotEmpty
                                  ? const Color(0xFFD4622A)
                                  : const Color(0xFF242018),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: replyController.text.trim().isNotEmpty
                                      ? const Color(0xFFD4622A)
                                      : const Color(0xFF3A3428))),
                          child: Icon(Icons.send_rounded,
                              color: replyController.text.trim().isNotEmpty
                                  ? Colors.white
                                  : const Color(0xFF4A4438),
                              size: 18),
                        ),
                      ),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── OPÇÕES DO POST (bottom sheet mantido) ──
  void _openPostOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: const Color(0xFF3A3428),
                    borderRadius: BorderRadius.circular(2))),
            _OptionTile(
                icon: Icons.bookmark_border_rounded,
                label: 'Salvar post',
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Post salvo! 🔖',
                          style: GoogleFonts.familjenGrotesk(fontSize: 13)),
                      backgroundColor: const Color(0xFF4CAF7A),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))));
                }),
            _OptionTile(
                icon: Icons.person_off_outlined,
                label: 'Deixar de seguir @${widget.post.username}',
                onTap: () => Navigator.pop(context)),
            _OptionTile(
                icon: Icons.link_rounded,
                label: 'Copiar link do post',
                onTap: () {
                  Navigator.pop(context);
                  Clipboard.setData(const ClipboardData(
                      text: 'https://instacollection.app/post/123'));
                }),
            _OptionTile(
                icon: Icons.flag_outlined,
                label: 'Reportar post',
                color: const Color(0xFFD44A4A),
                onTap: () => Navigator.pop(context)),
            const SizedBox(height: 8),
          ])),
    );
  }

  // ── COMPARTILHAR (dialog central) ──
  void _openShare() {
    final text =
        'Veja essa peça no Instacollection: "${widget.post.caption}" por @${widget.post.username}';
    final encoded = Uri.encodeComponent(text);
    final link = 'https://instacollection.app/post/123';
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.72),
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 480,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF2E2A22))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 16, 0),
                    child: Row(children: [
                      Text('COMPARTILHAR',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: const Color(0xFFF0ECE4),
                              letterSpacing: 2)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: const Color(0xFF242018),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0xFF2E2A22))),
                            child: const Icon(Icons.close_rounded,
                                color: Color(0xFF7A7060), size: 16)),
                      ),
                    ])),
                const SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('"${widget.post.caption}"',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12,
                            color: const Color(0xFF7A7060),
                            fontStyle: FontStyle.italic))),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFF2E2A22), height: 1),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ShareOption(
                            emoji: '🟢',
                            label: 'WhatsApp',
                            onTap: () {
                              Navigator.pop(context);
                              launchUrl(
                                  Uri.parse('https://wa.me/?text=$encoded'));
                            }),
                        _ShareOption(
                            emoji: '✈️',
                            label: 'Telegram',
                            onTap: () {
                              Navigator.pop(context);
                              launchUrl(Uri.parse(
                                  'https://t.me/share/url?url=$link&text=$encoded'));
                            }),
                        _ShareOption(
                            emoji: '🐦',
                            label: 'Twitter/X',
                            onTap: () {
                              Navigator.pop(context);
                              launchUrl(Uri.parse(
                                  'https://twitter.com/intent/tweet?text=$encoded'));
                            }),
                        _ShareOption(
                            emoji: '📘',
                            label: 'Facebook',
                            onTap: () {
                              Navigator.pop(context);
                              launchUrl(Uri.parse(
                                  'https://www.facebook.com/sharer/sharer.php?u=$link'));
                            }),
                        _ShareOption(
                            emoji: '🔗',
                            label: 'Copiar',
                            onTap: () {
                              Navigator.pop(context);
                              Clipboard.setData(
                                  ClipboardData(text: '$text\n$link'));
                            }),
                      ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = widget.isDesktop ? 420.0 : screenWidth;
    final likeCount = widget.post.likes + (_liked ? 1 : 0);

    return Container(
      margin: widget.isDesktop
          ? const EdgeInsets.fromLTRB(0, 0, 0, 1)
          : EdgeInsets.zero,
      decoration: widget.isDesktop
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF2E2A22))))
          : null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header do post
        Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Row(children: [
              Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF242018),
                      border: Border.all(
                          color: const Color(0xFFD4622A), width: 1.5)),
                  child: Center(
                      child: Text(widget.post.emoji,
                          style: const TextStyle(fontSize: 19)))),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(widget.post.username,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF0ECE4))),
                    const SizedBox(height: 1),
                    Text(widget.post.garage,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 10, color: const Color(0xFF7A7060))),
                  ])),
              GestureDetector(
                  onTap: _openPostOptions,
                  child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.more_horiz,
                          color: Color(0xFF7A7060), size: 20))),
            ])),

        // Imagem
        GestureDetector(
            onDoubleTap: _onDoubleTap,
            child: Stack(alignment: Alignment.center, children: [
              Container(
                  width: double.infinity,
                  height: imageHeight,
                  color: widget.post.bgColor,
                  child: Center(
                      child: Text(widget.post.emoji,
                          style: const TextStyle(fontSize: 100)))),
              if (_showDoubleTapHeart)
                AnimatedBuilder(
                    animation: _doubleTapController,
                    builder: (context, child) => Opacity(
                        opacity: _doubleTapOpacity.value,
                        child: Transform.scale(
                            scale: _doubleTapScale.value,
                            child: const Icon(Icons.favorite,
                                color: Colors.white, size: 90)))),
            ])),

        // Ações: ❤️ número | 💬 número | compartilhar
        Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
            child: Row(children: [
              // Coração animado
              GestureDetector(
                  onTap: _toggleLike,
                  child: AnimatedBuilder(
                      animation: _heartScale,
                      builder: (context, child) => Transform.scale(
                          scale: _heartScale.value,
                          child: Icon(
                              _liked ? Icons.favorite : Icons.favorite_border,
                              color: _liked
                                  ? const Color(0xFFD4622A)
                                  : const Color(0xFF7A7060),
                              size: 26)))),
              const SizedBox(width: 6),
              // Número de curtidas — clicável abre lista
              GestureDetector(
                onTap: _openLikersList,
                child: Text('$likeCount',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _liked
                            ? const Color(0xFFD4622A)
                            : const Color(0xFF7A7060))),
              ),
              const SizedBox(width: 20),
              // Comentários
              GestureDetector(
                  onTap: _openComments,
                  child: AnimatedBuilder(
                      animation: _commentScale,
                      builder: (context, child) => Transform.scale(
                          scale: _commentScale.value,
                          child: Row(children: [
                            const Icon(Icons.chat_bubble_outline,
                                color: Color(0xFF7A7060), size: 24),
                            if (_comments.isNotEmpty) ...[
                              const SizedBox(width: 5),
                              Text('${_comments.length}',
                                  style: GoogleFonts.familjenGrotesk(
                                      fontSize: 13,
                                      color: const Color(0xFF7A7060))),
                            ],
                          ])))),
              const SizedBox(width: 20),
              // Compartilhar
              GestureDetector(
                  onTap: _openShare,
                  child: const Icon(Icons.share_outlined,
                      color: Color(0xFF7A7060), size: 24)),
            ])),

        // Legenda
        Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: '${widget.post.username} ',
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF0ECE4))),
              TextSpan(
                  text: widget.post.caption,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 12, color: const Color(0xFFB0A898))),
            ]))),
        const SizedBox(height: 14),
        if (!widget.isDesktop)
          const Divider(color: Color(0xFF1A1814), height: 1),
      ]),
    );
  }
}

// ── OPTION / SHARE ──
class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const _OptionTile(
      {required this.icon,
      required this.label,
      required this.onTap,
      this.color});
  @override
  Widget build(BuildContext context) {
    final c = color ?? const Color(0xFFF0ECE4);
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF2E2A22)))),
            child: Row(children: [
              Icon(icon, color: c, size: 20),
              const SizedBox(width: 14),
              Text(label,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 14, color: c, fontWeight: FontWeight.w600)),
            ])));
  }
}

class _ShareOption extends StatelessWidget {
  final String emoji, label;
  final VoidCallback onTap;
  const _ShareOption(
      {required this.emoji, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(children: [
          Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                  color: const Color(0xFF242018),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3A3428))),
              child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 24)))),
          const SizedBox(height: 6),
          Text(label,
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 10, color: const Color(0xFF7A7060))),
        ]));
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
            border: Border(top: BorderSide(color: Color(0xFF2E2A22)))),
        child: Row(children: [
          _NavItem(
              icon: Icons.home_rounded,
              label: 'FEED',
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
                                color: Colors.white, size: 26)),
                      ]))),
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
        ]));
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon,
                  color: active
                      ? const Color(0xFFD4622A)
                      : const Color(0xFF7A7060),
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
            ])));
  }
}

// ── MODELOS ──
class _Story {
  final String name, emoji;
  final bool seen;
  const _Story(this.name, this.emoji, this.seen);
}

class _Post {
  final String username, garage, emoji, caption;
  final int likes;
  final Color bgColor;
  const _Post(
      {required this.username,
      required this.garage,
      required this.emoji,
      required this.caption,
      required this.likes,
      required this.bgColor});
}

class _Notification {
  final String emoji, text, time, type, user, userEmoji;
  final int? postIndex;
  bool read;
  _Notification(
      {required this.emoji,
      required this.text,
      required this.time,
      required this.read,
      required this.type,
      required this.user,
      required this.userEmoji,
      required this.postIndex});
}

class _SuggestedUser {
  final String name, subtitle, emoji;
  const _SuggestedUser(this.name, this.subtitle, this.emoji);
}

class _TrendingCategory {
  final String name, emoji;
  final int posts;
  const _TrendingCategory(this.name, this.emoji, this.posts);
}

final _stories = [
  const _Story('rafael', '🏎️', false),
  const _Story('vinyl_br', '🎸', false),
  const _Story('marvels', '🦸', true),
  const _Story('trains', '🚂', false),
  const _Story('stamps', '📮', true),
];
final _posts = [
  _Post(
      username: 'vinyl_coleção',
      garage: '🏎️ Garagem do Vinil · SP',
      emoji: '🎸',
      caption: 'Led Zeppelin IV original de 1971 em Near Mint 🔥',
      likes: 384,
      bgColor: const Color(0xFF1a0a00)),
  _Post(
      username: 'pokemon_rafael',
      garage: '🏎️ Garage TCG · SP',
      emoji: '🐲',
      caption: 'Charizard Holo Base Set finalmente na coleção! 🎴',
      likes: 891,
      bgColor: const Color(0xFF0f0500)),
  _Post(
      username: 'hq_collector',
      garage: '🏎️ HQ Garage · RJ',
      emoji: '🦸',
      caption: 'Amazing Fantasy #15 — réplica perfeita encadernada.',
      likes: 230,
      bgColor: const Color(0xFF00050f)),
];
final _suggestedUsers = [
  const _SuggestedUser('magic_sp', 'Colecionador de Magic • 234 peças', '🎴'),
  const _SuggestedUser('cars_col', 'Miniaturas Ferrari • SP', '🚗'),
  const _SuggestedUser('shirts_br', 'Camisas históricas • RJ', '👕'),
];
final _trendingCategories = [
  const _TrendingCategory('Pokémon TCG', '🐲', 142),
  const _TrendingCategory('Vinil & Records', '🎸', 98),
  const _TrendingCategory('HQs & Comics', '🦸', 76),
  const _TrendingCategory('Miniaturas', '🚗', 54),
  const _TrendingCategory('Selos & Moedas', '📮', 41),
];
