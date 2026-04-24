import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../feed/feed_screen.dart';
import '../explore/explore_screen.dart';
import '../piece/ai_scan_screen.dart';
import '../marketplace/marketplace_screen.dart';

class DmScreen extends StatefulWidget {
  const DmScreen({super.key});

  @override
  State<DmScreen> createState() => _DmScreenState();
}

class _DmScreenState extends State<DmScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<_Conversation> _conversations = [
    _Conversation(
        emoji: '🏎️',
        name: 'pokemon_rafael',
        lastMessage: 'Topei! Me manda foto do verso também 🎴',
        time: '2min',
        unread: 2,
        online: true,
        isTradeOrSale: false),
    _Conversation(
        emoji: '🎸',
        name: 'vinyl_br',
        lastMessage: 'Esse Led IV é original sim, tenho o certificado',
        time: '18min',
        unread: 0,
        online: true,
        isTradeOrSale: false),
    _Conversation(
        emoji: '🦸',
        name: 'hq_collector',
        lastMessage: 'Você toparia trocar pelo Amazing Fantasy?',
        time: '1h',
        unread: 1,
        online: false,
        isTradeOrSale: true),
    _Conversation(
        emoji: '🚂',
        name: 'trains_sp',
        lastMessage: 'Obrigado! Foi ótimo negócio 🤝',
        time: '3h',
        unread: 0,
        online: false,
        isTradeOrSale: true),
    _Conversation(
        emoji: '👕',
        name: 'shirts_br',
        lastMessage: 'A camisa chegou perfeita, muito obrigado!',
        time: '1d',
        unread: 0,
        online: false,
        isTradeOrSale: false),
    _Conversation(
        emoji: '🎴',
        name: 'magic_sp',
        lastMessage: 'Tenho um Black Lotus para troca se tiver interesse',
        time: '2d',
        unread: 0,
        online: false,
        isTradeOrSale: true),
  ];

  final List<_Follower> _followers = [
    _Follower(
        emoji: '🏎️',
        name: 'pokemon_rafael',
        handle: '@pokemon_rafael',
        online: true),
    _Follower(emoji: '🎸', name: 'vinyl_br', handle: '@vinyl_br', online: true),
    _Follower(
        emoji: '🦸',
        name: 'hq_collector',
        handle: '@hq_collector',
        online: false),
    _Follower(
        emoji: '🚂', name: 'trains_sp', handle: '@trains_sp', online: false),
    _Follower(
        emoji: '👕', name: 'shirts_br', handle: '@shirts_br', online: false),
    _Follower(
        emoji: '🎴', name: 'magic_sp', handle: '@magic_sp', online: false),
    _Follower(
        emoji: '📮', name: 'stamps_col', handle: '@stamps_col', online: true),
    _Follower(
        emoji: '🚗', name: 'cars_col', handle: '@cars_col', online: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openNewMessage() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
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
                  borderRadius: BorderRadius.circular(2)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('NOVA MENSAGEM',
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
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF242018),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF3A3428)),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(Icons.search_rounded,
                          color: Color(0xFF7A7060), size: 18),
                    ),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.familjenGrotesk(
                            color: const Color(0xFFF0ECE4), fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Buscar seguidores...',
                          hintStyle: GoogleFonts.familjenGrotesk(
                              color: const Color(0xFF4A4438), fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFF2E2A22)),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('SEUS SEGUIDORES',
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        color: const Color(0xFF7A7060),
                        letterSpacing: 1.5)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _followers.length,
                itemBuilder: (context, index) {
                  final f = _followers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => _ChatScreen(
                              conversation: _Conversation(
                                emoji: f.emoji,
                                name: f.name,
                                lastMessage: '',
                                time: '',
                                unread: 0,
                                online: f.online,
                                isTradeOrSale: false,
                              ),
                            ),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xFF2E2A22))),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF242018),
                                  border: Border.all(
                                      color: const Color(0xFF3A3428)),
                                ),
                                child: Center(
                                    child: Text(f.emoji,
                                        style: const TextStyle(fontSize: 22))),
                              ),
                              if (f.online)
                                Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: Container(
                                    width: 11,
                                    height: 11,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4CAF7A),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: const Color(0xFF1A1814),
                                          width: 2),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(f.name,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFF0ECE4))),
                                const SizedBox(height: 2),
                                Text(f.handle,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 11,
                                        color: const Color(0xFF7A7060))),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                                color: const Color(0xFFD4622A),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text('MENSAGEM',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 11,
                                    letterSpacing: 1.5,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 600;
    final normalConvs = _conversations.where((c) => !c.isTradeOrSale).toList();
    final tradeConvs = _conversations.where((c) => c.isTradeOrSale).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: isDesktop
            // ✅ LAYOUT DESKTOP: lista de conversas à esquerda, chat à direita
            ? _DesktopLayout(
                conversations: _conversations,
                normalConvs: normalConvs,
                tradeConvs: tradeConvs,
                tabController: _tabController,
                onNewMessage: _openNewMessage,
              )
            // ✅ LAYOUT MOBILE: original
            : Column(
                children: [
                  // ── TOPBAR ──
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                    child: Row(
                      children: [
                        Text('MENSAGENS',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 26,
                                color: const Color(0xFFF0ECE4),
                                letterSpacing: 3)),
                        const Spacer(),
                        GestureDetector(
                          onTap: _openNewMessage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1814),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xFF2E2A22)),
                            ),
                            child: const Icon(Icons.edit_rounded,
                                color: Color(0xFFF0ECE4), size: 18),
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
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('MENSAGENS'),
                            if (normalConvs.any((c) => c.unread > 0)) ...[
                              const SizedBox(width: 6),
                              Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFD4622A),
                                      shape: BoxShape.circle)),
                            ],
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('TROCAS & VENDAS'),
                            if (tradeConvs.any((c) => c.unread > 0)) ...[
                              const SizedBox(width: 6),
                              Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFD4622A),
                                      shape: BoxShape.circle)),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildConversationList(normalConvs, isTradeTab: false),
                        _buildConversationList(tradeConvs, isTradeTab: true),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: 3,
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
          else if (index == 4)
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const MarketplaceScreen()));
        },
      ),
    );
  }

  Widget _buildConversationList(List<_Conversation> convs,
      {required bool isTradeTab}) {
    if (convs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isTradeTab ? '🔄' : '💬',
                style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text(isTradeTab ? 'NENHUMA TROCA OU VENDA' : 'NENHUMA MENSAGEM',
                style: GoogleFonts.bebasNeue(
                    fontSize: 18,
                    color: const Color(0xFF4A4438),
                    letterSpacing: 2)),
            const SizedBox(height: 8),
            Text(
              isTradeTab
                  ? 'Propostas de troca e venda aparecerão aqui'
                  : 'Inicie uma conversa com um colecionador',
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 13, color: const Color(0xFF4A4438)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 4),
      itemCount: convs.length,
      itemBuilder: (context, index) {
        final conv = convs[index];
        return _ConversationTile(
          conversation: conv,
          isTradeTab: isTradeTab,
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => _ChatScreen(conversation: conv))),
        );
      },
    );
  }
}

// ══════════════════════════════════════
// LAYOUT DESKTOP — sidebar + chat
// ══════════════════════════════════════
class _DesktopLayout extends StatefulWidget {
  final List<_Conversation> conversations;
  final List<_Conversation> normalConvs;
  final List<_Conversation> tradeConvs;
  final TabController tabController;
  final VoidCallback onNewMessage;

  const _DesktopLayout({
    required this.conversations,
    required this.normalConvs,
    required this.tradeConvs,
    required this.tabController,
    required this.onNewMessage,
  });

  @override
  State<_DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<_DesktopLayout> {
  _Conversation? _selected;

  @override
  void initState() {
    super.initState();
    // ✅ Seleciona a primeira conversa por padrão
    if (widget.conversations.isNotEmpty) {
      _selected = widget.conversations.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ✅ Coluna esquerda: lista de conversas (300px)
        Container(
          width: 300,
          decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: Color(0xFF2E2A22))),
          ),
          child: Column(
            children: [
              // Topbar da sidebar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                child: Row(
                  children: [
                    Text('MENSAGENS',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 22,
                            color: const Color(0xFFF0ECE4),
                            letterSpacing: 3)),
                    const Spacer(),
                    GestureDetector(
                      onTap: widget.onNewMessage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1814),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF2E2A22)),
                        ),
                        child: const Icon(Icons.edit_rounded,
                            color: Color(0xFFF0ECE4), size: 18),
                      ),
                    ),
                  ],
                ),
              ),

              // Abas
              TabBar(
                controller: widget.tabController,
                indicatorColor: const Color(0xFFD4622A),
                indicatorWeight: 2,
                labelColor: const Color(0xFFD4622A),
                unselectedLabelColor: const Color(0xFF7A7060),
                labelStyle:
                    GoogleFonts.bebasNeue(fontSize: 11, letterSpacing: 1),
                unselectedLabelStyle:
                    GoogleFonts.bebasNeue(fontSize: 11, letterSpacing: 1),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('MSGS'),
                        if (widget.normalConvs.any((c) => c.unread > 0)) ...[
                          const SizedBox(width: 4),
                          Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFD4622A),
                                  shape: BoxShape.circle)),
                        ],
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('TROCAS'),
                        if (widget.tradeConvs.any((c) => c.unread > 0)) ...[
                          const SizedBox(width: 4),
                          Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFD4622A),
                                  shape: BoxShape.circle)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // Lista de conversas
              Expanded(
                child: TabBarView(
                  controller: widget.tabController,
                  children: [
                    _buildSidebarList(widget.normalConvs, false),
                    _buildSidebarList(widget.tradeConvs, true),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ✅ Coluna direita: chat ou placeholder
        Expanded(
          child: _selected != null
              ? _ChatContent(conversation: _selected!)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('💬', style: TextStyle(fontSize: 56)),
                      const SizedBox(height: 16),
                      Text('SELECIONE UMA CONVERSA',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: const Color(0xFF4A4438),
                              letterSpacing: 2)),
                      const SizedBox(height: 8),
                      Text('Escolha uma conversa na lista à esquerda',
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 13, color: const Color(0xFF4A4438))),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildSidebarList(List<_Conversation> convs, bool isTradeTab) {
    if (convs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isTradeTab ? '🔄' : '💬',
                style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 12),
            Text(isTradeTab ? 'SEM TROCAS' : 'SEM MENSAGENS',
                style: GoogleFonts.bebasNeue(
                    fontSize: 14,
                    color: const Color(0xFF4A4438),
                    letterSpacing: 2)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 4),
      itemCount: convs.length,
      itemBuilder: (context, index) {
        final conv = convs[index];
        final isActive = _selected?.name == conv.name;
        return GestureDetector(
          onTap: () => setState(() => _selected = conv),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              // ✅ Destaca a conversa selecionada
              color: isActive
                  ? const Color(0xFFD4622A).withOpacity(0.08)
                  : Colors.transparent,
              border: Border(
                left: BorderSide(
                    color:
                        isActive ? const Color(0xFFD4622A) : Colors.transparent,
                    width: 2),
                bottom: const BorderSide(color: Color(0xFF1A1814)),
              ),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF242018),
                        border: Border.all(
                          color: conv.unread > 0
                              ? const Color(0xFFD4622A)
                              : const Color(0xFF2E2A22),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                          child: Text(conv.emoji,
                              style: const TextStyle(fontSize: 22))),
                    ),
                    if (conv.online)
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 11,
                          height: 11,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF7A),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFF0F0E0B), width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(conv.name,
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFF0ECE4)),
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(conv.time,
                              style: GoogleFonts.familjenGrotesk(
                                fontSize: 10,
                                color: conv.unread > 0
                                    ? const Color(0xFFD4622A)
                                    : const Color(0xFF4A4438),
                              )),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: Text(conv.lastMessage,
                                style: GoogleFonts.familjenGrotesk(
                                  fontSize: 11,
                                  color: conv.unread > 0
                                      ? const Color(0xFFB0A898)
                                      : const Color(0xFF4A4438),
                                  fontWeight: conv.unread > 0
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                          if (conv.unread > 0) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFD4622A),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text('${conv.unread}',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                              ),
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
        );
      },
    );
  }
}

// ══════════════════════════════════════
// CHAT CONTENT — reutilizado no desktop
// ══════════════════════════════════════
class _ChatContent extends StatefulWidget {
  final _Conversation conversation;
  const _ChatContent({required this.conversation});

  @override
  State<_ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<_ChatContent> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  final List<_Message> _messages = [
    _Message(
        text:
            'Oi! Vi seu Charizard Holo na garagem, ainda está disponível para troca?',
        isMe: false,
        time: '14:22'),
    _Message(
        text: 'Olá! Sim, ainda tenho ele. O que você ofereceria?',
        isMe: true,
        time: '14:24'),
    _Message(
        text: 'Tenho um Blastoise Holo Base Set em Near Mint. Toparia a troca?',
        isMe: false,
        time: '14:25'),
    _Message(
        text: 'Hmm, interessante! Me manda foto do verso também 🎴',
        isMe: true,
        time: '14:26'),
    _Message(
        text: 'Topei! Me manda foto do verso também 🎴',
        isMe: false,
        time: '14:28'),
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(text: text, isMe: true, time: _currentTime()));
      _messageController.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── TOPBAR DO CHAT ──
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFF2E2A22))),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF242018),
                      border: Border.all(
                          color: const Color(0xFFD4622A), width: 1.5),
                    ),
                    child: Center(
                        child: Text(widget.conversation.emoji,
                            style: const TextStyle(fontSize: 20))),
                  ),
                  if (widget.conversation.online)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF7A),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF0F0E0B), width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.conversation.name,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF0ECE4))),
                    const SizedBox(height: 2),
                    Text(
                        widget.conversation.online ? 'Online agora' : 'Offline',
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 11,
                          color: widget.conversation.online
                              ? const Color(0xFF4CAF7A)
                              : const Color(0xFF4A4438),
                        )),
                  ],
                ),
              ),
              if (widget.conversation.isTradeOrSale)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A020).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: const Color(0xFFD4A020).withOpacity(0.4)),
                  ),
                  child: Text('🔄 TROCA',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 9, color: const Color(0xFFD4A020))),
                ),
              const Icon(Icons.more_horiz, color: Color(0xFF7A7060), size: 24),
            ],
          ),
        ),

        // ── MENSAGENS ──
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            itemCount: _messages.length,
            itemBuilder: (context, index) =>
                _MessageBubble(message: _messages[index]),
          ),
        ),

        // ── CAMPO DE MENSAGEM ──
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1814),
            border: Border(top: BorderSide(color: Color(0xFF2E2A22))),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF242018),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF3A3428)),
                  ),
                  child: const Icon(Icons.add_rounded,
                      color: Color(0xFF7A7060), size: 20),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF242018),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF3A3428)),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: GoogleFonts.familjenGrotesk(
                        color: const Color(0xFFF0ECE4), fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Mensagem...',
                      hintStyle: GoogleFonts.familjenGrotesk(
                          color: const Color(0xFF4A4438), fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 11),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xFFD4622A),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── CONVERSATION TILE ──
class _ConversationTile extends StatelessWidget {
  final _Conversation conversation;
  final VoidCallback onTap;
  final bool isTradeTab;

  const _ConversationTile(
      {required this.conversation,
      required this.onTap,
      this.isTradeTab = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFF1A1814))),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF242018),
                    border: Border.all(
                      color: conversation.unread > 0
                          ? const Color(0xFFD4622A)
                          : const Color(0xFF2E2A22),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                      child: Text(conversation.emoji,
                          style: const TextStyle(fontSize: 25))),
                ),
                if (conversation.online)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF7A),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF0F0E0B), width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(conversation.name,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFF0ECE4))),
                      const SizedBox(width: 6),
                      if (isTradeTab)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A020).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('🔄 TROCA',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 8, color: const Color(0xFFD4A020))),
                        ),
                      const Spacer(),
                      Text(conversation.time,
                          style: GoogleFonts.familjenGrotesk(
                            fontSize: 11,
                            color: conversation.unread > 0
                                ? const Color(0xFFD4622A)
                                : const Color(0xFF4A4438),
                          )),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(conversation.lastMessage,
                            style: GoogleFonts.familjenGrotesk(
                              fontSize: 12,
                              color: conversation.unread > 0
                                  ? const Color(0xFFB0A898)
                                  : const Color(0xFF4A4438),
                              fontWeight: conversation.unread > 0
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      if (conversation.unread > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                              color: Color(0xFFD4622A), shape: BoxShape.circle),
                          child: Center(
                            child: Text('${conversation.unread}',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          ),
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
    );
  }
}

// ══════════════════════════════════════
// TELA DE CHAT — Mobile (push route)
// ══════════════════════════════════════
class _ChatScreen extends StatelessWidget {
  final _Conversation conversation;
  const _ChatScreen({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: Column(
          children: [
            // ── TOPBAR com botão voltar ──
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF2E2A22))),
              ),
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
                  Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF242018),
                          border: Border.all(
                              color: const Color(0xFFD4622A), width: 1.5),
                        ),
                        child: Center(
                            child: Text(conversation.emoji,
                                style: const TextStyle(fontSize: 20))),
                      ),
                      if (conversation.online)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF7A),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xFF0F0E0B), width: 1.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(conversation.name,
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFF0ECE4))),
                        const SizedBox(height: 2),
                        Text(conversation.online ? 'Online agora' : 'Offline',
                            style: GoogleFonts.familjenGrotesk(
                              fontSize: 11,
                              color: conversation.online
                                  ? const Color(0xFF4CAF7A)
                                  : const Color(0xFF4A4438),
                            )),
                      ],
                    ),
                  ),
                  if (conversation.isTradeOrSale)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A020).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: const Color(0xFFD4A020).withOpacity(0.4)),
                      ),
                      child: Text('🔄 TROCA',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 9, color: const Color(0xFFD4A020))),
                    ),
                  const Icon(Icons.more_horiz,
                      color: Color(0xFF7A7060), size: 24),
                ],
              ),
            ),
            // ✅ Reutiliza o _ChatContent sem botão voltar
            Expanded(child: _ChatContent(conversation: conversation)),
          ],
        ),
      ),
    );
  }
}

// ── MESSAGE BUBBLE ──
class _MessageBubble extends StatelessWidget {
  final _Message message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color:
              message.isMe ? const Color(0xFFD4622A) : const Color(0xFF1A1814),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isMe ? 16 : 4),
            bottomRight: Radius.circular(message.isMe ? 4 : 16),
          ),
          border:
              message.isMe ? null : Border.all(color: const Color(0xFF2E2A22)),
        ),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(message.text,
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 14,
                  color: message.isMe ? Colors.white : const Color(0xFFF0ECE4),
                  height: 1.4,
                )),
            const SizedBox(height: 5),
            Text(message.time,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: message.isMe
                      ? Colors.white.withOpacity(0.6)
                      : const Color(0xFF4A4438),
                )),
          ],
        ),
      ),
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
          // ✅ No desktop, nav centralizada com largura máxima
          width: isDesktop ? 680.0 : double.infinity,
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
                      letterSpacing: 0.5)),
            ],
          ],
        ),
      ),
    );
  }
}

// ── MODELOS ──
class _Conversation {
  final String emoji, name, lastMessage, time;
  final int unread;
  final bool online, isTradeOrSale;
  const _Conversation(
      {required this.emoji,
      required this.name,
      required this.lastMessage,
      required this.time,
      required this.unread,
      required this.online,
      required this.isTradeOrSale});
}

class _Message {
  final String text, time;
  final bool isMe;
  const _Message({required this.text, required this.time, required this.isMe});
}

class _Follower {
  final String emoji, name, handle;
  final bool online;
  const _Follower(
      {required this.emoji,
      required this.name,
      required this.handle,
      required this.online});
}
