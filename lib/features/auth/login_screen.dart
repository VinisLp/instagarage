import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _isLogin = true;
  bool _obscurePassword = true;

  Future<void> _authenticate() async {
    setState(() => _isLoading = true);
    try {
      if (_isLogin) {
        await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_friendlyError(e.message),
              style: GoogleFonts.familjenGrotesk(fontSize: 13)),
          backgroundColor: const Color(0xFFD44A4A),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.instacollection://login-callback',
      );
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_friendlyError(e.message),
              style: GoogleFonts.familjenGrotesk(fontSize: 13)),
          backgroundColor: const Color(0xFFD44A4A),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
      }
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  Future<void> _signInWithApple() async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'io.supabase.instacollection://login-callback',
      );
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_friendlyError(e.message),
              style: GoogleFonts.familjenGrotesk(fontSize: 13)),
          backgroundColor: const Color(0xFFD44A4A),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
      }
    }
  }

  // ── LOGIN COM TELEFONE — dialog centralizado ──
  void _openPhoneLogin() {
    final phoneController = TextEditingController();
    final otpController = TextEditingController();

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) => StatefulBuilder(
        builder: (context, setD) {
          bool otpSent = false;
          bool loading = false;

          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 440,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1814),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2E2A22)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: StatefulBuilder(
                    builder: (context, setInner) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 18, 16, 0),
                          child: Row(children: [
                            const Icon(Icons.phone_rounded,
                                color: Color(0xFFD4622A), size: 22),
                            const SizedBox(width: 10),
                            Text('ENTRAR COM TELEFONE',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 18,
                                    color: const Color(0xFFF0ECE4),
                                    letterSpacing: 2)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF242018),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFF2E2A22))),
                                child: const Icon(Icons.close_rounded,
                                    color: Color(0xFF7A7060), size: 15),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            otpSent
                                ? 'Digite o código enviado por SMS'
                                : 'Enviaremos um código de verificação por SMS',
                            style: GoogleFonts.familjenGrotesk(
                                fontSize: 12, color: const Color(0xFF7A7060)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Color(0xFF2E2A22), height: 1),
                        const SizedBox(height: 16),

                        if (!otpSent) ...[
                          // Campo telefone
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NÚMERO DE TELEFONE',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 9,
                                        color: const Color(0xFF7A7060),
                                        letterSpacing: 1.5)),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  autofocus: true,
                                  style: GoogleFonts.familjenGrotesk(
                                      color: const Color(0xFFF0ECE4),
                                      fontSize: 15),
                                  decoration: InputDecoration(
                                    hintText: '11 99999-9999',
                                    hintStyle: GoogleFonts.familjenGrotesk(
                                        color: const Color(0xFF4A4438),
                                        fontSize: 14),
                                    filled: true,
                                    fillColor: const Color(0xFF242018),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text('🇧🇷',
                                                style: TextStyle(fontSize: 18)),
                                            const SizedBox(width: 6),
                                            Text('+55',
                                                style:
                                                    GoogleFonts.familjenGrotesk(
                                                        color: const Color(
                                                            0xFF7A7060),
                                                        fontSize: 14)),
                                            const SizedBox(width: 8),
                                            Container(
                                                width: 1,
                                                height: 20,
                                                color: const Color(0xFF3A3428)),
                                          ]),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF3A3428))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF3A3428))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD4622A))),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: loading
                                    ? null
                                    : () async {
                                        if (phoneController.text.trim().isEmpty)
                                          return;
                                        setInner(() => loading = true);
                                        try {
                                          await supabase.auth.signInWithOtp(
                                            phone:
                                                '+55${phoneController.text.trim().replaceAll(RegExp(r'\D'), '')}',
                                          );
                                          setInner(() {
                                            otpSent = true;
                                            loading = false;
                                          });
                                        } on AuthException catch (e) {
                                          setInner(() => loading = false);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  _friendlyError(e.message),
                                                  style: GoogleFonts
                                                      .familjenGrotesk(
                                                          fontSize: 13)),
                                              backgroundColor:
                                                  const Color(0xFFD44A4A),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ));
                                          }
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD4622A),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                ),
                                child: loading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2))
                                    : Text('ENVIAR CÓDIGO SMS',
                                        style: GoogleFonts.bebasNeue(
                                            fontSize: 16, letterSpacing: 2)),
                              ),
                            ),
                          ),
                        ] else ...[
                          // Campo OTP
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CÓDIGO DE VERIFICAÇÃO',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 9,
                                        color: const Color(0xFF7A7060),
                                        letterSpacing: 1.5)),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: otpController,
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  maxLength: 6,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.bebasNeue(
                                      color: const Color(0xFFF0ECE4),
                                      fontSize: 28,
                                      letterSpacing: 8),
                                  decoration: InputDecoration(
                                    hintText: '000000',
                                    hintStyle: GoogleFonts.bebasNeue(
                                        color: const Color(0xFF4A4438),
                                        fontSize: 28,
                                        letterSpacing: 8),
                                    filled: true,
                                    fillColor: const Color(0xFF242018),
                                    counterText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF3A3428))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF3A3428))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD4622A))),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () => setInner(() => otpSent = false),
                                  child: Text('Reenviar código',
                                      style: GoogleFonts.familjenGrotesk(
                                          fontSize: 12,
                                          color: const Color(0xFFD4622A),
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              const Color(0xFFD4622A))),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: loading
                                    ? null
                                    : () async {
                                        if (otpController.text.trim().length <
                                            6) return;
                                        setInner(() => loading = true);
                                        try {
                                          await supabase.auth.verifyOTP(
                                            phone:
                                                '+55${phoneController.text.trim().replaceAll(RegExp(r'\D'), '')}',
                                            token: otpController.text.trim(),
                                            type: OtpType.sms,
                                          );
                                          if (context.mounted)
                                            Navigator.pop(context);
                                        } on AuthException catch (e) {
                                          setInner(() => loading = false);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  _friendlyError(e.message),
                                                  style: GoogleFonts
                                                      .familjenGrotesk(
                                                          fontSize: 13)),
                                              backgroundColor:
                                                  const Color(0xFFD44A4A),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ));
                                          }
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD4622A),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                ),
                                child: loading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2))
                                    : Text('VERIFICAR E ENTRAR',
                                        style: GoogleFonts.bebasNeue(
                                            fontSize: 16, letterSpacing: 2)),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── RECUPERAR SENHA — dialog centralizado ──
  void _openForgotPassword() {
    final emailController = TextEditingController(text: _emailController.text);

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) => StatefulBuilder(
        builder: (context, setD) {
          bool sent = false;
          bool loading = false;

          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 440,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1814),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2E2A22)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: StatefulBuilder(
                    builder: (context, setInner) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 18, 16, 0),
                          child: Row(children: [
                            Text('RECUPERAR SENHA',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 18,
                                    color: const Color(0xFFF0ECE4),
                                    letterSpacing: 2)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF242018),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFF2E2A22))),
                                child: const Icon(Icons.close_rounded,
                                    color: Color(0xFF7A7060), size: 15),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              'Enviaremos um link de redefinição para seu email',
                              style: GoogleFonts.familjenGrotesk(
                                  fontSize: 12,
                                  color: const Color(0xFF7A7060))),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Color(0xFF2E2A22), height: 1),
                        const SizedBox(height: 16),

                        if (!sent) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _InputField(
                              controller: emailController,
                              label: 'EMAIL',
                              hint: 'seu@email.com',
                              keyboardType: TextInputType.emailAddress,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: loading
                                    ? null
                                    : () async {
                                        setInner(() => loading = true);
                                        try {
                                          await supabase.auth
                                              .resetPasswordForEmail(
                                                  emailController.text.trim());
                                          setInner(() {
                                            sent = true;
                                            loading = false;
                                          });
                                        } catch (_) {
                                          setInner(() => loading = false);
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD4622A),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                ),
                                child: loading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2))
                                    : Text('ENVIAR LINK',
                                        style: GoogleFonts.bebasNeue(
                                            fontSize: 16, letterSpacing: 2)),
                              ),
                            ),
                          ),
                        ] else ...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                            child: Column(children: [
                              const Text('✅', style: TextStyle(fontSize: 48)),
                              const SizedBox(height: 16),
                              Text('Email enviado!',
                                  style: GoogleFonts.bebasNeue(
                                      fontSize: 22,
                                      color: const Color(0xFF4CAF7A),
                                      letterSpacing: 1)),
                              const SizedBox(height: 8),
                              Text(
                                'Verifique sua caixa de entrada e siga as instruções para redefinir sua senha.',
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 13,
                                    color: const Color(0xFF7A7060),
                                    height: 1.5),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Text('FECHAR',
                                    style: GoogleFonts.bebasNeue(
                                        fontSize: 14,
                                        letterSpacing: 2,
                                        color: const Color(0xFFD4622A))),
                              ),
                            ]),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _friendlyError(String message) {
    if (message.contains('Invalid login credentials'))
      return 'Email ou senha incorretos';
    if (message.contains('Email not confirmed'))
      return 'Confirme seu email antes de entrar';
    if (message.contains('User already registered'))
      return 'Este email já está cadastrado';
    if (message.contains('Password should be'))
      return 'A senha deve ter pelo menos 6 caracteres';
    return message;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    final logoSize = isMobile
        ? 56.0
        : isTablet
            ? 72.0
            : 80.0;
    final subtitleSize = isMobile ? 13.0 : 15.0;
    final inputFontSize = isMobile ? 14.0 : 15.0;
    final btnFontSize = isMobile ? 16.0 : 18.0;
    final btnHeight = isMobile ? 48.0 : 54.0;
    final verticalSpacing = isMobile ? 40.0 : screenHeight * 0.07;
    final horizontalPadding = isMobile
        ? 24.0
        : isTablet
            ? 48.0
            : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0B),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: verticalSpacing * 0.5),

                    // Logo
                    Text('INSTA',
                        style: GoogleFonts.bebasNeue(
                            fontSize: logoSize,
                            color: const Color(0xFFF0ECE4),
                            letterSpacing: 6,
                            height: 1)),
                    Text('COLLECTION',
                        style: GoogleFonts.bebasNeue(
                            fontSize: logoSize,
                            color: const Color(0xFFD4622A),
                            letterSpacing: 6,
                            height: 1)),
                    const SizedBox(height: 8),
                    Text('Sua coleção. Sua garagem.',
                        style: GoogleFonts.familjenGrotesk(
                            fontSize: subtitleSize,
                            color: const Color(0xFF7A7060))),

                    SizedBox(height: verticalSpacing),

                    // Toggle
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      _TabButton(
                          label: 'ENTRAR',
                          active: _isLogin,
                          onTap: () => setState(() => _isLogin = true)),
                      const SizedBox(width: 8),
                      _TabButton(
                          label: 'CADASTRAR',
                          active: !_isLogin,
                          onTap: () => setState(() => _isLogin = false)),
                    ]),

                    const SizedBox(height: 24),

                    _InputField(
                        controller: _emailController,
                        label: 'EMAIL',
                        hint: 'seu@email.com',
                        keyboardType: TextInputType.emailAddress,
                        fontSize: inputFontSize),

                    const SizedBox(height: 14),

                    _InputField(
                      controller: _passwordController,
                      label: 'SENHA',
                      hint: '••••••••',
                      obscureText: _obscurePassword,
                      fontSize: inputFontSize,
                      suffix: GestureDetector(
                        onTap: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                        child: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF7A7060),
                            size: 18),
                      ),
                    ),

                    if (_isLogin)
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _openForgotPassword,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text('Esqueci minha senha',
                                style: GoogleFonts.familjenGrotesk(
                                    fontSize: 12,
                                    color: const Color(0xFFD4622A),
                                    decoration: TextDecoration.underline,
                                    decorationColor: const Color(0xFFD4622A))),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: btnHeight,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _authenticate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4622A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : Text(
                                _isLogin
                                    ? 'ENTRAR NA GARAGEM'
                                    : 'ABRIR MINHA GARAGEM',
                                style: GoogleFonts.bebasNeue(
                                    fontSize: btnFontSize, letterSpacing: 2)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Divisor OU
                    Row(children: [
                      const Expanded(child: Divider(color: Color(0xFF2E2A22))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('OU',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 10,
                                color: const Color(0xFF4A4438),
                                letterSpacing: 2)),
                      ),
                      const Expanded(child: Divider(color: Color(0xFF2E2A22))),
                    ]),

                    const SizedBox(height: 20),

                    // Botões sociais
                    Row(children: [
                      // Google
                      Expanded(
                          child: GestureDetector(
                        onTap: _isGoogleLoading ? null : _signInWithGoogle,
                        child: Container(
                          height: btnHeight,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1A1814),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFF3A3428))),
                          child: _isGoogleLoading
                              ? const Center(
                                  child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                          color: Color(0xFFD4622A),
                                          strokeWidth: 2)))
                              : Center(
                                  child: SizedBox(
                                      width: 26,
                                      height: 26,
                                      child: CustomPaint(
                                          painter: _GoogleLogoPainter()))),
                        ),
                      )),
                      const SizedBox(width: 10),

                      // Apple
                      Expanded(
                          child: GestureDetector(
                        onTap: _signInWithApple,
                        child: Container(
                          height: btnHeight,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1A1814),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFF3A3428))),
                          child: const Center(
                              child: Icon(Icons.apple_rounded,
                                  color: Color(0xFFF0ECE4), size: 28)),
                        ),
                      )),
                      const SizedBox(width: 10),

                      // Telefone
                      Expanded(
                          child: GestureDetector(
                        onTap: _openPhoneLogin,
                        child: Container(
                          height: btnHeight,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1A1814),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFF3A3428))),
                          child: const Center(
                              child: Icon(Icons.phone_rounded,
                                  color: Color(0xFFF0ECE4), size: 26)),
                        ),
                      )),
                    ]),

                    SizedBox(height: verticalSpacing * 0.5),

                    Text(
                      'Ao continuar você concorda com os\nTermos de Uso e Política de Privacidade',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.familjenGrotesk(
                          fontSize: 11,
                          color: const Color(0xFF4A4438),
                          height: 1.5),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Google Logo ──
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    canvas.drawCircle(center, radius, Paint()..color = Colors.white);
    final rect = Rect.fromCircle(center: center, radius: radius * 0.72);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.28;
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, -1.57, 2.1, false, paint);
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, 0.53, 1.57, false, paint);
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, 2.1, 1.05, false, paint);
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 3.15, 1.1, false, paint);
    canvas.drawLine(
        Offset(center.dx, center.dy),
        Offset(center.dx + radius * 0.72, center.dy),
        Paint()
          ..color = const Color(0xFF4285F4)
          ..strokeWidth = radius * 0.28
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(_GoogleLogoPainter old) => false;
}

// ── Tab Button ──
class _TabButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _TabButton(
      {required this.label, required this.active, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 32, vertical: isMobile ? 10 : 12),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFD4622A) : const Color(0xFF1A1814),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color:
                  active ? const Color(0xFFD4622A) : const Color(0xFF3A3428)),
        ),
        child: Text(label,
            style: GoogleFonts.bebasNeue(
                fontSize: isMobile ? 13 : 15,
                letterSpacing: 2,
                color: active ? Colors.white : const Color(0xFF7A7060))),
      ),
    );
  }
}

// ── Input Field ──
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final double fontSize;
  final Widget? suffix;
  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.fontSize,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffix,
  });
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: GoogleFonts.jetBrainsMono(
              fontSize: 10, color: const Color(0xFF7A7060), letterSpacing: 2)),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: GoogleFonts.familjenGrotesk(
            color: const Color(0xFFF0ECE4), fontSize: fontSize),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.familjenGrotesk(
              color: const Color(0xFF4A4438), fontSize: fontSize),
          filled: true,
          fillColor: const Color(0xFF1A1814),
          suffixIcon: suffix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 12), child: suffix)
              : null,
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
    ]);
  }
}
