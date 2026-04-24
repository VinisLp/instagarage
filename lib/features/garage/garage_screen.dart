import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../feed/feed_screen.dart';
import '../explore/explore_screen.dart';
import '../piece/piece_detail_screen.dart';
import '../piece/ai_scan_screen.dart';
import '../dm/dm_screen.dart';
import '../marketplace/marketplace_screen.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final user = Supabase.instance.client.auth.currentUser;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isDesktop = !isMobile;
    // ✅ No desktop centraliza o conteúdo em 860px
    const contentWidth = 860.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: isDesktop
          // ── LAYOUT DESKTOP ──
          ? _buildDesktopLayout(contentWidth)
          // ── LAYOUT MOBILE ──
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

  // ══════════════════════════════════════
  // LAYOUT MOBILE — original com NestedScrollView
  // ══════════════════════════════════════
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

  // ══════════════════════════════════════
  // LAYOUT DESKTOP — duas colunas
  // ══════════════════════════════════════
  Widget _buildDesktopLayout(double contentWidth) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: contentWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Coluna esquerda: perfil fixo (280px)
              SizedBox(
                width: 280,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 24, 16, 24),
                  child: _buildDesktopSidebar(),
                ),
              ),

              // ✅ Divider vertical
              Container(width: 1, color: const Color(0xFF2E2A22)),

              // ✅ Coluna direita: abas + conteúdo
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          // Abas no desktop
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
                        ],
                      ),
                    ),
                  ],
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      // ✅ No desktop, grid de 4 colunas
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

  // ✅ Sidebar do desktop com perfil completo
  Widget _buildDesktopSidebar() {
    final handle = user?.email?.split('@')[0] ?? 'usuario';

    return Column(
      children: [
        // Avatar grande
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF242018),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD4622A), width: 2),
          ),
          child:
              const Center(child: Text('🏎️', style: TextStyle(fontSize: 48))),
        ),
        const SizedBox(height: 16),
        Text('MEU PERFIL',
            style: GoogleFonts.bebasNeue(
                fontSize: 24,
                color: const Color(0xFFF0ECE4),
                letterSpacing: 2)),
        const SizedBox(height: 4),
        Text('@$handle',
            style: GoogleFonts.familjenGrotesk(
                fontSize: 13, color: const Color(0xFF7A7060))),
        const SizedBox(height: 16),
        Text('Colecionador apaixonado 🔥 Adicione sua bio aqui',
            style: GoogleFonts.familjenGrotesk(
                fontSize: 13, color: const Color(0xFF7A7060), height: 1.4),
            textAlign: TextAlign.center),
        const SizedBox(height: 20),

        // Botão editar
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFF0ECE4),
              side: const BorderSide(color: Color(0xFF3A3428)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text('EDITAR PERFIL',
                style: GoogleFonts.bebasNeue(fontSize: 14, letterSpacing: 1.5)),
          ),
        ),
        const SizedBox(height: 20),

        // Stats verticais
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1814),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF2E2A22)),
          ),
          child: Column(
            children: [
              _DesktopStatRow(value: '0', label: 'PEÇAS'),
              const Divider(color: Color(0xFF2E2A22), height: 20),
              _DesktopStatRow(value: '0', label: 'SEGUIDORES'),
              const Divider(color: Color(0xFF2E2A22), height: 20),
              _DesktopStatRow(value: 'R\$ 0', label: 'VALOR TOTAL'),
            ],
          ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: Color(0xFF7A7060), size: 16),
                const SizedBox(width: 8),
                Text('SAIR',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 14,
                        letterSpacing: 1.5,
                        color: const Color(0xFF7A7060))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── HEADER MOBILE ──
  Widget _buildHeader({required bool isMobile}) {
    final handle = user?.email?.split('@')[0] ?? 'usuario';

    return Column(
      children: [
        // Banner
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1a0800),
                    Color(0xFF3a1800),
                    Color(0xFF1a0a02)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                  child: Text('🏎️', style: TextStyle(fontSize: 48))),
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
                  child: const Icon(Icons.logout,
                      color: Color(0xFFF0ECE4), size: 18),
                ),
              ),
            ),
          ],
        ),

        // Perfil row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 72,
                height: 72,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF242018),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0F0E0B), width: 3),
                ),
                child: const Center(
                    child: Text('🏎️', style: TextStyle(fontSize: 32))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('MEU PERFIL',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2,
                        )),
                    Text('@$handle',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12, color: const Color(0xFF7A7060))),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFF0ECE4),
                    side: const BorderSide(color: Color(0xFF3A3428)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text('EDITAR',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 13, letterSpacing: 1.5)),
                ),
              ),
            ],
          ),
        ),

        // Bio
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Colecionador apaixonado 🔥 Adicione sua bio aqui',
                style: GoogleFonts.familjenGrotesk(
                    fontSize: 13, color: const Color(0xFF7A7060))),
          ),
        ),

        // Stats
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFF2E2A22)),
              bottom: BorderSide(color: Color(0xFF2E2A22)),
            ),
          ),
          child: Row(
            children: [
              _StatItem(value: '0', label: 'PEÇAS'),
              _StatDivider(),
              _StatItem(value: '0', label: 'SEGUIDORES'),
              _StatDivider(),
              _StatItem(value: 'R\$0', label: 'VALOR'),
            ],
          ),
        ),

        // Tabs mobile
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
      ],
    );
  }
}

// ── GRADE DE PEÇAS ✅ crossAxisCount configurável ──
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

// ── ESTADO VAZIO ──
class _EmptyState extends StatelessWidget {
  final String icon, title, subtitle;
  const _EmptyState(
      {required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        ],
      ),
    );
  }
}

// ── STAT ITEM (mobile horizontal) ──
class _StatItem extends StatelessWidget {
  final String value, label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.bebasNeue(
                  fontSize: 22,
                  color: const Color(0xFFF0ECE4),
                  letterSpacing: 1)),
          Text(label,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: const Color(0xFF7A7060),
                  letterSpacing: 1)),
        ],
      ),
    );
  }
}

// ── STAT ROW (desktop vertical) ──
class _DesktopStatRow extends StatelessWidget {
  final String value, label;
  const _DesktopStatRow({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: const Color(0xFF7A7060),
                letterSpacing: 1)),
        Text(value,
            style: GoogleFonts.bebasNeue(
                fontSize: 20,
                color: const Color(0xFFF0ECE4),
                letterSpacing: 1)),
      ],
    );
  }
}

// ── STAT DIVIDER ──
class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: const Color(0xFF2E2A22));
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
        border: Border(top: BorderSide(color: Color(0xFF2E2A22))),
      ),
      // ✅ No desktop centraliza a nav
      child: Center(
        child: SizedBox(
          width: isDesktop ? 860.0 : double.infinity,
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
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 26),
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
                    letterSpacing: 0.5,
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
