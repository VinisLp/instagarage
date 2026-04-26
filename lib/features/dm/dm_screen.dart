import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/main_layout.dart';

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

  @override
  Widget build(BuildContext context) {
    final normalConvs = _conversations.where((c) => !c.isTradeOrSale).toList();
    final tradeConvs = _conversations.where((c) => c.isTradeOrSale).toList();

    return MainLayout(
      currentIndex: NavIndex.dms,
      child: _buildContent(normalConvs, tradeConvs),
    );
  }

  Widget _buildContent(
      List<_Conversation> normalConvs, List<_Conversation> tradeConvs) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    if (isDesktop) {
      return _DesktopDmLayout(
        conversations: _conversations,
        normalConvs: normalConvs,
        tradeConvs: tradeConvs,
        tabController: _tabController,
      );
    }

    return Column(children: [
      // Topbar mobile
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
        child: Row(children: [
          Text('MENSAGENS',
              style: GoogleFonts.bebasNeue(
                  fontSize: 26,
                  color: const Color(0xFFF0ECE4),
                  letterSpacing: 3)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2E2A22))),
            child: const Icon(Icons.edit_rounded,
                color: Color(0xFFF0ECE4), size: 18),
          ),
        ]),
      ),

      // Abas
      TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFFD4622A),
        indicatorWeight: 2,
        labelColor: const Color(0xFFD4622A),
        unselectedLabelColor: const Color(0xFF7A7060),
        labelStyle: GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5),
        unselectedLabelStyle:
            GoogleFonts.bebasNeue(fontSize: 13, letterSpacing: 1.5),
        tabs: [
          Tab(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('MENSAGENS'),
            if (normalConvs.any((c) => c.unread > 0)) ...[
              const SizedBox(width: 6),
              Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: Color(0xFFD4622A), shape: BoxShape.circle))
            ],
          ])),
          Tab(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('TROCAS & VENDAS'),
            if (tradeConvs.any((c) => c.unread > 0)) ...[
              const SizedBox(width: 6),
              Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: Color(0xFFD4622A), shape: BoxShape.circle))
            ],
          ])),
        ],
      ),

      const SizedBox(height: 4),

      Expanded(
          child: TabBarView(controller: _tabController, children: [
        _buildConvList(normalConvs, false),
        _buildConvList(tradeConvs, true),
      ])),
    ]);
  }

  Widget _buildConvList(List<_Conversation> convs, bool isTradeTab) {
    if (convs.isEmpty) {
      return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(isTradeTab ? '🔄' : '💬', style: const TextStyle(fontSize: 48)),
        const SizedBox(height: 16),
        Text(isTradeTab ? 'NENHUMA TROCA' : 'NENHUMA MENSAGEM',
            style: GoogleFonts.bebasNeue(
                fontSize: 18,
                color: const Color(0xFF4A4438),
                letterSpacing: 2)),
      ]));
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4),
      itemCount: convs.length,
      itemBuilder: (context, index) => _ConversationTile(
        conversation: convs[index],
        isTradeTab: isTradeTab,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => _ChatScreen(conversation: convs[index]))),
      ),
    );
  }
}

// ── Desktop layout ──
class _DesktopDmLayout extends StatefulWidget {
  final List<_Conversation> conversations;
  final List<_Conversation> normalConvs;
  final List<_Conversation> tradeConvs;
  final TabController tabController;
  const _DesktopDmLayout(
      {required this.conversations,
      required this.normalConvs,
      required this.tradeConvs,
      required this.tabController});
  @override
  State<_DesktopDmLayout> createState() => _DesktopDmLayoutState();
}

class _DesktopDmLayoutState extends State<_DesktopDmLayout> {
  _Conversation? _selected;

  @override
  void initState() {
    super.initState();
    if (widget.conversations.isNotEmpty) _selected = widget.conversations.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Lista lateral
      Container(
        width: 300,
        decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: Color(0xFF2E2A22)))),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(children: [
              Text('MENSAGENS',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 22,
                      color: const Color(0xFFF0ECE4),
                      letterSpacing: 3)),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1A1814),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF2E2A22))),
                  child: const Icon(Icons.edit_rounded,
                      color: Color(0xFFF0ECE4), size: 18)),
            ]),
          ),
          TabBar(
            controller: widget.tabController,
            indicatorColor: const Color(0xFFD4622A),
            indicatorWeight: 2,
            labelColor: const Color(0xFFD4622A),
            unselectedLabelColor: const Color(0xFF7A7060),
            labelStyle: GoogleFonts.bebasNeue(fontSize: 11, letterSpacing: 1),
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
                              color: Color(0xFFD4622A), shape: BoxShape.circle))
                    ],
                  ])),
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
                              color: Color(0xFFD4622A), shape: BoxShape.circle))
                    ],
                  ])),
            ],
          ),
          const SizedBox(height: 4),
          Expanded(
              child: TabBarView(controller: widget.tabController, children: [
            _buildSidebarList(widget.normalConvs),
            _buildSidebarList(widget.tradeConvs),
          ])),
        ]),
      ),

      // Chat à direita
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
                    ]))),
    ]);
  }

  Widget _buildSidebarList(List<_Conversation> convs) {
    if (convs.isEmpty) {
      return Center(
          child: Text('SEM MENSAGENS',
              style: GoogleFonts.bebasNeue(
                  fontSize: 14,
                  color: const Color(0xFF4A4438),
                  letterSpacing: 2)));
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
              color: isActive
                  ? const Color(0xFFD4622A).withOpacity(0.08)
                  : Colors.transparent,
              border: Border(
                  left: BorderSide(
                      color: isActive
                          ? const Color(0xFFD4622A)
                          : Colors.transparent,
                      width: 2),
                  bottom: const BorderSide(color: Color(0xFF1A1814))),
            ),
            child: Row(children: [
              Stack(children: [
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
                            width: 1.5)),
                    child: Center(
                        child: Text(conv.emoji,
                            style: const TextStyle(fontSize: 22)))),
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
                                  color: const Color(0xFF0F0E0B), width: 2)))),
              ]),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Expanded(
                          child: Text(conv.name,
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFF0ECE4)),
                              overflow: TextOverflow.ellipsis)),
                      Text(conv.time,
                          style: GoogleFonts.familjenGrotesk(
                              fontSize: 10,
                              color: conv.unread > 0
                                  ? const Color(0xFFD4622A)
                                  : const Color(0xFF4A4438))),
                    ]),
                    const SizedBox(height: 3),
                    Row(children: [
                      Expanded(
                          child: Text(conv.lastMessage,
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 11,
                                  color: conv.unread > 0
                                      ? const Color(0xFFB0A898)
                                      : const Color(0xFF4A4438),
                                  fontWeight: conv.unread > 0
                                      ? FontWeight.w600
                                      : FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
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
                                        fontWeight: FontWeight.w700))))
                      ],
                    ]),
                  ])),
            ]),
          ),
        );
      },
    );
  }
}

// ── Chat Content ──
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
      _messages.add(_Message(text: text, isMe: true, time: _now()));
      _messageController.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients)
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  String _now() {
    final n = DateTime.now();
    return '${n.hour.toString().padLeft(2, '0')}:${n.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Header
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFF2E2A22)))),
        child: Row(children: [
          Stack(children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF242018),
                    border:
                        Border.all(color: const Color(0xFFD4622A), width: 1.5)),
                child: Center(
                    child: Text(widget.conversation.emoji,
                        style: const TextStyle(fontSize: 20)))),
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
                              color: const Color(0xFF0F0E0B), width: 1.5)))),
          ]),
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
                Text(widget.conversation.online ? 'Online agora' : 'Offline',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 11,
                        color: widget.conversation.online
                            ? const Color(0xFF4CAF7A)
                            : const Color(0xFF4A4438))),
              ])),
          const Icon(Icons.more_horiz, color: Color(0xFF7A7060), size: 24),
        ]),
      ),

      // Mensagens
      Expanded(
          child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  _MessageBubble(message: _messages[index]))),

      // Input
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
            color: Color(0xFF1A1814),
            border: Border(top: BorderSide(color: Color(0xFF2E2A22)))),
        child: Row(children: [
          Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFF242018),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF3A3428))),
              child: const Icon(Icons.add_rounded,
                  color: Color(0xFF7A7060), size: 20)),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFF242018),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF3A3428))),
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
                        horizontal: 16, vertical: 11)),
                onSubmitted: (_) => _sendMessage()),
          )),
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
                      color: Colors.white, size: 18))),
        ]),
      ),
    ]);
  }
}

// ── Chat Screen Mobile ──
class _ChatScreen extends StatelessWidget {
  final _Conversation conversation;
  const _ChatScreen({required this.conversation});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
          child: Column(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF2E2A22)))),
          child: Row(children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF2E2A22))),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFFF0ECE4), size: 16))),
            const SizedBox(width: 12),
            Stack(children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF242018),
                      border: Border.all(
                          color: const Color(0xFFD4622A), width: 1.5)),
                  child: Center(
                      child: Text(conversation.emoji,
                          style: const TextStyle(fontSize: 20)))),
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
                                color: const Color(0xFF0F0E0B), width: 1.5)))),
            ]),
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
                  Text(conversation.online ? 'Online agora' : 'Offline',
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11,
                          color: conversation.online
                              ? const Color(0xFF4CAF7A)
                              : const Color(0xFF4A4438))),
                ])),
            const Icon(Icons.more_horiz, color: Color(0xFF7A7060), size: 24),
          ]),
        ),
        Expanded(child: _ChatContent(conversation: conversation)),
      ])),
    );
  }
}

// ── Conversation Tile ──
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
              border: Border(bottom: BorderSide(color: Color(0xFF1A1814)))),
          child: Row(children: [
            Stack(children: [
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
                          width: 1.5)),
                  child: Center(
                      child: Text(conversation.emoji,
                          style: const TextStyle(fontSize: 25)))),
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
                                color: const Color(0xFF0F0E0B), width: 2)))),
            ]),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(children: [
                    Text(conversation.name,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF0ECE4))),
                    const Spacer(),
                    Text(conversation.time,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 11,
                            color: conversation.unread > 0
                                ? const Color(0xFFD4622A)
                                : const Color(0xFF4A4438))),
                  ]),
                  const SizedBox(height: 5),
                  Row(children: [
                    Expanded(
                        child: Text(conversation.lastMessage,
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 12,
                                color: conversation.unread > 0
                                    ? const Color(0xFFB0A898)
                                    : const Color(0xFF4A4438),
                                fontWeight: conversation.unread > 0
                                    ? FontWeight.w600
                                    : FontWeight.normal),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
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
                                      fontWeight: FontWeight.w700))))
                    ],
                  ]),
                ])),
          ]),
        ));
  }
}

// ── Message Bubble ──
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
              bottomRight: Radius.circular(message.isMe ? 4 : 16)),
          border:
              message.isMe ? null : Border.all(color: const Color(0xFF2E2A22)),
        ),
        child: Column(
            crossAxisAlignment: message.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(message.text,
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 14,
                      color:
                          message.isMe ? Colors.white : const Color(0xFFF0ECE4),
                      height: 1.4)),
              const SizedBox(height: 5),
              Text(message.time,
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: message.isMe
                          ? Colors.white.withOpacity(0.6)
                          : const Color(0xFF4A4438))),
            ]),
      ),
    );
  }
}

// ── Modelos ──
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
