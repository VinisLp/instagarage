import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../feed/feed_screen.dart';
import '../explore/explore_screen.dart';
import '../piece/piece_detail_screen.dart';
import '../piece/ai_scan_screen.dart';
import '../dm/dm_screen.dart';
import '../marketplace/marketplace_screen.dart';

// ═══════════════════════════════════════════════════════════════════
// DIALOG DE EDIÇÃO DE PERFIL
// ═══════════════════════════════════════════════════════════════════
class EditProfileDialog extends StatefulWidget {
  final String currentName;
  final String currentHandle;
  final String currentBio;
  final String currentEmoji;
  final Function(String name, String handle, String bio, String emoji) onSave;

  const EditProfileDialog({
    super.key,
    required this.currentName,
    required this.currentHandle,
    required this.currentBio,
    required this.currentEmoji,
    required this.onSave,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _nameCtrl;
  late TextEditingController _handleCtrl;
  late TextEditingController _bioCtrl;
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
    '🌟',
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
    widget.onSave(
      _nameCtrl.text.trim(),
      _handleCtrl.text.trim(),
      _bioCtrl.text.trim(),
      _selectedEmoji,
    );
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
            border: Border.all(color: const Color(0xFF2E2A22)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Header ──
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                  decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFF2E2A22))),
                  ),
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
                          color: Color(0xFF7A7060), size: 22),
                    ),
                  ]),
                ),

                // ── Conteúdo scrollável ──
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Avatar atual + picker ──
                        Center(
                          child: Column(children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFF242018),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFFD4622A), width: 2),
                              ),
                              child: Center(
                                child: Text(_selectedEmoji,
                                    style: const TextStyle(fontSize: 40)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('ESCOLHER AVATAR',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 9,
                                    color: const Color(0xFF7A7060),
                                    letterSpacing: 1.5)),
                          ]),
                        ),
                        const SizedBox(height: 12),

                        // ── Grade de emojis ──
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF242018),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF2E2A22)),
                          ),
                          child: GridView.count(
                            crossAxisCount: 6,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            children: _avatarEmojis.map((emoji) {
                              final selected = emoji == _selectedEmoji;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedEmoji = emoji),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? const Color(0xFFD4622A)
                                            .withOpacity(0.2)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: selected
                                          ? const Color(0xFFD4622A)
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(emoji,
                                        style: const TextStyle(fontSize: 22)),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── Campo Nome ──
                        _FieldLabel('NOME'),
                        const SizedBox(height: 6),
                        _InputField(
                          controller: _nameCtrl,
                          hint: 'Seu nome de exibição',
                          maxLength: 30,
                        ),
                        const SizedBox(height: 14),

                        // ── Campo @ ──
                        _FieldLabel('USUÁRIO'),
                        const SizedBox(height: 6),
                        _InputField(
                          controller: _handleCtrl,
                          hint: '@seuusuario',
                          prefix: '@',
                          maxLength: 20,
                        ),
                        const SizedBox(height: 14),

                        // ── Campo Bio ──
                        _FieldLabel('BIO'),
                        const SizedBox(height: 6),
                        _InputField(
                          controller: _bioCtrl,
                          hint: 'Conte um pouco sobre você e sua coleção...',
                          maxLines: 3,
                          maxLength: 150,
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ValueListenableBuilder(
                            valueListenable: _bioCtrl,
                            builder: (_, val, __) => Text(
                              '${_bioCtrl.text.length}/150',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 9, color: const Color(0xFF4A4438)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),

                // ── Footer com botões ──
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFF2E2A22))),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF3A3428)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text('CANCELAR',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 14,
                                    letterSpacing: 1.5,
                                    color: const Color(0xFF7A7060))),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: _saving ? null : _save,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4622A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: _saving
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2))
                                : Text('SALVAR',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 14,
                                        letterSpacing: 1.5,
                                        color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Widgets auxiliares do dialog ──
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.jetBrainsMono(
            fontSize: 9,
            color: const Color(0xFF7A7060),
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600));
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? prefix;
  final int maxLines;
  final int? maxLength;

  const _InputField({
    required this.controller,
    required this.hint,
    this.prefix,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      style: GoogleFonts.familjenGrotesk(
          color: const Color(0xFFF0ECE4), fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.familjenGrotesk(
            color: const Color(0xFF4A4438), fontSize: 14),
        prefixText: prefix,
        prefixStyle: GoogleFonts.familjenGrotesk(
            color: const Color(0xFF7A7060), fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF242018),
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF2E2A22)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF2E2A22)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD4622A)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}

// ── Função helper para abrir o dialog ──
void openEditProfileDialog({
  required BuildContext context,
  required String name,
  required String handle,
  required String bio,
  required String emoji,
  required Function(String, String, String, String) onSave,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Fechar',
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 220),
    transitionBuilder: (ctx, anim, _, w) => ScaleTransition(
      scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
      child: FadeTransition(opacity: anim, child: w),
    ),
    pageBuilder: (ctx, _, __) => EditProfileDialog(
      currentName: name,
      currentHandle: handle,
      currentBio: bio,
      currentEmoji: emoji,
      onSave: onSave,
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════
// GARAGE SCREEN — com edição de perfil integrada
// ═══════════════════════════════════════════════════════════════════
class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final user = Supabase.instance.client.auth.currentUser;

  // ── Dados do perfil editáveis ──
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
    openEditProfileDialog(
      context: context,
      name: _profileName,
      handle: _profileHandle,
      bio: _profileBio,
      emoji: _profileEmoji,
      onSave: (name, handle, bio, emoji) {
        setState(() {
          _profileName = name;
          _profileHandle = handle;
          _profileBio = bio;
          _profileEmoji = emoji;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isDesktop = !isMobile;
    const contentWidth = 860.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: isDesktop
          ? _buildDesktopLayout(contentWidth)
          : _buildMobileLayout(isMobile),
      bottomNavigationBar: _BottomNav(
        currentIndex: 2,
        isDesktop: isDesktop,
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
          else if (index == 4)
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const MarketplaceScreen()));
        },
      ),
    );
  }

  Widget _buildMobileLayout(bool isMobile) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(child: _buildHeader(isMobile: true)),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          _PiecesGrid(crossAxisCount: 3),
          const _EmptyState(
              icon: '📸',
              title: 'NENHUM POST AINDA',
              subtitle: 'Compartilhe suas peças com a comunidade'),
          const _EmptyState(
              icon: '⭐',
              title: 'WISHLIST VAZIA',
              subtitle: 'Adicione peças que você está procurando'),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(double contentWidth) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: contentWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 280,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 24, 16, 24),
                  child: _buildDesktopSidebar(),
                ),
              ),
              Container(width: 1, color: const Color(0xFF2E2A22)),
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Column(children: [
                        const SizedBox(height: 16),
                        TabBar(
                          controller: _tabController,
                          indicatorColor: const Color(0xFFD4622A),
                          indicatorWeight: 2,
                          labelColor: const Color(0xFFD4622A),
                          unselectedLabelColor: const Color(0xFF7A7060),
                          labelStyle: GoogleFonts.bebasNeue(
                              fontSize: 13, letterSpacing: 1.5),
                          unselectedLabelStyle: GoogleFonts.bebasNeue(
                              fontSize: 13, letterSpacing: 1.5),
                          tabs: const [
                            Tab(text: 'PEÇAS'),
                            Tab(text: 'POSTS'),
                            Tab(text: 'WISHLIST'),
                          ],
                        ),
                      ]),
                    ),
                  ],
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      _PiecesGrid(crossAxisCount: 4),
                      const _EmptyState(
                          icon: '📸',
                          title: 'NENHUM POST AINDA',
                          subtitle: 'Compartilhe suas peças com a comunidade'),
                      const _EmptyState(
                          icon: '⭐',
                          title: 'WISHLIST VAZIA',
                          subtitle: 'Adicione peças que você está procurando'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          border: Border.all(color: const Color(0xFFD4622A), width: 2),
        ),
        child: Center(
            child: Text(_profileEmoji, style: const TextStyle(fontSize: 48))),
      ),
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

      // ── Botão EDITAR PERFIL — abre o dialog ──
      SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: _openEditProfile,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFF0ECE4),
            side: const BorderSide(color: Color(0xFF3A3428)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text('EDITAR PERFIL',
              style: GoogleFonts.bebasNeue(fontSize: 14, letterSpacing: 1.5)),
        ),
      ),
      const SizedBox(height: 20),

      // Stats
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF2E2A22)),
        ),
        child: Column(children: [
          _DesktopStatRow(value: '0', label: 'PEÇAS'),
          const Divider(color: Color(0xFF2E2A22), height: 20),
          _DesktopStatRow(value: '0', label: 'SEGUIDORES'),
          const Divider(color: Color(0xFF2E2A22), height: 20),
          _DesktopStatRow(value: 'R\$ 0', label: 'VALOR TOTAL'),
        ]),
      ),
      const SizedBox(height: 20),

      // Botão sair
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
            border: Border.all(color: const Color(0xFF3A3428)),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.logout, color: Color(0xFF7A7060), size: 16),
            const SizedBox(width: 8),
            Text('SAIR',
                style: GoogleFonts.bebasNeue(
                    fontSize: 14,
                    letterSpacing: 1.5,
                    color: const Color(0xFF7A7060))),
          ]),
        ),
      ),
    ]);
  }

  Widget _buildHeader({required bool isMobile}) {
    return Column(children: [
      Stack(clipBehavior: Clip.none, children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1a0800), Color(0xFF3a1800), Color(0xFF1a0a02)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
              child: Text(_profileEmoji, style: const TextStyle(fontSize: 48))),
        ),
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
                colors: [Colors.transparent, Color(0xFF0F0E0B)],
              ),
            ),
          ),
        ),
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
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  const Icon(Icons.logout, color: Color(0xFFF0ECE4), size: 18),
            ),
          ),
        ),
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
              border: Border.all(color: const Color(0xFF0F0E0B), width: 3),
            ),
            child: Center(
                child:
                    Text(_profileEmoji, style: const TextStyle(fontSize: 32))),
          ),
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
              ],
            ),
          ),
          // ── Botão EDITAR mobile — abre o dialog ──
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: OutlinedButton(
              onPressed: _openEditProfile,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFF0ECE4),
                side: const BorderSide(color: Color(0xFF3A3428)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text('EDITAR',
                  style:
                      GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5)),
            ),
          ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(_profileBio,
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 13, color: const Color(0xFF7A7060))),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF2E2A22)),
            bottom: BorderSide(color: Color(0xFF2E2A22)),
          ),
        ),
        child: Row(children: [
          _StatItem(value: '0', label: 'PEÇAS'),
          _StatDivider(),
          _StatItem(value: '0', label: 'SEGUIDORES'),
          _StatDivider(),
          _StatItem(value: 'R\$0', label: 'VALOR'),
        ]),
      ),
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
          Tab(text: 'WISHLIST'),
        ],
      ),
    ]);
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
        mainAxisSpacing: 1.5,
      ),
      itemCount: 1,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const PieceDetailScreen())),
          child: Container(
            color: const Color(0xFF242018),
            child: const Center(
                child: Icon(Icons.add, color: Color(0xFF3A3428), size: 32)),
          ),
        );
      },
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
                fontSize: 20,
                color: const Color(0xFF4A4438),
                letterSpacing: 2)),
        const SizedBox(height: 8),
        Text(subtitle,
            style: GoogleFonts.familjenGrotesk(
                fontSize: 13, color: const Color(0xFF4A4438)),
            textAlign: TextAlign.center),
      ]),
    );
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
                fontSize: 22,
                color: const Color(0xFFF0ECE4),
                letterSpacing: 1)),
        Text(label,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 9, color: const Color(0xFF7A7060), letterSpacing: 1)),
      ]),
    );
  }
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

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: const Color(0xFF2E2A22));
  }
}

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
        border: Border(top: BorderSide(color: Color(0xFF2E2A22))),
      ),
      child: Center(
        child: SizedBox(
          width: isDesktop ? 860.0 : double.infinity,
          child: Row(children: [
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
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
          ]),
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon,
              color: active ? const Color(0xFFD4622A) : const Color(0xFF7A7060),
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
        ]),
      ),
    );
  }
}
