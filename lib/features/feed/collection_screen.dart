import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../piece/ai_scan_screen.dart';

// ═══════════════════════════════════════════════════════════════════
// DASHBOARD DA COLEÇÃO
// ═══════════════════════════════════════════════════════════════════

// IDs dos cards disponíveis para o topo
enum DashCard {
  totalPecas,
  valorTotal,
  aVenda,
  leiloes,
  trocas,
  categorias,
  valorMedio,
  maisValiosa
}

const _cardMeta = {
  DashCard.totalPecas: (
    icon: '🏆',
    label: 'TOTAL DE PEÇAS',
    value: '127',
    color: Color(0xFFD4622A)
  ),
  DashCard.valorTotal: (
    icon: '💰',
    label: 'VALOR TOTAL',
    value: 'R\$ 48.200',
    color: Color(0xFF4CAF7A)
  ),
  DashCard.aVenda: (
    icon: '🏪',
    label: 'À VENDA',
    value: '8',
    color: Color(0xFFD4A020)
  ),
  DashCard.leiloes: (
    icon: '🔨',
    label: 'LEILÕES ATIVOS',
    value: '3',
    color: Color(0xFF4A8FD4)
  ),
  DashCard.trocas: (
    icon: '🔄',
    label: 'TROCAS',
    value: '5',
    color: Color(0xFF9B59B6)
  ),
  DashCard.categorias: (
    icon: '🗂️',
    label: 'CATEGORIAS',
    value: '6',
    color: Color(0xFF1ABC9C)
  ),
  DashCard.valorMedio: (
    icon: '📊',
    label: 'VALOR MÉDIO',
    value: 'R\$ 380',
    color: Color(0xFFE74C3C)
  ),
  DashCard.maisValiosa: (
    icon: '💎',
    label: 'MAIS VALIOSA',
    value: 'R\$ 4.200',
    color: Color(0xFFD4622A)
  ),
};

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});
  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Cards visíveis no topo (customizável)
  List<DashCard> _visibleCards = [
    DashCard.totalPecas,
    DashCard.valorTotal,
    DashCard.aVenda,
    DashCard.leiloes,
    DashCard.trocas,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openCardCustomizer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheet) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                    color: const Color(0xFF3A3428),
                    borderRadius: BorderRadius.circular(2))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Text('PERSONALIZAR CARDS',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 18,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2)),
                  const Spacer(),
                  Text('máx. 6',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 9, color: const Color(0xFF7A7060))),
                ])),
            const SizedBox(height: 4),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Escolha até 6 métricas para exibir no topo',
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12, color: const Color(0xFF7A7060)))),
            const SizedBox(height: 16),
            ...DashCard.values.map((card) {
              final meta = _cardMeta[card]!;
              final selected = _visibleCards.contains(card);
              return GestureDetector(
                onTap: () => setSheet(() {
                  if (selected) {
                    if (_visibleCards.length > 1)
                      setState(() => _visibleCards.remove(card));
                  } else {
                    if (_visibleCards.length < 6)
                      setState(() => _visibleCards.add(card));
                  }
                }),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      color: selected
                          ? meta.color.withOpacity(0.1)
                          : const Color(0xFF242018),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: selected
                              ? meta.color.withOpacity(0.4)
                              : const Color(0xFF2E2A22))),
                  child: Row(children: [
                    Text(meta.icon, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(meta.label,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 13,
                                  letterSpacing: 1,
                                  color: selected
                                      ? const Color(0xFFF0ECE4)
                                      : const Color(0xFF7A7060))),
                          Text(meta.value,
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 11,
                                  color: const Color(0xFF7A7060))),
                        ])),
                    Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            color: selected ? meta.color : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: selected
                                    ? meta.color
                                    : const Color(0xFF4A4438),
                                width: 1.5)),
                        child: selected
                            ? const Icon(Icons.check_rounded,
                                color: Colors.white, size: 13)
                            : null),
                  ]),
                ),
              );
            }),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final crossCount = isDesktop ? 4 : 2;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: Column(children: [
          // ── HEADER ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF2E2A22))),
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Color(0xFFF0ECE4), size: 18)),
              ),
              const SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('DASHBOARD DA COLEÇÃO',
                    style: GoogleFonts.bebasNeue(
                        fontSize: isDesktop ? 22 : 18,
                        color: const Color(0xFFD4622A),
                        letterSpacing: 2)),
                Text('última atualização: hoje às 20h53',
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 8,
                        color: const Color(0xFF4A4438),
                        letterSpacing: 0.5)),
              ]),
              const Spacer(),
              // Botão personalizar cards
              GestureDetector(
                onTap: _openCardCustomizer,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1A1814),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF2E2A22))),
                  child: Row(children: [
                    const Icon(Icons.tune_rounded,
                        color: Color(0xFFD4622A), size: 15),
                    const SizedBox(width: 6),
                    Text('CARDS',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 12,
                            letterSpacing: 1,
                            color: const Color(0xFFB0A898))),
                  ]),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AiScanScreen())),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD4622A),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    const Icon(Icons.add, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text('NOVA PEÇA',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 13,
                            letterSpacing: 1.5,
                            color: Colors.white)),
                  ]),
                ),
              ),
            ]),
          ),

          const SizedBox(height: 20),

          // ── CARDS (customizáveis, grid) ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: isDesktop ? 2.4 : 1.7,
              ),
              itemCount: _visibleCards.length,
              itemBuilder: (context, index) {
                final card = _visibleCards[index];
                final meta = _cardMeta[card]!;
                return _DashStatCard(
                  icon: meta.icon,
                  label: meta.label,
                  value: meta.value,
                  color: meta.color,
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // ── TABS ──
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: const Color(0xFF1A1814),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2E2A22))),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicator: BoxDecoration(
                  color: const Color(0xFFD4622A),
                  borderRadius: BorderRadius.circular(8)),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              padding: const EdgeInsets.all(4),
              labelStyle: GoogleFonts.bebasNeue(fontSize: 12, letterSpacing: 1),
              unselectedLabelStyle:
                  GoogleFonts.bebasNeue(fontSize: 12, letterSpacing: 1),
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFF7A7060),
              tabs: const [
                Tab(text: 'PEÇAS'),
                Tab(text: 'VISÃO GERAL'),
                Tab(text: 'VENDAS'),
                Tab(text: 'COMPRAS'),
                Tab(text: 'LEILÕES'),
                Tab(text: 'ÁLBUNS'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── CONTEÚDO ──
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _PecasTab(isDesktop: isDesktop),
                _VisaoGeralTab(isDesktop: isDesktop),
                _TransacoesTab(tipo: 'vendas', isDesktop: isDesktop),
                _TransacoesTab(tipo: 'compras', isDesktop: isDesktop),
                _LeiloesTab(isDesktop: isDesktop),
                _AlbunsTab(isDesktop: isDesktop),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// ── Card de estatística ──
class _DashStatCard extends StatelessWidget {
  final String icon, label, value;
  final Color color;
  const _DashStatCard(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.25))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(icon, style: const TextStyle(fontSize: 14)))),
              const Spacer(),
              Container(
                  width: 6,
                  height: 6,
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle)),
            ]),
            const SizedBox(height: 8),
            Text(value,
                style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    color: const Color(0xFFF0ECE4),
                    letterSpacing: 0.5)),
            Text(label,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 8,
                    color: const Color(0xFF7A7060),
                    letterSpacing: 0.3)),
          ]),
    );
  }
}

// ═══════════════════════════
// ABA: PEÇAS
// ═══════════════════════════
class _PecasTab extends StatefulWidget {
  final bool isDesktop;
  const _PecasTab({required this.isDesktop});
  @override
  State<_PecasTab> createState() => _PecasTabState();
}

class _PecasTabState extends State<_PecasTab> {
  int _viewMode = 0; // 0=lista, 1=grid

  static final _categorias = [
    (
      nome: 'Pokémon TCG',
      emoji: '🐲',
      qtd: 34,
      valor: 'R\$ 18.400',
      cor: const Color(0xFFD4622A)
    ),
    (
      nome: 'Vinil & Records',
      emoji: '🎸',
      qtd: 28,
      valor: 'R\$ 12.200',
      cor: const Color(0xFF4CAF7A)
    ),
    (
      nome: 'HQs & Comics',
      emoji: '🦸',
      qtd: 22,
      valor: 'R\$ 8.600',
      cor: const Color(0xFF4A8FD4)
    ),
    (
      nome: 'Miniaturas',
      emoji: '🚗',
      qtd: 18,
      valor: 'R\$ 6.100',
      cor: const Color(0xFFD4A020)
    ),
    (
      nome: 'Selos & Moedas',
      emoji: '📮',
      qtd: 14,
      valor: 'R\$ 2.300',
      cor: const Color(0xFF9B59B6)
    ),
    (
      nome: 'Outros',
      emoji: '📦',
      qtd: 11,
      valor: 'R\$ 600',
      cor: const Color(0xFF7A7060)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // View mode toggle
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          Text('POR CATEGORIA',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: const Color(0xFF7A7060),
                  letterSpacing: 1.5)),
          const Spacer(),
          _ViewToggle(
              mode: _viewMode, onChange: (v) => setState(() => _viewMode = v)),
        ]),
      ),
      const SizedBox(height: 12),
      Expanded(
          child: _viewMode == 0
              ? ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _categorias.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final c = _categorias[i];
                    return _CategoriaListTile(
                        nome: c.nome,
                        emoji: c.emoji,
                        qtd: c.qtd,
                        valor: c.valor,
                        cor: c.cor,
                        total: 127);
                  })
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.isDesktop ? 3 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.4),
                  itemCount: _categorias.length,
                  itemBuilder: (context, i) {
                    final c = _categorias[i];
                    return _CategoriaGridTile(
                        nome: c.nome,
                        emoji: c.emoji,
                        qtd: c.qtd,
                        valor: c.valor,
                        cor: c.cor,
                        total: 127);
                  })),
    ]);
  }
}

class _ViewToggle extends StatelessWidget {
  final int mode;
  final ValueChanged<int> onChange;
  const _ViewToggle({required this.mode, required this.onChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Row(children: [
        _ToggleBtn(
            icon: Icons.view_list_rounded,
            active: mode == 0,
            onTap: () => onChange(0)),
        const SizedBox(width: 2),
        _ToggleBtn(
            icon: Icons.grid_view_rounded,
            active: mode == 1,
            onTap: () => onChange(1)),
      ]),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _ToggleBtn(
      {required this.icon, required this.active, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 26,
        decoration: BoxDecoration(
            color: active ? const Color(0xFFD4622A) : Colors.transparent,
            borderRadius: BorderRadius.circular(6)),
        child: Icon(icon,
            color: active ? Colors.white : const Color(0xFF7A7060), size: 15),
      ),
    );
  }
}

class _CategoriaListTile extends StatelessWidget {
  final String nome, emoji, valor;
  final int qtd, total;
  final Color cor;
  const _CategoriaListTile(
      {required this.nome,
      required this.emoji,
      required this.qtd,
      required this.valor,
      required this.cor,
      required this.total});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Row(children: [
        Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: cor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 22)))),
        const SizedBox(width: 14),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(nome,
                style: GoogleFonts.familjenGrotesk(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF0ECE4))),
            const Spacer(),
            Text(valor,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 10, color: const Color(0xFF4CAF7A))),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                        value: qtd / total,
                        backgroundColor: const Color(0xFF2E2A22),
                        valueColor: AlwaysStoppedAnimation<Color>(cor),
                        minHeight: 4))),
            const SizedBox(width: 10),
            Text('$qtd peças',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 9, color: const Color(0xFF7A7060))),
          ]),
        ])),
      ]),
    );
  }
}

class _CategoriaGridTile extends StatelessWidget {
  final String nome, emoji, valor;
  final int qtd, total;
  final Color cor;
  const _CategoriaGridTile(
      {required this.nome,
      required this.emoji,
      required this.qtd,
      required this.valor,
      required this.cor,
      required this.total});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cor.withOpacity(0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const Spacer(),
          Text(valor,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9, color: const Color(0xFF4CAF7A))),
        ]),
        const Spacer(),
        Text(nome,
            style: GoogleFonts.familjenGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF0ECE4))),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                      value: qtd / total,
                      backgroundColor: const Color(0xFF2E2A22),
                      valueColor: AlwaysStoppedAnimation<Color>(cor),
                      minHeight: 3))),
          const SizedBox(width: 8),
          Text('$qtd', style: GoogleFonts.bebasNeue(fontSize: 13, color: cor)),
        ]),
      ]),
    );
  }
}

// ═══════════════════════════
// ABA: VISÃO GERAL (gráficos)
// ═══════════════════════════
class _VisaoGeralTab extends StatelessWidget {
  final bool isDesktop;
  const _VisaoGeralTab({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Distribuição por categoria (donut-style barras)
        Text('DISTRIBUIÇÃO POR CATEGORIA',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 9,
                color: const Color(0xFF7A7060),
                letterSpacing: 1.5)),
        const SizedBox(height: 14),
        _DonutChart(),
        const SizedBox(height: 24),

        // Evolução de valor (barras mensais)
        Text('EVOLUÇÃO DO VALOR (6 MESES)',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 9,
                color: const Color(0xFF7A7060),
                letterSpacing: 1.5)),
        const SizedBox(height: 14),
        _BarChart(),
        const SizedBox(height: 24),

        // Atividade recente (linha do tempo mini)
        Text('ATIVIDADE DA COLEÇÃO',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 9,
                color: const Color(0xFF7A7060),
                letterSpacing: 1.5)),
        const SizedBox(height: 14),
        _ActivityTimeline(),
        const SizedBox(height: 24),

        // Métricas extras
        Text('MÉTRICAS DETALHADAS',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 9,
                color: const Color(0xFF7A7060),
                letterSpacing: 1.5)),
        const SizedBox(height: 14),
        _MetricasGrid(isDesktop: isDesktop),
        const SizedBox(height: 24),
      ]),
    );
  }
}

// Gráfico donut customizado (puro Flutter)
class _DonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = [
      (label: 'Pokémon TCG', value: 34, color: const Color(0xFFD4622A)),
      (label: 'Vinil & Records', value: 28, color: const Color(0xFF4CAF7A)),
      (label: 'HQs & Comics', value: 22, color: const Color(0xFF4A8FD4)),
      (label: 'Miniaturas', value: 18, color: const Color(0xFFD4A020)),
      (label: 'Selos & Moedas', value: 14, color: const Color(0xFF9B59B6)),
      (label: 'Outros', value: 11, color: const Color(0xFF7A7060)),
    ];
    final total = data.fold(0, (a, b) => a + b.value);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Row(children: [
        // Donut
        SizedBox(
            width: 130,
            height: 130,
            child: CustomPaint(
                painter: _DonutPainter(data
                    .map((d) => (value: d.value / total, color: d.color))
                    .toList()),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text('127',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 24, color: const Color(0xFFF0ECE4))),
                      Text('PEÇAS',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 8, color: const Color(0xFF7A7060))),
                    ])))),
        const SizedBox(width: 24),
        // Legenda
        Expanded(
            child: Column(
                children: data
                    .map((d) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(children: [
                            Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: d.color,
                                    borderRadius: BorderRadius.circular(2))),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(d.label,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 11,
                                        color: const Color(0xFFB0A898)))),
                            Text('${(d.value / total * 100).round()}%',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 9, color: d.color)),
                          ]),
                        ))
                    .toList())),
      ]),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<({double value, Color color})> slices;
  _DonutPainter(this.slices);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const strokeWidth = 18.0;
    const gap = 0.04;
    var startAngle = -math.pi / 2;

    for (final slice in slices) {
      final sweepAngle = (slice.value * 2 * math.pi) - gap;
      if (sweepAngle <= 0) continue;
      final paint = Paint()
        ..color = slice.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle + gap / 2,
        sweepAngle,
        false,
        paint,
      );
      startAngle += slice.value * 2 * math.pi;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Gráfico de barras mensais
class _BarChart extends StatelessWidget {
  static const _months = ['Nov', 'Dez', 'Jan', 'Fev', 'Mar', 'Abr'];
  static const _values = [32000.0, 35500.0, 38200.0, 40100.0, 44800.0, 48200.0];

  @override
  Widget build(BuildContext context) {
    final maxVal = _values.reduce(math.max);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Column(children: [
        // Barras
        SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_months.length, (i) {
              final pct = _values[i] / maxVal;
              final isLast = i == _months.length - 1;
              return Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if (isLast) ...[
                    Text('R\$ 48.2k',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 8, color: const Color(0xFFD4622A))),
                    const SizedBox(height: 3),
                  ],
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    height: 80 * pct,
                    decoration: BoxDecoration(
                        color: isLast
                            ? const Color(0xFFD4622A)
                            : const Color(0xFF3A3020),
                        borderRadius: BorderRadius.circular(4),
                        border: isLast
                            ? null
                            : Border.all(color: const Color(0xFF4A4030))),
                  ),
                ]),
              ));
            }),
          ),
        ),
        const SizedBox(height: 8),
        // Labels
        Row(
            children: _months
                .map((m) => Expanded(
                    child: Text(m,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9, color: const Color(0xFF7A7060)))))
                .toList()),
        const SizedBox(height: 12),
        // Variação
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: const Color(0xFF4CAF7A).withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: const Color(0xFF4CAF7A).withOpacity(0.2))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.trending_up_rounded,
                  color: Color(0xFF4CAF7A), size: 14),
              const SizedBox(width: 6),
              Text('▲ R\$ 16.200 (50,6%) em 6 meses',
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 11, color: const Color(0xFF4CAF7A))),
            ])),
      ]),
    );
  }
}

// Timeline de atividade
class _ActivityTimeline extends StatelessWidget {
  static final _events = [
    (
      emoji: '🐲',
      text: 'Adicionou Charizard Holo Base Set',
      valor: '+R\$ 3.800',
      data: 'hoje',
      cor: const Color(0xFFD4622A)
    ),
    (
      emoji: '✅',
      text: 'Vendeu Ferrari 250 GTO Miniatura',
      valor: '+R\$ 4.200',
      data: 'ontem',
      cor: const Color(0xFF4CAF7A)
    ),
    (
      emoji: '🔨',
      text: 'Abriu leilão Camisa Brasil 1970',
      valor: 'mín. R\$ 2.000',
      data: '2d atrás',
      cor: const Color(0xFF4A8FD4)
    ),
    (
      emoji: '🎸',
      text: 'Avaliou Led Zeppelin IV',
      valor: 'Near Mint',
      data: '5d atrás',
      cor: const Color(0xFFD4A020)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Column(
          children: List.generate(_events.length, (i) {
        final e = _events[i];
        final isLast = i == _events.length - 1;
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(children: [
            Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: e.cor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child:
                        Text(e.emoji, style: const TextStyle(fontSize: 16)))),
            if (!isLast)
              Container(width: 1, height: 28, color: const Color(0xFF2E2A22)),
          ]),
          const SizedBox(width: 12),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(e.text,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12, color: const Color(0xFFF0ECE4))),
                    const SizedBox(height: 3),
                    Text(e.data,
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9, color: const Color(0xFF4A4438))),
                  ])),
              const SizedBox(width: 10),
              Text(e.valor,
                  style: GoogleFonts.jetBrainsMono(fontSize: 10, color: e.cor)),
            ]),
          )),
        ]);
      })),
    );
  }
}

// Grid de métricas extras
class _MetricasGrid extends StatelessWidget {
  final bool isDesktop;
  const _MetricasGrid({required this.isDesktop});

  static final _metricas = [
    (
      label: 'Peça mais valiosa',
      value: 'Charizard Holo',
      sub: 'R\$ 4.200',
      emoji: '💎'
    ),
    (
      label: 'Categoria top',
      value: 'Pokémon TCG',
      sub: '26,8% do total',
      emoji: '🏆'
    ),
    (
      label: 'Taxa de venda',
      value: '87%',
      sub: 'Itens à venda vendidos',
      emoji: '📈'
    ),
    (
      label: 'Retorno médio',
      value: '+22%',
      sub: 'Sobre valor pago',
      emoji: '💹'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isDesktop ? 4 : 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5),
      itemCount: _metricas.length,
      itemBuilder: (context, i) {
        final m = _metricas[i];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: const Color(0xFF1A1814),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2E2A22))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(m.emoji, style: const TextStyle(fontSize: 18)),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(m.value,
                      style: GoogleFonts.bebasNeue(
                          fontSize: 18,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 0.5)),
                  Text(m.label,
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 8, color: const Color(0xFF7A7060))),
                  Text(m.sub,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 10, color: const Color(0xFF4CAF7A))),
                ]),
              ]),
        );
      },
    );
  }
}

// ═══════════════════════════
// ABA: VENDAS / COMPRAS
// ═══════════════════════════
class _TransacoesTab extends StatefulWidget {
  final String tipo;
  final bool isDesktop;
  const _TransacoesTab({required this.tipo, required this.isDesktop});
  @override
  State<_TransacoesTab> createState() => _TransacoesTabState();
}

class _TransacoesTabState extends State<_TransacoesTab> {
  int _viewMode = 0;

  static final _vendas = [
    (
      nome: 'Ferrari 250 GTO Miniatura',
      emoji: '🚗',
      status: 'Vendida',
      valor: 'R\$ 4.200',
      ok: true
    ),
    (
      nome: 'Charizard Holo Base Set',
      emoji: '🐲',
      status: 'Aguardando envio',
      valor: 'R\$ 3.800',
      ok: false
    ),
    (
      nome: 'Led Zeppelin IV - 1971',
      emoji: '🎸',
      status: 'Confirmando recebimento',
      valor: 'R\$ 1.200',
      ok: false
    ),
  ];
  static final _compras = [
    (
      nome: 'Amazing Fantasy #15',
      emoji: '🦸',
      status: 'Recebida',
      valor: 'R\$ 890',
      ok: true
    ),
    (
      nome: 'Camisa Brasil 1970',
      emoji: '👕',
      status: 'Em trânsito',
      valor: 'R\$ 2.100',
      ok: false
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final items = widget.tipo == 'vendas' ? _vendas : _compras;
    final isVenda = widget.tipo == 'vendas';

    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Text(isVenda ? 'SUAS VENDAS' : 'SUAS COMPRAS',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    color: const Color(0xFF7A7060),
                    letterSpacing: 1.5)),
            const Spacer(),
            _ViewToggle(
                mode: _viewMode,
                onChange: (v) => setState(() => _viewMode = v)),
          ])),
      const SizedBox(height: 12),
      Expanded(
          child: _viewMode == 0
              ? ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return _TransacaoListTile(
                        nome: item.nome,
                        emoji: item.emoji,
                        status: item.status,
                        valor: item.valor,
                        ok: item.ok,
                        isVenda: isVenda);
                  })
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.isDesktop ? 3 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.3),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return _TransacaoGridTile(
                        nome: item.nome,
                        emoji: item.emoji,
                        status: item.status,
                        valor: item.valor,
                        ok: item.ok,
                        isVenda: isVenda);
                  })),
    ]);
  }
}

class _TransacaoListTile extends StatelessWidget {
  final String nome, emoji, status, valor;
  final bool ok, isVenda;
  const _TransacaoListTile(
      {required this.nome,
      required this.emoji,
      required this.status,
      required this.valor,
      required this.ok,
      required this.isVenda});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Row(children: [
        Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xFF242018),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 22)))),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(nome,
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF0ECE4))),
          const SizedBox(height: 5),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  color: ok
                      ? const Color(0xFF4CAF7A).withOpacity(0.12)
                      : const Color(0xFFD4A020).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6)),
              child: Text(status,
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: ok
                          ? const Color(0xFF4CAF7A)
                          : const Color(0xFFD4A020)))),
        ])),
        Text(valor,
            style: GoogleFonts.bebasNeue(
                fontSize: 16,
                color:
                    isVenda ? const Color(0xFF4CAF7A) : const Color(0xFFD4622A),
                letterSpacing: 0.5)),
      ]),
    );
  }
}

class _TransacaoGridTile extends StatelessWidget {
  final String nome, emoji, status, valor;
  final bool ok, isVenda;
  const _TransacaoGridTile(
      {required this.nome,
      required this.emoji,
      required this.status,
      required this.valor,
      required this.ok,
      required this.isVenda});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const Spacer(),
          Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  color: ok ? const Color(0xFF4CAF7A) : const Color(0xFFD4A020),
                  shape: BoxShape.circle)),
        ]),
        const Spacer(),
        Text(nome,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.familjenGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF0ECE4))),
        const SizedBox(height: 4),
        Text(valor,
            style: GoogleFonts.bebasNeue(
                fontSize: 15,
                color: isVenda
                    ? const Color(0xFF4CAF7A)
                    : const Color(0xFFD4622A))),
        Text(status,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 8, color: const Color(0xFF7A7060))),
      ]),
    );
  }
}

// ═══════════════════════════
// ABA: LEILÕES
// ═══════════════════════════
class _LeiloesTab extends StatefulWidget {
  final bool isDesktop;
  const _LeiloesTab({required this.isDesktop});
  @override
  State<_LeiloesTab> createState() => _LeiloesTabState();
}

class _LeiloesTabState extends State<_LeiloesTab> {
  int _viewMode = 0;

  static final _leiloes = [
    (
      emoji: '👕',
      nome: 'Camisa Brasil 1970 Original',
      lance: 'R\$ 3.400',
      lances: 12,
      tempo: '2h 34min',
      ativo: true
    ),
    (
      emoji: '🏎️',
      nome: 'Hot Wheels Redline 1969',
      lance: 'R\$ 780',
      lances: 5,
      tempo: '1d 12h',
      ativo: true
    ),
    (
      emoji: '🎸',
      nome: 'The Beatles - Abbey Road',
      lance: 'R\$ 2.100',
      lances: 18,
      tempo: 'Encerrado',
      ativo: false
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Text('SEUS LEILÕES',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    color: const Color(0xFF7A7060),
                    letterSpacing: 1.5)),
            const Spacer(),
            _ViewToggle(
                mode: _viewMode,
                onChange: (v) => setState(() => _viewMode = v)),
          ])),
      const SizedBox(height: 12),
      Expanded(
          child: _viewMode == 0
              ? ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _leiloes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final l = _leiloes[i];
                    return _LeilaoListTile(
                        emoji: l.emoji,
                        nome: l.nome,
                        lance: l.lance,
                        lances: l.lances,
                        tempo: l.tempo,
                        ativo: l.ativo);
                  })
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.isDesktop ? 3 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.2),
                  itemCount: _leiloes.length,
                  itemBuilder: (context, i) {
                    final l = _leiloes[i];
                    return _LeilaoGridTile(
                        emoji: l.emoji,
                        nome: l.nome,
                        lance: l.lance,
                        lances: l.lances,
                        tempo: l.tempo,
                        ativo: l.ativo);
                  })),
    ]);
  }
}

class _LeilaoListTile extends StatelessWidget {
  final String emoji, nome, lance, tempo;
  final int lances;
  final bool ativo;
  const _LeilaoListTile(
      {required this.emoji,
      required this.nome,
      required this.lance,
      required this.lances,
      required this.tempo,
      required this.ativo});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: ativo
                  ? const Color(0xFF4A8FD4).withOpacity(0.35)
                  : const Color(0xFF2E2A22))),
      child: Row(children: [
        Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xFF242018),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 22)))),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(nome,
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF0ECE4))),
          const SizedBox(height: 5),
          Row(children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                    color: ativo
                        ? const Color(0xFF4A8FD4).withOpacity(0.12)
                        : const Color(0xFF2E2A22),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(ativo ? '🔴 AO VIVO' : 'ENCERRADO',
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 8,
                        color: ativo
                            ? const Color(0xFF4A8FD4)
                            : const Color(0xFF7A7060)))),
            const SizedBox(width: 8),
            Text('$lances lances',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 8, color: const Color(0xFF7A7060))),
          ]),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(lance,
              style: GoogleFonts.bebasNeue(
                  fontSize: 16,
                  color: const Color(0xFFD4622A),
                  letterSpacing: 0.5)),
          Text(tempo,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: ativo
                      ? const Color(0xFFD4A020)
                      : const Color(0xFF7A7060))),
        ]),
      ]),
    );
  }
}

class _LeilaoGridTile extends StatelessWidget {
  final String emoji, nome, lance, tempo;
  final int lances;
  final bool ativo;
  const _LeilaoGridTile(
      {required this.emoji,
      required this.nome,
      required this.lance,
      required this.lances,
      required this.tempo,
      required this.ativo});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: ativo
                  ? const Color(0xFF4A8FD4).withOpacity(0.3)
                  : const Color(0xFF2E2A22))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: ativo
                      ? const Color(0xFF4A8FD4).withOpacity(0.12)
                      : const Color(0xFF2E2A22),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(ativo ? '🔴 VIVO' : 'FIM',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 7,
                      color: ativo
                          ? const Color(0xFF4A8FD4)
                          : const Color(0xFF7A7060)))),
        ]),
        const Spacer(),
        Text(nome,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.familjenGrotesk(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF0ECE4))),
        const SizedBox(height: 4),
        Text(lance,
            style: GoogleFonts.bebasNeue(
                fontSize: 16, color: const Color(0xFFD4622A))),
        Text('$lances lances · $tempo',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 8, color: const Color(0xFF7A7060))),
      ]),
    );
  }
}

// ═══════════════════════════
// ABA: ÁLBUNS
// ═══════════════════════════
class _AlbunsTab extends StatefulWidget {
  final bool isDesktop;
  const _AlbunsTab({required this.isDesktop});
  @override
  State<_AlbunsTab> createState() => _AlbunsTabState();
}

class _AlbunsTabState extends State<_AlbunsTab> {
  int _viewMode = 1; // grid default

  static final _albuns = [
    (
      nome: 'TCG Collection 2024',
      emoji: '🐲',
      qtd: 34,
      categoria: 'Pokémon TCG'
    ),
    (nome: 'Vinis Raros', emoji: '🎸', qtd: 28, categoria: 'Vinil & Records'),
    (nome: 'HQs Marvel', emoji: '🦸', qtd: 12, categoria: 'HQs & Comics'),
    (nome: 'Miniaturas Ferrari', emoji: '🚗', qtd: 8, categoria: 'Miniaturas'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Text('SEUS ÁLBUNS',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    color: const Color(0xFF7A7060),
                    letterSpacing: 1.5)),
            const Spacer(),
            _ViewToggle(
                mode: _viewMode,
                onChange: (v) => setState(() => _viewMode = v)),
          ])),
      const SizedBox(height: 12),
      Expanded(
          child: _viewMode == 0
              ? ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _albuns.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    if (i == _albuns.length) return _NovoAlbumListTile();
                    final a = _albuns[i];
                    return _AlbumListTile(
                        nome: a.nome,
                        emoji: a.emoji,
                        qtd: a.qtd,
                        categoria: a.categoria);
                  })
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.isDesktop ? 4 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.1),
                  itemCount: _albuns.length + 1,
                  itemBuilder: (context, i) {
                    if (i == _albuns.length) return _NovoAlbumGridTile();
                    final a = _albuns[i];
                    return _AlbumGridTile(
                        nome: a.nome,
                        emoji: a.emoji,
                        qtd: a.qtd,
                        categoria: a.categoria);
                  })),
    ]);
  }
}

class _AlbumListTile extends StatelessWidget {
  final String nome, emoji, categoria;
  final int qtd;
  const _AlbumListTile(
      {required this.nome,
      required this.emoji,
      required this.qtd,
      required this.categoria});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Row(children: [
        Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xFF242018),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 22)))),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(nome,
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF0ECE4))),
          Text(categoria,
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 11, color: const Color(0xFF7A7060))),
        ])),
        Text('$qtd peças',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 10, color: const Color(0xFFD4622A))),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward_ios_rounded,
            color: Color(0xFF4A4438), size: 13),
      ]),
    );
  }
}

class _AlbumGridTile extends StatelessWidget {
  final String nome, emoji, categoria;
  final int qtd;
  const _AlbumGridTile(
      {required this.nome,
      required this.emoji,
      required this.qtd,
      required this.categoria});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2E2A22))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const Spacer(),
        Text(nome,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.familjenGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF0ECE4))),
        Text(categoria,
            style: GoogleFonts.familjenGrotesk(
                fontSize: 10, color: const Color(0xFF7A7060))),
        const SizedBox(height: 4),
        Text('$qtd peças',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 9, color: const Color(0xFFD4622A))),
      ]),
    );
  }
}

class _NovoAlbumListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD4622A).withOpacity(0.25))),
      child: Row(children: [
        Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xFFD4622A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.add_rounded,
                color: Color(0xFFD4622A), size: 22)),
        const SizedBox(width: 12),
        Text('CRIAR NOVO ÁLBUM',
            style: GoogleFonts.bebasNeue(
                fontSize: 14,
                letterSpacing: 1,
                color: const Color(0xFFD4622A))),
      ]),
    );
  }
}

class _NovoAlbumGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD4622A).withOpacity(0.25))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.add_rounded, color: Color(0xFFD4622A), size: 28),
        const SizedBox(height: 8),
        Text('NOVO ÁLBUM',
            style: GoogleFonts.bebasNeue(
                fontSize: 13,
                letterSpacing: 1,
                color: const Color(0xFFD4622A))),
      ]),
    );
  }
}
