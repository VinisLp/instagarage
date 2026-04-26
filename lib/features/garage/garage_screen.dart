import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/main_layout.dart';
import '../feed/collection_screen.dart';
import '../piece/piece_detail_screen.dart';
import '../piece/ai_scan_screen.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});
  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final user = Supabase.instance.client.auth.currentUser;

  String _profileName = 'MEU PERFIL';
  String _profileHandle = '';
  String _profileBio = 'Colecionador apaixonado 🔥 Adicione sua bio aqui';
  String _profileEmoji = '🏎️';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _profileHandle = user?.email?.split('@')[0] ?? 'usuario';
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openEditProfile() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fechar',
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 220),
      transitionBuilder: (ctx, anim, _, w) => ScaleTransition(
          scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim, child: w)),
      pageBuilder: (ctx, _, __) => _EditProfileDialog(
        currentName: _profileName,
        currentHandle: _profileHandle,
        currentBio: _profileBio,
        currentEmoji: _profileEmoji,
        onSave: (name, handle, bio, emoji) => setState(() {
          _profileName = name;
          _profileHandle = handle;
          _profileBio = bio;
          _profileEmoji = emoji;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return MainLayout(
      currentIndex: NavIndex.garage,
      child: isDesktop ? _buildDesktopContent() : _buildMobileContent(),
    );
  }

  Widget _buildMobileContent() {
    return NestedScrollView(
      headerSliverBuilder: (context, _) =>
          [SliverToBoxAdapter(child: _buildMobileHeader())],
      body: TabBarView(controller: _tabController, children: [
        _PiecesGrid(crossAxisCount: 3),
        const _EmptyState(
            icon: '📸',
            title: 'NENHUM POST AINDA',
            subtitle: 'Compartilhe suas peças com a comunidade'),
        const _EmptyState(
            icon: '⭐',
            title: 'WISHLIST VAZIA',
            subtitle: 'Adicione peças que você está procurando'),
      ]),
    );
  }

  Widget _buildDesktopContent() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Sidebar esquerda
      SizedBox(
        width: 260,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 24, 16, 24),
          child: _buildDesktopSidebar(),
        ),
      ),
      Container(width: 1, color: const Color(0xFF2E2A22)),
      // Conteúdo
      Expanded(
          child: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverToBoxAdapter(
              child: Column(children: [
            const SizedBox(height: 16),
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
                  Tab(text: 'PEÇAS'),
                  Tab(text: 'POSTS'),
                  Tab(text: 'WISHLIST')
                ]),
          ]))
        ],
        body: TabBarView(controller: _tabController, children: [
          _PiecesGrid(crossAxisCount: 4),
          const _EmptyState(
              icon: '📸',
              title: 'NENHUM POST AINDA',
              subtitle: 'Compartilhe suas peças com a comunidade'),
          const _EmptyState(
              icon: '⭐',
              title: 'WISHLIST VAZIA',
              subtitle: 'Adicione peças que você está procurando'),
        ]),
      )),
    ]);
  }

  Widget _buildDesktopSidebar() {
    return Column(children: [
      // Avatar
      Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: const Color(0xFF242018),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD4622A), width: 2)),
          child: Center(
              child:
                  Text(_profileEmoji, style: const TextStyle(fontSize: 48)))),
      const SizedBox(height: 16),
      Text(_profileName,
          style: GoogleFonts.bebasNeue(
              fontSize: 24, color: const Color(0xFFF0ECE4), letterSpacing: 2)),
      const SizedBox(height: 4),
      Text('@$_profileHandle',
          style: GoogleFonts.familjenGrotesk(
              fontSize: 13, color: const Color(0xFF7A7060))),
      const SizedBox(height: 12),
      Text(_profileBio,
          style: GoogleFonts.familjenGrotesk(
              fontSize: 13, color: const Color(0xFF7A7060), height: 1.4),
          textAlign: TextAlign.center),
      const SizedBox(height: 20),
      SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _openEditProfile,
            style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFF0ECE4),
                side: const BorderSide(color: Color(0xFF3A3428)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12)),
            child: Text('EDITAR PERFIL',
                style: GoogleFonts.bebasNeue(fontSize: 14, letterSpacing: 1.5)),
          )),
      const SizedBox(height: 20),
      Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: const Color(0xFF1A1814),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF2E2A22))),
          child: Column(children: [
            _DesktopStatRow(value: '0', label: 'PEÇAS'),
            const Divider(color: Color(0xFF2E2A22), height: 20),
            _DesktopStatRow(value: '0', label: 'SEGUIDORES'),
            const Divider(color: Color(0xFF2E2A22), height: 20),
            _DesktopStatRow(value: 'R\$ 0', label: 'VALOR TOTAL'),
          ])),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () async {
          await Supabase.instance.client.auth.signOut();
        },
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF3A3428))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.logout, color: Color(0xFF7A7060), size: 16),
              const SizedBox(width: 8),
              Text('SAIR',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 14,
                      letterSpacing: 1.5,
                      color: const Color(0xFF7A7060)))
            ])),
      ),
    ]);
  }

  Widget _buildMobileHeader() {
    return Column(children: [
      Stack(clipBehavior: Clip.none, children: [
        Container(
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF1a0800),
              Color(0xFF3a1800),
              Color(0xFF1a0a02)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Center(
                child:
                    Text(_profileEmoji, style: const TextStyle(fontSize: 48)))),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xFF0F0E0B)])))),
        Positioned(
            top: 40,
            right: 16,
            child: GestureDetector(
                onTap: () async {
                  await Supabase.instance.client.auth.signOut();
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.logout,
                        color: Color(0xFFF0ECE4), size: 18)))),
      ]),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
                width: 72,
                height: 72,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: const Color(0xFF242018),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF0F0E0B), width: 3)),
                child: Center(
                    child: Text(_profileEmoji,
                        style: const TextStyle(fontSize: 32)))),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  Text(_profileName,
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2)),
                  Text('@$_profileHandle',
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 12, color: const Color(0xFF7A7060))),
                ])),
            Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: OutlinedButton(
                  onPressed: _openEditProfile,
                  style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFF0ECE4),
                      side: const BorderSide(color: Color(0xFF3A3428)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8)),
                  child: Text('EDITAR',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 13, letterSpacing: 1.5)),
                )),
          ])),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(_profileBio,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 13, color: const Color(0xFF7A7060))))),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Color(0xFF2E2A22)),
                  bottom: BorderSide(color: Color(0xFF2E2A22)))),
          child: Row(children: [
            _StatItem(value: '0', label: 'PEÇAS'),
            _StatDivider(),
            _StatItem(value: '0', label: 'SEGUIDORES'),
            _StatDivider(),
            _StatItem(value: 'R\$0', label: 'VALOR')
          ])),
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
            Tab(text: 'PEÇAS'),
            Tab(text: 'POSTS'),
            Tab(text: 'WISHLIST')
          ]),
    ]);
  }
}

// ── Edit Profile Dialog ──
class _EditProfileDialog extends StatefulWidget {
  final String currentName, currentHandle, currentBio, currentEmoji;
  final Function(String, String, String, String) onSave;
  const _EditProfileDialog(
      {required this.currentName,
      required this.currentHandle,
      required this.currentBio,
      required this.currentEmoji,
      required this.onSave});
  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  late TextEditingController _nameCtrl, _handleCtrl, _bioCtrl;
  late String _selectedEmoji;
  bool _saving = false;
  final List<String> _avatarEmojis = [
    '🏎️',
    '🎸',
    '🐲',
    '🦸',
    '📮',
    '🚂',
    '🎴',
    '🚗',
    '👕',
    '🏆',
    '⭐',
    '🔥',
    '🎯',
    '🎮',
    '🎨',
    '📸',
    '🦋',
    '🌟'
  ];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.currentName);
    _handleCtrl = TextEditingController(text: widget.currentHandle);
    _bioCtrl = TextEditingController(text: widget.currentBio);
    _selectedEmoji = widget.currentEmoji;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _handleCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _save() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 400));
    widget.onSave(_nameCtrl.text.trim(), _handleCtrl.text.trim(),
        _bioCtrl.text.trim(), _selectedEmoji);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            color: Colors.transparent,
            child: Container(
              width: 480,
              constraints: const BoxConstraints(maxHeight: 640),
              decoration: BoxDecoration(
                  color: const Color(0xFF1A1814),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2E2A22))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xFF2E2A22)))),
                        child: Row(children: [
                          Text('EDITAR PERFIL',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 20,
                                  color: const Color(0xFFF0ECE4),
                                  letterSpacing: 2)),
                          const Spacer(),
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.close_rounded,
                                  color: Color(0xFF7A7060), size: 22))
                        ])),
                    Flexible(
                        child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: Column(children: [
                                    Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF242018),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: const Color(0xFFD4622A),
                                                width: 2)),
                                        child: Center(
                                            child: Text(_selectedEmoji,
                                                style: const TextStyle(
                                                    fontSize: 40)))),
                                    const SizedBox(height: 10),
                                    Text('ESCOLHER AVATAR',
                                        style: GoogleFonts.jetBrainsMono(
                                            fontSize: 9,
                                            color: const Color(0xFF7A7060),
                                            letterSpacing: 1.5)),
                                  ])),
                                  const SizedBox(height: 12),
                                  Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF242018),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: const Color(0xFF2E2A22))),
                                      child: GridView.count(
                                          crossAxisCount: 6,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          children: _avatarEmojis.map((emoji) {
                                            final selected =
                                                emoji == _selectedEmoji;
                                            return GestureDetector(
                                                onTap: () => setState(() =>
                                                    _selectedEmoji = emoji),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: selected
                                                            ? const Color(0xFFD4622A)
                                                                .withOpacity(
                                                                    0.2)
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                        border: Border.all(
                                                            color: selected
                                                                ? const Color(
                                                                    0xFFD4622A)
                                                                : Colors
                                                                    .transparent)),
                                                    child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22)))));
                                          }).toList())),
                                  const SizedBox(height: 20),
                                  Text('NOME',
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 9,
                                          color: const Color(0xFF7A7060),
                                          letterSpacing: 1.5)),
                                  const SizedBox(height: 6),
                                  _buildInput(
                                      _nameCtrl, 'Seu nome de exibição'),
                                  const SizedBox(height: 14),
                                  Text('USUÁRIO',
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 9,
                                          color: const Color(0xFF7A7060),
                                          letterSpacing: 1.5)),
                                  const SizedBox(height: 6),
                                  _buildInput(_handleCtrl, '@seuusuario'),
                                  const SizedBox(height: 14),
                                  Text('BIO',
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 9,
                                          color: const Color(0xFF7A7060),
                                          letterSpacing: 1.5)),
                                  const SizedBox(height: 6),
                                  _buildInput(_bioCtrl,
                                      'Conte sobre você e sua coleção...',
                                      maxLines: 3),
                                ]))),
                    Container(
                        padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Color(0xFF2E2A22)))),
                        child: Row(children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFF3A3428)),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                          child: Text('CANCELAR',
                                              style: GoogleFonts.bebasNeue(
                                                  fontSize: 14,
                                                  letterSpacing: 1.5,
                                                  color: const Color(
                                                      0xFF7A7060))))))),
                          const SizedBox(width: 12),
                          Expanded(
                              child: GestureDetector(
                                  onTap: _saving ? null : _save,
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFD4622A),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                          child: _saving
                                              ? const SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 2))
                                              : Text('SALVAR',
                                                  style: GoogleFonts.bebasNeue(
                                                      fontSize: 14,
                                                      letterSpacing: 1.5,
                                                      color: Colors.white)))))),
                        ])),
                  ])),
            )));
  }

  Widget _buildInput(TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
    return TextField(
        controller: ctrl,
        maxLines: maxLines,
        style: GoogleFonts.familjenGrotesk(
            color: const Color(0xFFF0ECE4), fontSize: 14),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.familjenGrotesk(
                color: const Color(0xFF4A4438), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFF242018),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF2E2A22))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF2E2A22))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFD4622A))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12)));
  }
}

// ── Widgets auxiliares ──
class _PiecesGrid extends StatelessWidget {
  final int crossAxisCount;
  const _PiecesGrid({required this.crossAxisCount});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(1.5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 1.5,
          mainAxisSpacing: 1.5),
      itemCount: 1,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const PieceDetailScreen())),
        child: Container(
            color: const Color(0xFF242018),
            child: const Center(
                child: Icon(Icons.add, color: Color(0xFF3A3428), size: 32))),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String icon, title, subtitle;
  const _EmptyState(
      {required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(icon, style: const TextStyle(fontSize: 48)),
      const SizedBox(height: 16),
      Text(title,
          style: GoogleFonts.bebasNeue(
              fontSize: 20, color: const Color(0xFF4A4438), letterSpacing: 2)),
      const SizedBox(height: 8),
      Text(subtitle,
          style: GoogleFonts.familjenGrotesk(
              fontSize: 13, color: const Color(0xFF4A4438)),
          textAlign: TextAlign.center),
    ]));
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  const _StatItem({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      Text(value,
          style: GoogleFonts.bebasNeue(
              fontSize: 22, color: const Color(0xFFF0ECE4), letterSpacing: 1)),
      Text(label,
          style: GoogleFonts.jetBrainsMono(
              fontSize: 9, color: const Color(0xFF7A7060), letterSpacing: 1)),
    ]));
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: const Color(0xFF2E2A22));
}

class _DesktopStatRow extends StatelessWidget {
  final String value, label;
  const _DesktopStatRow({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label,
          style: GoogleFonts.jetBrainsMono(
              fontSize: 10, color: const Color(0xFF7A7060), letterSpacing: 1)),
      Text(value,
          style: GoogleFonts.bebasNeue(
              fontSize: 20, color: const Color(0xFFF0ECE4), letterSpacing: 1)),
    ]);
  }
}
