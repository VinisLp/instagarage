import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class AddPieceScreen extends StatefulWidget {
  const AddPieceScreen({super.key});

  @override
  State<AddPieceScreen> createState() => _AddPieceScreenState();
}

class _AddPieceScreenState extends State<AddPieceScreen> {
  final _nameController = TextEditingController();
  final _seriesController = TextEditingController();
  final _yearController = TextEditingController();
  final _notesController = TextEditingController();
  final _pricePaidController = TextEditingController();
  final _marketValueController = TextEditingController();
  final _customCategoryController = TextEditingController();

  String _selectedCategory = 'Cards';
  String _selectedCondition = 'Perfeito';
  bool _isPublic = true;
  bool _isForTrade = false;
  bool _isSealed = false;

  final List<Uint8List> _photos = [];
  final ImagePicker _picker = ImagePicker();

  // ✅ Sugestões por categoria
  final Map<String, List<String>> _nameSuggestions = {
    'Cards': [
      'Charizard Holo',
      'Pikachu Illustrator',
      'Black Lotus',
      'Mox Sapphire',
      'Blue-Eyes White Dragon',
      'Blastoise Holo',
      'Venusaur Holo',
      'Mewtwo Holo'
    ],
    'Vinils / CDs': [
      'Led Zeppelin IV',
      'Abbey Road',
      'The Dark Side of the Moon',
      'Thriller',
      'Rumours',
      'Kind of Blue',
      'Nevermind',
      'Pet Sounds'
    ],
    'Quadrinhos': [
      'Amazing Fantasy #15',
      'Action Comics #1',
      'Detective Comics #27',
      'X-Men #1',
      'Spider-Man #1',
      'Fantastic Four #1'
    ],
    'Miniaturas': [
      'Ferrari 250 GTO Burago',
      'Hot Wheels Redline 1968',
      'Matchbox Lesney',
      'Corgi Aston Martin'
    ],
    'Action Figures': [
      'He-Man Masters Universe',
      'GI Joe Snake Eyes',
      'Star Wars Luke Skywalker',
      'Transformers Optimus Prime'
    ],
    'Camisas de Futebol': [
      'Brasil Copa 1970',
      'Argentina Copa 1986',
      'Milan 1989/90',
      'Barcelona 1998/99'
    ],
    'Funko Pop': [
      'Batman #01',
      'Spider-Man #03',
      'Thanos #289',
      'Iron Man #03'
    ],
    'Lego': [
      'Millennium Falcon 75192',
      'Eiffel Tower 10307',
      'Titanic 10294',
      'Star Wars AT-AT 75313'
    ],
  };

  final Map<String, List<String>> _seriesSuggestions = {
    'Cards': [
      'Base Set 1999',
      'Jungle Set',
      'Fossil Set',
      'Team Rocket',
      'Magic Alpha 1993',
      'Magic Beta',
      'Yu-Gi-Oh LOB'
    ],
    'Vinils / CDs': [
      'LP Original UK',
      'LP Prensagem BR',
      'LP First Press',
      'CD Primeira Edição'
    ],
    'Quadrinhos': [
      'Marvel Comics',
      'DC Comics',
      'Editora Abril',
      'Record',
      'Panini'
    ],
    'Miniaturas': [
      'Burago 1:18',
      'Hot Wheels Classic',
      'Matchbox 1:64',
      'Corgi 1:43'
    ],
  };

  List<String> get _currentNameSuggestions {
    final suggestions = _nameSuggestions[_selectedCategory] ?? [];
    final query = _nameController.text.toLowerCase();
    if (query.isEmpty) return suggestions.take(4).toList();
    return suggestions
        .where((s) => s.toLowerCase().contains(query))
        .take(4)
        .toList();
  }

  List<String> get _currentSeriesSuggestions {
    final suggestions = _seriesSuggestions[_selectedCategory] ?? [];
    final query = _seriesController.text.toLowerCase();
    if (query.isEmpty) return suggestions.take(3).toList();
    return suggestions
        .where((s) => s.toLowerCase().contains(query))
        .take(3)
        .toList();
  }

  bool _showNameSuggestions = false;
  bool _showSeriesSuggestions = false;

  final List<String> _categories = [
    'Cards',
    'Action Figures',
    'Vinils / CDs',
    'Quadrinhos',
    'Miniaturas',
    'Selos / Moedas',
    'Camisas de Futebol',
    'Outro',
  ];

  final List<String> _extraCategories = [
    'Brinquedos Antigos',
    'Jogos de Tabuleiro',
    'Consoles / Games',
    'Instrumentos Musicais',
    'Armas Antigas',
    'Relógios',
    'Jóias / Bijuterias',
    'Arte / Pinturas',
    'Fotografias',
    'Livros Raros',
    'Revistas',
    'Paninis / Figurinhas',
    'Tênis / Sneakers',
    'Bonés / Chapéus',
    'Patches / Pins',
    'Películas / DVDs',
    'Lego',
    'Funko Pop',
    'Modelos Militares',
    'Aviões / Navios Miniaturas',
    'Porcelanas / Cristais',
    'Moedas Comemorativas',
    'Cédulas / Notas',
    'Medalhas / Troféus',
  ];

  final List<Map<String, dynamic>> _conditions = [
    {'key': 'Perfeito', 'short': 'Perfeito', 'color': const Color(0xFF4CAF7A)},
    {
      'key': 'Quase Perfeito',
      'short': 'Q. Perf.',
      'color': const Color(0xFF4CAF7A)
    },
    {'key': 'Bom', 'short': 'Bom', 'color': const Color(0xFFD4A020)},
    {'key': 'Regular', 'short': 'Regular', 'color': const Color(0xFFD4622A)},
    {'key': 'Ruim', 'short': 'Ruim', 'color': const Color(0xFFD44A4A)},
  ];

  Future<void> _pickPhoto() async {
    if (_photos.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Máximo de 4 fotos por peça!',
            style: GoogleFonts.familjenGrotesk(fontSize: 13)),
        backgroundColor: const Color(0xFFD44A4A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ));
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1814),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: const Color(0xFF3A3428),
                    borderRadius: BorderRadius.circular(2))),
            Text('ADICIONAR FOTO',
                style: GoogleFonts.bebasNeue(
                    fontSize: 18,
                    color: const Color(0xFFF0ECE4),
                    letterSpacing: 2)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      final picked = await _picker.pickImage(
                          source: ImageSource.camera, imageQuality: 80);
                      if (picked != null) {
                        final bytes = await picked.readAsBytes();
                        setState(() => _photos.add(bytes));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: const Color(0xFFD4622A),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          const Icon(Icons.camera_alt_rounded,
                              color: Colors.white, size: 28),
                          const SizedBox(height: 6),
                          Text('CÂMERA',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      final picked = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 80);
                      if (picked != null) {
                        final bytes = await picked.readAsBytes();
                        setState(() => _photos.add(bytes));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: const Color(0xFF242018),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF3A3428))),
                      child: Column(
                        children: [
                          const Icon(Icons.photo_library_rounded,
                              color: Color(0xFFF0ECE4), size: 28),
                          const SizedBox(height: 6),
                          Text('GALERIA',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                  color: const Color(0xFFF0ECE4))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _removePhoto(int index) => setState(() => _photos.removeAt(index));

  void _openExtraCategories() {
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
          maxChildSize: 0.92,
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
              Text('OUTRAS CATEGORIAS',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 18,
                      color: const Color(0xFFF0ECE4),
                      letterSpacing: 2)),
              const SizedBox(height: 4),
              Text('Selecione ou digite uma categoria personalizada',
                  style: GoogleFonts.familjenGrotesk(
                      fontSize: 12, color: const Color(0xFF7A7060))),
              const Divider(color: Color(0xFF2E2A22)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _customCategoryController,
                  style: GoogleFonts.familjenGrotesk(
                      color: const Color(0xFFF0ECE4), fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Digite uma categoria personalizada...',
                    hintStyle: GoogleFonts.familjenGrotesk(
                        color: const Color(0xFF4A4438), fontSize: 13),
                    filled: true,
                    fillColor: const Color(0xFF242018),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (_customCategoryController.text.trim().isNotEmpty) {
                          setState(() => _selectedCategory =
                              _customCategoryController.text.trim());
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color(0xFFD4622A),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.check_rounded,
                            color: Colors.white, size: 18),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _extraCategories.length,
                  itemBuilder: (context, index) {
                    final cat = _extraCategories[index];
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedCategory = cat);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFD4622A).withOpacity(0.15)
                              : const Color(0xFF242018),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFD4622A)
                                  : const Color(0xFF3A3428)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(cat,
                                    style: GoogleFonts.familjenGrotesk(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? const Color(0xFFD4622A)
                                            : const Color(0xFFF0ECE4)))),
                            if (isSelected)
                              const Icon(Icons.check_circle_rounded,
                                  color: Color(0xFFD4622A), size: 18),
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
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _seriesController.dispose();
    _yearController.dispose();
    _notesController.dispose();
    _pricePaidController.dispose();
    _marketValueController.dispose();
    _customCategoryController.dispose();
    super.dispose();
  }

  void _save() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Digite o nome da peça!',
            style: GoogleFonts.familjenGrotesk(fontSize: 13)),
        backgroundColor: const Color(0xFFD44A4A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ));
      return;
    }
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
                        border: Border.all(color: const Color(0xFF2E2A22)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFFF0ECE4), size: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('CADASTRO MANUAL',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: const Color(0xFFF0ECE4),
                          letterSpacing: 2)),
                ],
              ),
            ),

            Expanded(
              child: isDesktop ? _buildDesktopForm() : _buildMobileForm(),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════
  // DESKTOP — duas colunas
  // ══════════════════════════════════════
  Widget _buildDesktopForm() {
    return Center(
      child: SizedBox(
        width: 860,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Coluna esquerda: fotos + categoria + condição
            SizedBox(
              width: 340,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPhotosSection(),
                    const SizedBox(height: 24),
                    _buildCategorySection(),
                    const SizedBox(height: 24),
                    _buildConditionSection(),
                    const SizedBox(height: 24),
                    _buildSealedSection(),
                  ],
                ),
              ),
            ),

            Container(width: 1, color: const Color(0xFF2E2A22)),

            // ✅ Coluna direita: campos de texto + valores + toggles + botão
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNameField(),
                    const SizedBox(height: 16),
                    _buildSeriesField(),
                    const SizedBox(height: 16),
                    _FormField(
                        controller: _yearController,
                        label: 'ANO',
                        hint: 'Ex: 1999',
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                            child: _FormField(
                                controller: _pricePaidController,
                                label: 'VALOR PAGO (R\$)',
                                hint: '0,00',
                                keyboardType: TextInputType.number)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _FormField(
                                controller: _marketValueController,
                                label: 'VALOR MERCADO (R\$)',
                                hint: '0,00',
                                keyboardType: TextInputType.number)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _FormField(
                        controller: _notesController,
                        label: 'NOTAS PRIVADAS',
                        hint: 'Onde comprou, história da peça...',
                        maxLines: 4),
                    const SizedBox(height: 16),
                    _buildTogglesSection(),
                    const SizedBox(height: 24),
                    _buildSaveButton(),
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
  // MOBILE — coluna única
  // ══════════════════════════════════════
  Widget _buildMobileForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhotosSection(),
          const SizedBox(height: 20),
          _buildNameField(),
          const SizedBox(height: 14),
          _buildCategorySection(),
          const SizedBox(height: 14),
          _buildSeriesField(),
          const SizedBox(height: 14),
          _FormField(
              controller: _yearController,
              label: 'ANO',
              hint: 'Ex: 1999',
              keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildConditionSection(),
          const SizedBox(height: 14),
          _buildSealedSection(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _FormField(
                      controller: _pricePaidController,
                      label: 'VALOR PAGO (R\$)',
                      hint: '0,00',
                      keyboardType: TextInputType.number)),
              const SizedBox(width: 12),
              Expanded(
                  child: _FormField(
                      controller: _marketValueController,
                      label: 'VALOR MERCADO (R\$)',
                      hint: '0,00',
                      keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 14),
          _FormField(
              controller: _notesController,
              label: 'NOTAS PRIVADAS',
              hint: 'Onde comprou, história da peça...',
              maxLines: 3),
          const SizedBox(height: 16),
          _buildTogglesSection(),
          const SizedBox(height: 28),
          _buildSaveButton(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ── SEÇÃO FOTOS ──
  Widget _buildPhotosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'FOTOS (ATÉ 4)'),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: Row(
            children: [
              ..._photos.asMap().entries.map((entry) {
                final index = entry.key;
                final bytes = entry.value;
                return Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF3A3428))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.memory(bytes, fit: BoxFit.cover),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removePhoto(index),
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.close_rounded,
                                  color: Colors.white, size: 14),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text('${index + 1}',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 9, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              if (_photos.length < 4)
                GestureDetector(
                  onTap: _pickPhoto,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: const Color(0xFF1A1814),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF3A3428))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_photo_alternate_rounded,
                            color: Color(0xFF4A4438), size: 28),
                        const SizedBox(height: 4),
                        Text(
                            _photos.isEmpty
                                ? 'ADICIONAR'
                                : '${_photos.length}/4',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 11,
                                letterSpacing: 1.5,
                                color: const Color(0xFF4A4438))),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (_photos.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text('Toque no ✕ para remover • A primeira foto é a capa',
                style: GoogleFonts.familjenGrotesk(
                    fontSize: 10, color: const Color(0xFF4A4438))),
          ),
      ],
    );
  }

  // ✅ Campo nome com sugestões
  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'NOME DA PEÇA *'),
        const SizedBox(height: 6),
        TextField(
          controller: _nameController,
          style: GoogleFonts.familjenGrotesk(
              color: const Color(0xFFF0ECE4), fontSize: 14),
          onChanged: (_) => setState(() => _showNameSuggestions = true),
          onTap: () => setState(() => _showNameSuggestions = true),
          decoration: InputDecoration(
            hintText: 'Ex: Charizard Holo',
            hintStyle: GoogleFonts.familjenGrotesk(
                color: const Color(0xFF4A4438), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFF1A1814),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3A3428))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3A3428))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD4622A))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        // ✅ Sugestões de nome
        if (_showNameSuggestions && _currentNameSuggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1814),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2E2A22)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 6),
                  child: Text('SUGESTÕES',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 8,
                          color: const Color(0xFF4A4438),
                          letterSpacing: 1.5)),
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _currentNameSuggestions
                      .map((s) => GestureDetector(
                            onTap: () {
                              _nameController.text = s;
                              setState(() => _showNameSuggestions = false);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF242018),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0xFF3A3428)),
                              ),
                              child: Text(s,
                                  style: GoogleFonts.familjenGrotesk(
                                      fontSize: 12,
                                      color: const Color(0xFFF0ECE4))),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ✅ Campo série com sugestões
  Widget _buildSeriesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'SÉRIE / COLEÇÃO'),
        const SizedBox(height: 6),
        TextField(
          controller: _seriesController,
          style: GoogleFonts.familjenGrotesk(
              color: const Color(0xFFF0ECE4), fontSize: 14),
          onChanged: (_) => setState(() => _showSeriesSuggestions = true),
          onTap: () => setState(() => _showSeriesSuggestions = true),
          decoration: InputDecoration(
            hintText: 'Ex: Base Set',
            hintStyle: GoogleFonts.familjenGrotesk(
                color: const Color(0xFF4A4438), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFF1A1814),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3A3428))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3A3428))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD4622A))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        // ✅ Sugestões de série
        if (_showSeriesSuggestions && _currentSeriesSuggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1814),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2E2A22)),
            ),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _currentSeriesSuggestions
                  .map((s) => GestureDetector(
                        onTap: () {
                          _seriesController.text = s;
                          setState(() => _showSeriesSuggestions = false);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF242018),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF3A3428)),
                          ),
                          child: Text(s,
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 12,
                                  color: const Color(0xFFF0ECE4))),
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }

  // ── SEÇÃO CATEGORIA ──
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'CATEGORIA'),
        const SizedBox(height: 8),
        if (!_categories.contains(_selectedCategory) &&
            _selectedCategory != 'Outro')
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFD4622A).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD4622A)),
            ),
            child: Row(
              children: [
                const Icon(Icons.category_rounded,
                    color: Color(0xFFD4622A), size: 16),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(_selectedCategory,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFD4622A)))),
                GestureDetector(
                  onTap: () => setState(() => _selectedCategory = 'Cards'),
                  child: const Icon(Icons.close_rounded,
                      color: Color(0xFFD4622A), size: 16),
                ),
              ],
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.map((cat) {
            return GestureDetector(
              onTap: () {
                if (cat == 'Outro') {
                  _openExtraCategories();
                } else {
                  setState(() {
                    _selectedCategory = cat;
                    _showNameSuggestions = true;
                    _showSeriesSuggestions = true;
                  });
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedCategory == cat
                      ? const Color(0xFFD4622A)
                      : const Color(0xFF1A1814),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _selectedCategory == cat
                          ? const Color(0xFFD4622A)
                          : const Color(0xFF3A3428)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(cat,
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _selectedCategory == cat
                                ? Colors.white
                                : const Color(0xFF7A7060))),
                    if (cat == 'Outro') ...[
                      const SizedBox(width: 4),
                      Icon(Icons.expand_more_rounded,
                          size: 14,
                          color: _selectedCategory == cat
                              ? Colors.white
                              : const Color(0xFF7A7060)),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── SEÇÃO CONDIÇÃO ──
  Widget _buildConditionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'CONDIÇÃO'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _conditions.map((cond) {
            final isSelected = _selectedCondition == cond['key'];
            final color = cond['color'] as Color;
            return GestureDetector(
              onTap: () =>
                  setState(() => _selectedCondition = cond['key'] as String),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected
                      ? color.withOpacity(0.15)
                      : const Color(0xFF1A1814),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: isSelected ? color : const Color(0xFF3A3428)),
                ),
                child: Text(cond['short'] as String,
                    style: GoogleFonts.familjenGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? color : const Color(0xFF7A7060))),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── SEÇÃO LACRADO/ABERTO ──
  Widget _buildSealedSection() {
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
          Text('ESTADO DE CONSERVAÇÃO',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  color: const Color(0xFF7A7060),
                  letterSpacing: 1.5)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isSealed = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _isSealed
                          ? const Color(0xFF4CAF7A).withOpacity(0.12)
                          : const Color(0xFF0F0E0B),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: _isSealed
                              ? const Color(0xFF4CAF7A)
                              : const Color(0xFF3A3428)),
                    ),
                    child: Column(
                      children: [
                        const Text('🔒', style: TextStyle(fontSize: 22)),
                        const SizedBox(height: 4),
                        Text('LACRADO',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 13,
                                letterSpacing: 1.5,
                                color: _isSealed
                                    ? const Color(0xFF4CAF7A)
                                    : const Color(0xFF4A4438))),
                        Text('Item original fechado',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 9,
                                color: _isSealed
                                    ? const Color(0xFF4CAF7A).withOpacity(0.7)
                                    : const Color(0xFF4A4438)),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isSealed = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: !_isSealed
                          ? const Color(0xFFD4622A).withOpacity(0.12)
                          : const Color(0xFF0F0E0B),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: !_isSealed
                              ? const Color(0xFFD4622A)
                              : const Color(0xFF3A3428)),
                    ),
                    child: Column(
                      children: [
                        const Text('🔓', style: TextStyle(fontSize: 22)),
                        const SizedBox(height: 4),
                        Text('ABERTO',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 13,
                                letterSpacing: 1.5,
                                color: !_isSealed
                                    ? const Color(0xFFD4622A)
                                    : const Color(0xFF4A4438))),
                        Text('Item foi aberto/usado',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 9,
                                color: !_isSealed
                                    ? const Color(0xFFD4622A).withOpacity(0.7)
                                    : const Color(0xFF4A4438)),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── SEÇÃO TOGGLES ──
  Widget _buildTogglesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1814),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2E2A22)),
      ),
      child: Column(
        children: [
          _ToggleRow(
              label: 'Peça pública',
              subtitle: 'Visível na sua garagem',
              value: _isPublic,
              onChanged: (v) => setState(() => _isPublic = v)),
          const Divider(color: Color(0xFF2E2A22), height: 20),
          _ToggleRow(
              label: 'Disponível para troca',
              subtitle: 'Outros podem propor troca',
              value: _isForTrade,
              onChanged: (v) => setState(() => _isForTrade = v)),
        ],
      ),
    );
  }

  // ── BOTÃO SALVAR ──
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4622A),
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text('ADICIONAR À GARAGEM',
            style: GoogleFonts.bebasNeue(fontSize: 18, letterSpacing: 2)),
      ),
    );
  }
}

// ── FORM FIELD ──
class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;

  const _FormField(
      {required this.controller,
      required this.label,
      required this.hint,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 9,
                color: const Color(0xFF7A7060),
                letterSpacing: 1.5)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.familjenGrotesk(
              color: const Color(0xFFF0ECE4), fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.familjenGrotesk(
                color: const Color(0xFF4A4438), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFF1A1814),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3A3428))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3A3428))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD4622A))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}

// ── SECTION LABEL ──
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: GoogleFonts.jetBrainsMono(
            fontSize: 9, color: const Color(0xFF7A7060), letterSpacing: 1.5));
  }
}

// ── TOGGLE ROW ──
class _ToggleRow extends StatelessWidget {
  final String label;
  final String subtitle;
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
          inactiveTrackColor: const Color(0xFF2E2A22),
        ),
      ],
    );
  }
}
