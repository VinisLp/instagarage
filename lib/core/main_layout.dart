import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Importa todas as telas
import '../features/feed/feed_screen.dart';
import '../features/feed/profile_screen.dart';
import '../features/feed/collection_screen.dart';
import '../features/explore/explore_screen.dart';
import '../features/dm/dm_screen.dart';
import '../features/marketplace/marketplace_screen.dart';
import '../features/garage/garage_screen.dart';
import '../features/piece/ai_scan_screen.dart';

// ═══════════════════════════════════════════════════════════════════
// MAIN LAYOUT — Wrapper global para todas as telas do app
//
// USO em qualquer tela:
//
//   @override
//   Widget build(BuildContext context) {
//     return MainLayout(
//       currentIndex: NavIndex.feed,
//       child: _buildContent(),   // conteúdo SEM Scaffold
//     );
//   }
//
// Desktop (>= 900px): sidebar fixa + conteúdo + painel direito opcional
// Mobile  (<  900px): bottom nav + conteúdo full-screen
// ═══════════════════════════════════════════════════════════════════

class NavIndex {
  static const int feed = 0;
  static const int explore = 1;
  static const int addPiece = 2;
  static const int dms = 3;
  static const int market = 4;
  static const int profile = 5;
  static const int collection = 6;
  static const int garage = 7;
}

class MainLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final int generalUnread;
  final int personalUnread;
  final VoidCallback? onGeneralNotif;
  final VoidCallback? onPersonalNotif;

  /// Painel direito opcional no desktop (ex: sugeridos + coleção no feed)
  final Widget? rightPanel;
  final bool showRightPanel;

  const MainLayout({
    super.key,
    required this.currentIndex,
    required this.child,
    this.generalUnread = 0,
    this.personalUnread = 0,
    this.onGeneralNotif,
    this.onPersonalNotif,
    this.rightPanel,
    this.showRightPanel = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return isDesktop
        ? _DesktopLayout(layout: this)
        : _MobileLayout(layout: this);
  }
}

// ═══════════════════════════════════════════════════════════════════
// DESKTOP
// ═══════════════════════════════════════════════════════════════════
class _DesktopLayout extends StatelessWidget {
  final MainLayout layout;
  const _DesktopLayout({required this.layout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Sidebar esquerda fixa
          SizedBox(
            width: 240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: const Color(0xFF1A1814),
                child: _DesktopSidebar(layout: layout),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Conteúdo central
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: const Color(0xFF1A1814),
                child: layout.child,
              ),
            ),
          ),

          // Painel direito opcional
          if (layout.showRightPanel && layout.rightPanel != null) ...[
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 280,
                color: const Color(0xFF1A1814),
                child: layout.rightPanel,
              ),
            ),
          ],
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// MOBILE
// ═══════════════════════════════════════════════════════════════════
class _MobileLayout extends StatelessWidget {
  final MainLayout layout;
  const _MobileLayout({required this.layout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(child: layout.child),
      bottomNavigationBar: _MobileBottomNav(layout: layout),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// SIDEBAR DESKTOP
// ═══════════════════════════════════════════════════════════════════
class _DesktopSidebar extends StatelessWidget {
  final MainLayout layout;
  const _DesktopSidebar({required this.layout});

  void _go(BuildContext context, int index) {
    if (index == layout.currentIndex) return;
    final Widget? route = _buildRoute(index);
    if (route == null) return;
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => route,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
  }

  Widget? _buildRoute(int index) {
    switch (index) {
      case NavIndex.feed:
        return const FeedScreen();
      case NavIndex.explore:
        return const ExploreScreen();
      case NavIndex.addPiece:
        return const AiScanScreen();
      case NavIndex.dms:
        return const DmScreen();
      case NavIndex.market:
        return const MarketplaceScreen();
      case NavIndex.profile:
        return const ProfileScreen();
      case NavIndex.collection:
        return const CollectionScreen();
      case NavIndex.garage:
        return const GarageScreen();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Logo
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
            active: layout.currentIndex == NavIndex.feed,
            onTap: () => _go(context, NavIndex.feed)),
        _SideNavItem(
            icon: Icons.search_rounded,
            label: 'EXPLORAR',
            active: layout.currentIndex == NavIndex.explore,
            onTap: () => _go(context, NavIndex.explore)),
        _SideNavItem(
            icon: Icons.chat_bubble_rounded,
            label: 'DMs',
            active: layout.currentIndex == NavIndex.dms,
            onTap: () => _go(context, NavIndex.dms)),
        _SideNavItem(
            icon: Icons.storefront_rounded,
            label: 'MARKET',
            active: layout.currentIndex == NavIndex.market,
            onTap: () => _go(context, NavIndex.market)),
        _SideNavItem(
            icon: Icons.person_rounded,
            label: 'PERFIL',
            active: layout.currentIndex == NavIndex.profile,
            onTap: () => _go(context, NavIndex.profile)),
        _SideNavItem(
            icon: Icons.collections_bookmark_rounded,
            label: 'COLEÇÃO',
            active: layout.currentIndex == NavIndex.collection,
            onTap: () => _go(context, NavIndex.collection)),

        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Divider(color: Color(0xFF2E2A22), height: 16),
        ),
        const SizedBox(height: 4),

        _SideNavItem(
          icon: Icons.notifications_none_rounded,
          label: 'NOTIFICAÇÕES',
          active: false,
          badge: layout.generalUnread,
          onTap: layout.onGeneralNotif ?? () {},
        ),
        _SideNavItem(
          icon: Icons.person_outline_rounded,
          label: 'ATIVIDADE',
          active: false,
          badge: layout.personalUnread,
          onTap: layout.onPersonalNotif ?? () {},
        ),

        const Spacer(),

        // Botão Nova Peça
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GestureDetector(
            onTap: () => _go(context, NavIndex.addPiece),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color(0xFFD4622A),
                  borderRadius: BorderRadius.circular(12)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.add, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text('NOVA PEÇA',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 14, letterSpacing: 1.5, color: Colors.white)),
              ]),
            ),
          ),
        ),

        // Avatar / perfil rápido
        GestureDetector(
          onTap: () => _go(context, NavIndex.profile),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: Row(children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: const Color(0xFF242018),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFFD4622A), width: 1.5)),
                child: const Center(
                    child: Text('🏎️', style: TextStyle(fontSize: 15))),
              ),
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
                    ]),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF4A4438), size: 12),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ── Sidebar item ──
class _SideNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final int badge;
  final VoidCallback onTap;

  const _SideNavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    this.badge = 0,
  });

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
          borderRadius: BorderRadius.circular(10),
        ),
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
                        : const Color(0xFFB0A898))),
          ),
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
                      fontWeight: FontWeight.w700)),
            ),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// BOTTOM NAV MOBILE
// ═══════════════════════════════════════════════════════════════════
class _MobileBottomNav extends StatelessWidget {
  final MainLayout layout;
  const _MobileBottomNav({required this.layout});

  void _go(BuildContext context, int index) {
    if (index == layout.currentIndex) return;
    Widget? route;
    switch (index) {
      case NavIndex.feed:
        route = const FeedScreen();
        break;
      case NavIndex.explore:
        route = const ExploreScreen();
        break;
      case NavIndex.addPiece:
        route = const AiScanScreen();
        break;
      case NavIndex.dms:
        route = const DmScreen();
        break;
      case NavIndex.market:
        route = const MarketplaceScreen();
        break;
      default:
        return;
    }
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => route!,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
  }

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
            active: layout.currentIndex == NavIndex.feed,
            onTap: () => _go(context, NavIndex.feed)),
        _NavItem(
            icon: Icons.search_rounded,
            label: 'EXPLORAR',
            active: layout.currentIndex == NavIndex.explore,
            onTap: () => _go(context, NavIndex.explore)),
        // Botão central +
        Expanded(
            child: GestureDetector(
          onTap: () => _go(context, NavIndex.addPiece),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: 46,
              height: 46,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  color: const Color(0xFFD4622A),
                  borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.add, color: Colors.white, size: 26),
            ),
          ]),
        )),
        _NavItem(
            icon: Icons.chat_bubble_rounded,
            label: 'DMs',
            active: layout.currentIndex == NavIndex.dms,
            onTap: () => _go(context, NavIndex.dms)),
        _NavItem(
            icon: Icons.storefront_rounded,
            label: 'MARKET',
            active: layout.currentIndex == NavIndex.market,
            onTap: () => _go(context, NavIndex.market)),
      ]),
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
