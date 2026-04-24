import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'add_piece_screen.dart';

class AiScanScreen extends StatefulWidget {
  const AiScanScreen({super.key});

  @override
  State<AiScanScreen> createState() => _AiScanScreenState();
}

class _AiScanScreenState extends State<AiScanScreen>
    with SingleTickerProviderStateMixin {
  bool _scanning = false;
  bool _identified = false;
  String? _imagePath;

  late AnimationController _scanLineController;
  late Animation<double> _scanLineAnim;

  final Map<String, String> _result = {
    'NOME': 'Pikachu Illustrator',
    'SÉRIE': 'Pokémon Promo · 1998',
    'FABRICANTE': 'Creatures Inc.',
    'CONDIÇÃO': 'Near Mint',
    'CATEGORIA': 'Cards',
    'VALOR MKT': 'R\$ 185.000',
  };
  double _confidence = 0.91;

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLineAnim = Tween<double>(begin: 0.15, end: 0.85).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked == null) return;

    setState(() {
      _imagePath = picked.path;
      _scanning = true;
      _identified = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _scanning = false;
        _identified = true;
      });
    }
  }

  void _confirm() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Peça adicionada à garagem! 🏎️',
          style: GoogleFonts.familjenGrotesk(fontSize: 13)),
      backgroundColor: const Color(0xFF4CAF7A),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
    );
  }

  // ══════════════════════════════════════
  // LAYOUT DESKTOP — duas colunas
  // ══════════════════════════════════════
  Widget _buildDesktopLayout() {
    return Center(
      child: SizedBox(
        width: 860,
        child: Column(
          children: [
            // Topbar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
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
                      child: const Icon(Icons.close_rounded,
                          color: Color(0xFFF0ECE4), size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('ADICIONAR PEÇA',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 24,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2)),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4622A).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: const Color(0xFFD4622A).withOpacity(0.4)),
                    ),
                    child: Row(
                      children: [
                        const Text('✦',
                            style: TextStyle(
                                color: Color(0xFFD4622A), fontSize: 10)),
                        const SizedBox(width: 4),
                        Text('IA',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 10,
                                color: const Color(0xFFD4622A),
                                letterSpacing: 1)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF2E2A22), height: 1),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Coluna esquerda: scan/preview
                  SizedBox(
                    width: 360,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Preview ou viewfinder
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _identified && _imagePath != null
                                ? _buildPreviewDesktop()
                                : _buildViewfinderDesktop(),
                          ),
                          const SizedBox(height: 20),
                          if (_scanning) _buildScanning(),
                          if (!_scanning && !_identified) ...[
                            // Botões de scan
                            _ScanButton(
                              icon: Icons.camera_alt_rounded,
                              label: 'TIRAR FOTO',
                              subtitle: 'A IA identifica automaticamente',
                              color: const Color(0xFFD4622A),
                              onTap: () => _pickImage(ImageSource.camera),
                            ),
                            const SizedBox(height: 10),
                            _ScanButton(
                              icon: Icons.photo_library_rounded,
                              label: 'ESCOLHER DA GALERIA',
                              subtitle: 'Selecionar foto existente',
                              color: const Color(0xFF1A1814),
                              onTap: () => _pickImage(ImageSource.gallery),
                              outlined: true,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  Container(width: 1, color: const Color(0xFF2E2A22)),

                  // ✅ Coluna direita: resultado IA ou cadastro manual
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: _identified
                          ? _buildResultDesktop()
                          : _buildManualPrompt(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewfinderDesktop() {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.black,
      child: Stack(
        children: [
          const Center(
            child: Opacity(
                opacity: 0.3,
                child: Text('🎴', style: TextStyle(fontSize: 64))),
          ),
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFFD4622A).withOpacity(0.6),
                          width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  ..._buildCorners(200),
                  AnimatedBuilder(
                    animation: _scanLineAnim,
                    builder: (context, child) => Positioned(
                      top: _scanLineAnim.value * 200,
                      left: 12,
                      right: 12,
                      child: Container(
                        height: 1.5,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.transparent,
                            Color(0xFFD4622A),
                            Colors.transparent,
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Text('POSICIONE A PEÇA NO QUADRO',
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 1.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewDesktop() {
    return Container(
      width: double.infinity,
      height: 300,
      color: const Color(0xFF1a0800),
      child: const Center(child: Text('🎴', style: TextStyle(fontSize: 100))),
    );
  }

  // ✅ Prompt para cadastro manual no desktop
  Widget _buildManualPrompt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OU CADASTRE MANUALMENTE',
            style: GoogleFonts.bebasNeue(
                fontSize: 20,
                color: const Color(0xFFF0ECE4),
                letterSpacing: 2)),
        const SizedBox(height: 8),
        Text('Preencha os campos da sua peça sem precisar da câmera.',
            style: GoogleFonts.familjenGrotesk(
                fontSize: 13, color: const Color(0xFF7A7060), height: 1.5)),
        const SizedBox(height: 20),
        // ✅ Preview das seções do formulário como cards clicáveis
        GestureDetector(
          onTap: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const AddPieceScreen())),
          child: Container(
            padding: const EdgeInsets.all(20),
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
                    const Icon(Icons.edit_rounded,
                        color: Color(0xFFD4622A), size: 20),
                    const SizedBox(width: 10),
                    Text('CADASTRO MANUAL',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: const Color(0xFFF0ECE4),
                            letterSpacing: 1.5)),
                  ],
                ),
                const SizedBox(height: 16),
                ...[
                  ('📸', 'Fotos da peça', 'Até 4 fotos — câmera ou galeria'),
                  ('🏷️', 'Nome e série', 'Com sugestões automáticas'),
                  ('📦', 'Categoria', 'Cards, Vinils, HQs e mais de 30 tipos'),
                  ('✅', 'Condição', 'Perfeito, Bom, Regular...'),
                  ('💰', 'Valores', 'Quanto pagou e valor de mercado'),
                  ('🔒', 'Notas privadas', 'Visíveis só para você'),
                ].map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 28,
                              child: Text(item.$1,
                                  style: const TextStyle(fontSize: 16))),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.$2,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFF0ECE4))),
                                Text(item.$3,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 11,
                                        color: const Color(0xFF7A7060))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4622A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text('ABRIR FORMULÁRIO',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 16,
                            letterSpacing: 2,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ✅ Resultado IA no desktop (mais espaçoso)
  Widget _buildResultDesktop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFD4622A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('✦ IA IDENTIFICOU',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${(_confidence * 100).toInt()}% confiança',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 9, color: const Color(0xFF4CAF7A))),
                  const SizedBox(height: 3),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: _confidence,
                      backgroundColor: const Color(0xFF2E2A22),
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF4CAF7A)),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ..._result.entries.map((e) => _ResultField(
              label: e.key,
              value: e.value,
              highlight: e.key == 'VALOR MKT',
            )),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() {
                  _identified = false;
                  _scanning = false;
                  _imagePath = null;
                }),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFF0ECE4),
                  side: const BorderSide(color: Color(0xFF3A3428)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('✏️ EDITAR',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 16, letterSpacing: 1.5)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _confirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4622A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                ),
                child: Text('✦ CONFIRMAR E SALVAR',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 16, letterSpacing: 1.5)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ══════════════════════════════════════
  // LAYOUT MOBILE — original
  // ══════════════════════════════════════
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Topbar
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
                    border: Border.all(color: const Color(0xFF2E2A22)),
                  ),
                  child: const Icon(Icons.close_rounded,
                      color: Color(0xFFF0ECE4), size: 18),
                ),
              ),
              const SizedBox(width: 12),
              Text('SCAN DE PEÇA',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 20,
                      color: const Color(0xFFF0ECE4),
                      letterSpacing: 2)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4622A).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: const Color(0xFFD4622A).withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const Text('✦',
                        style:
                            TextStyle(color: Color(0xFFD4622A), fontSize: 10)),
                    const SizedBox(width: 4),
                    Text('IA',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 10,
                            color: const Color(0xFFD4622A),
                            letterSpacing: 1)),
                  ],
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _identified && _imagePath != null
                    ? _buildPreview()
                    : _buildViewfinder(),
                const SizedBox(height: 20),
                if (_scanning) _buildScanning(),
                if (_identified) _buildResult(),
                if (!_scanning && !_identified) _buildInitial(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewfinder() {
    final size = MediaQuery.of(context).size.width;
    return Container(
      width: size,
      height: size * 0.85,
      color: Colors.black,
      child: Stack(
        children: [
          const Center(
            child: Opacity(
                opacity: 0.3,
                child: Text('🎴', style: TextStyle(fontSize: 80))),
          ),
          Center(
            child: SizedBox(
              width: size * 0.65,
              height: size * 0.65,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFFD4622A).withOpacity(0.6),
                          width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  ..._buildCorners(size * 0.65),
                  AnimatedBuilder(
                    animation: _scanLineAnim,
                    builder: (context, child) => Positioned(
                      top: _scanLineAnim.value * size * 0.65,
                      left: 12,
                      right: 12,
                      child: Container(
                        height: 1.5,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.transparent,
                            Color(0xFFD4622A),
                            Colors.transparent,
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Text('POSICIONE A PEÇA NO QUADRO',
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 1.5)),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCorners(double size) {
    const c = Color(0xFFFFFFFF);
    const w = 3.0;
    const len = 20.0;
    return [
      Positioned(
          top: 0,
          left: 0,
          child:
              _Corner(color: c, width: w, length: len, top: true, left: true)),
      Positioned(
          top: 0,
          right: 0,
          child:
              _Corner(color: c, width: w, length: len, top: true, left: false)),
      Positioned(
          bottom: 0,
          left: 0,
          child:
              _Corner(color: c, width: w, length: len, top: false, left: true)),
      Positioned(
          bottom: 0,
          right: 0,
          child: _Corner(
              color: c, width: w, length: len, top: false, left: false)),
    ];
  }

  Widget _buildPreview() {
    final size = MediaQuery.of(context).size.width;
    return Container(
      width: size,
      height: size * 0.85,
      color: const Color(0xFF1a0800),
      child: const Center(child: Text('🎴', style: TextStyle(fontSize: 120))),
    );
  }

  Widget _buildInitial() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text('Como deseja identificar a peça?',
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 14, color: const Color(0xFF7A7060))),
          const SizedBox(height: 20),
          _ScanButton(
            icon: Icons.camera_alt_rounded,
            label: 'TIRAR FOTO',
            subtitle: 'A IA identifica automaticamente',
            color: const Color(0xFFD4622A),
            onTap: () => _pickImage(ImageSource.camera),
          ),
          const SizedBox(height: 12),
          _ScanButton(
            icon: Icons.photo_library_rounded,
            label: 'ESCOLHER DA GALERIA',
            subtitle: 'Selecionar foto existente',
            color: const Color(0xFF1A1814),
            onTap: () => _pickImage(ImageSource.gallery),
            outlined: true,
          ),
          const SizedBox(height: 12),
          _ScanButton(
            icon: Icons.edit_rounded,
            label: 'CADASTRO MANUAL',
            subtitle: 'Preencher campos manualmente',
            color: const Color(0xFF1A1814),
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const AddPieceScreen())),
            outlined: true,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildScanning() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                  color: Color(0xFFD4622A), strokeWidth: 3)),
          const SizedBox(height: 16),
          Text('ANALISANDO COM IA...',
              style: GoogleFonts.bebasNeue(
                  fontSize: 18,
                  color: const Color(0xFFD4622A),
                  letterSpacing: 3)),
          const SizedBox(height: 6),
          Text('Identificando nome, série, condição e valor de mercado',
              style: GoogleFonts.familjenGrotesk(
                  fontSize: 12, color: const Color(0xFF7A7060)),
              textAlign: TextAlign.center),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFD4622A),
                    borderRadius: BorderRadius.circular(6)),
                child: Text('✦ IA IDENTIFICOU',
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 10,
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${(_confidence * 100).toInt()}% confiança',
                        style: GoogleFonts.jetBrainsMono(
                            fontSize: 9, color: const Color(0xFF4CAF7A))),
                    const SizedBox(height: 3),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: _confidence,
                        backgroundColor: const Color(0xFF2E2A22),
                        valueColor:
                            const AlwaysStoppedAnimation(Color(0xFF4CAF7A)),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._result.entries.map((e) => _ResultField(
              label: e.key, value: e.value, highlight: e.key == 'VALOR MKT')),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() {
                    _identified = false;
                    _scanning = false;
                    _imagePath = null;
                  }),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFF0ECE4),
                    side: const BorderSide(color: Color(0xFF3A3428)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('✏️ EDITAR',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 15, letterSpacing: 1.5)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _confirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4622A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                  child: Text('✦ CONFIRMAR',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 15, letterSpacing: 1.5)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ── CORNER DO VIEWFINDER ──
class _Corner extends StatelessWidget {
  final Color color;
  final double width;
  final double length;
  final bool top;
  final bool left;

  const _Corner(
      {required this.color,
      required this.width,
      required this.length,
      required this.top,
      required this.left});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: length,
      height: length,
      child: CustomPaint(
        painter: _CornerPainter(
            color: color, strokeWidth: width, top: top, left: left),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool top;
  final bool left;

  _CornerPainter(
      {required this.color,
      required this.strokeWidth,
      required this.top,
      required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final x = left ? 0.0 : size.width;
    final y = top ? 0.0 : size.height;
    final dx = left ? size.width : -size.width;
    final dy = top ? size.height : -size.height;

    canvas.drawLine(Offset(x, y), Offset(x + dx, y), paint);
    canvas.drawLine(Offset(x, y), Offset(x, y + dy), paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) => false;
}

// ── SCAN BUTTON ──
class _ScanButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final bool outlined;

  const _ScanButton(
      {required this.icon,
      required this.label,
      required this.subtitle,
      required this.color,
      required this.onTap,
      this.outlined = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: outlined ? const Color(0xFF3A3428) : color),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: outlined ? const Color(0xFF7A7060) : Colors.white,
                size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.bebasNeue(
                          fontSize: 16,
                          letterSpacing: 1.5,
                          color: outlined
                              ? const Color(0xFFF0ECE4)
                              : Colors.white)),
                  Text(subtitle,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11,
                          color: outlined
                              ? const Color(0xFF7A7060)
                              : Colors.white.withOpacity(0.7))),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                color: outlined
                    ? const Color(0xFF3A3428)
                    : Colors.white.withOpacity(0.5),
                size: 14),
          ],
        ),
      ),
    );
  }
}

// ── RESULT FIELD ──
class _ResultField extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _ResultField(
      {required this.label, required this.value, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label,
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    color: const Color(0xFF7A7060),
                    letterSpacing: 1)),
          ),
          Expanded(
            child: Text(value,
                style: GoogleFonts.familjenGrotesk(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: highlight
                        ? const Color(0xFFD4A020)
                        : const Color(0xFFF0ECE4))),
          ),
          const Icon(Icons.check_circle_rounded,
              color: Color(0xFF4CAF7A), size: 16),
        ],
      ),
    );
  }
}
