import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/premium_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final Uri _appStoreUrl = Uri.parse(
    'https://apps.apple.com/app/flowlish/id0000000000',
  );
  static final Uri _testerUrl = Uri.parse(
    'https://play.google.com/apps/testing/com.flowlish.app',
  );
  static final Uri _googleGroupUrl = Uri.parse(
    'https://groups.google.com/g/flowlish-beta',
  );

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showAndroidInstructions() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.9,
              end: 1.0,
            ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      padding: const EdgeInsets.all(48),
                      decoration: BoxDecoration(
                        color: (isDark ? const Color(0xFF1E293B) : Colors.white)
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.android_rounded,
                            color: Color(0xFF3DDC84),
                            size: 48,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Android Beta',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildStep(
                            1,
                            'Join Google Group',
                            () => _launchUrl(_googleGroupUrl),
                            isDark,
                          ),
                          _buildStep(
                            2,
                            'Register as Tester',
                            () => _launchUrl(_testerUrl),
                            isDark,
                          ),
                          _buildStep(3, 'Install from Play Store', null, isDark),
                          const SizedBox(height: 48),
                          SizedBox(
                            width: double.infinity,
                            child: _StoreButton(
                              label: 'GOT IT',
                              isDark: isDark,
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep(int num, String text, VoidCallback? onTap, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  num.toString(),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.black87,
                  decoration: onTap != null ? TextDecoration.underline : null,
                  decorationColor: const Color(0xFF6366F1).withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSmall = MediaQuery.of(context).size.width < 1000;

    return Scaffold(
      body: PremiumBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 120),
              _IntroSection(isSmall: isSmall, isDark: isDark),

              const SizedBox(height: 120),
              _NarrativeSection1(isSmall: isSmall, isDark: isDark),

              const SizedBox(height: 64),
              _NarrativeSection2(isSmall: isSmall, isDark: isDark),

              const SizedBox(height: 64),
              _NarrativeSection3(isSmall: isSmall, isDark: isDark),

              const SizedBox(height: 180),
              _ActionSection(isSmall: isSmall, isDark: isDark),

              const SizedBox(height: 140),
              _HomeFooter(isDark: isDark),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  final bool isSmall;
  final bool isDark;
  const _IntroSection({required this.isSmall, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 80),
      child: Column(
        children: [
          _LogoBadge(isDark: isDark),
          const SizedBox(height: 64),
          Text(
            'Мистецтво легкого занурення.',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: isSmall ? 52 : 110,
              fontWeight: FontWeight.w800,
              letterSpacing: -4,
              height: 0.9,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'THE ART OF EFFORTLESS EXPOSURE',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 4,
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 48),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'Flowlish — це не курс. Це середовище. Вийдіть за межі ментальної пастки перекладу та підключіться безпосередньо до ритму мови.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: isSmall ? 18 : 24,
                fontWeight: FontWeight.w300,
                height: 1.6,
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Flowlish isn’t a course. It’s an environment. Escape the mental trap of translation and connect directly to the rhythm of language.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 80),
          _StoreButtons(isDark: isDark, isSmall: isSmall),
          const SizedBox(height: 120),
          const _AppSimView(),
        ],
      ),
    );
  }
}

class _NarrativeSection1 extends StatelessWidget {
  final bool isSmall;
  final bool isDark;
  const _NarrativeSection1({required this.isSmall, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDark ? Colors.white : Colors.black;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 80),
      child: Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(48),
          border: Border.all(color: baseColor.withOpacity(0.08)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Flex(
              direction: isSmall ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isSmall ? 0 : 5,
                  child: Column(
                    crossAxisAlignment: isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      Text(
                        '01  /  ВІДКРИТІСТЬ',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 4,
                          color: const Color(0xFF2563EB).withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Слухайте без фільтрів.',
                        textAlign: isSmall ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: isSmall ? 40 : 64,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Навчання — ворог вільності. Ми прибираємо шум, правила граматики та словники. Чистий аудіальний потік.',
                        textAlign: isSmall ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          height: 1.8,
                          color: (isDark ? Colors.white : Colors.black).withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Study is the enemy of fluency. We remove the noise, the grammar rules, and the dictionary.',
                        textAlign: isSmall ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isSmall) const Spacer(flex: 1),
                if (isSmall) const SizedBox(height: 48),
                _NarrativeVisual(
                  icon: Icons.waves_rounded,
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NarrativeSection2 extends StatelessWidget {
  final bool isSmall;
  final bool isDark;
  const _NarrativeSection2({required this.isSmall, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDark ? Colors.white : Colors.black;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 80),
      child: Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(48),
          border: Border.all(color: baseColor.withOpacity(0.08)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Flex(
              direction: isSmall ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                if (!isSmall)
                  _NarrativeVisual(
                    icon: Icons.grain_rounded,
                    isDark: isDark,
                  ),
                if (!isSmall) const Spacer(flex: 1),
                if (isSmall) const SizedBox(height: 48),
                Expanded(
                  flex: isSmall ? 0 : 5,
                  child: Column(
                    crossAxisAlignment: isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      Text(
                        '02  /  ТЕХНОЛОГІЯ',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 4,
                          color: const Color(0xFF06B6D4).withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Наука резонансу.',
                        textAlign: isSmall ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: isSmall ? 40 : 64,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Мова — це стан розуму. Наш алгоритм створює оптимальне середовище занурення, яке підлаштовується під вас.',
                        textAlign: isSmall ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          height: 1.8,
                          color: (isDark ? Colors.white : Colors.black).withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Language is a state of mind. Our algorithm creates an optimal immersion field.',
                        textAlign: isSmall ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSmall) const SizedBox(height: 48),
                if (isSmall)
                  _NarrativeVisual(
                    icon: Icons.grain_rounded,
                    isDark: isDark,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NarrativeSection3 extends StatelessWidget {
  final bool isSmall;
  final bool isDark;
  const _NarrativeSection3({required this.isSmall, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 80),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(64),
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
              borderRadius: BorderRadius.circular(64),
              border: Border.all(
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.15),
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(64),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Column(
                  children: [
                    Text(
                      'Ніяких перекладів. Ніколи.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: isSmall ? 36 : 72,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Розірвіть коло. Прибираючи місток до рідної мови, ми змушуємо мозок будувати нові, прямі нейронні шляхи для мови.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        height: 1.8,
                        color: (isDark ? Colors.white : Colors.black).withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'NO TRANSLATION. EVER.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 6,
                        color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrativeVisual extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  const _NarrativeVisual({required this.icon, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDark ? Colors.white : Colors.black;
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.02),
        shape: BoxShape.circle,
        border: Border.all(color: baseColor.withOpacity(0.05)),
      ),
      child: Center(
        child: Icon(icon, size: 80, color: baseColor.withOpacity(0.1)),
      ),
    );
  }
}

class _ActionSection extends StatelessWidget {
  final bool isSmall;
  final bool isDark;
  const _ActionSection({required this.isSmall, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Приєднуйся до потоку.',
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: isSmall ? 48 : 92,
            fontWeight: FontWeight.w800,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'JOIN THE PULSE',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 6,
            color: (isDark ? Colors.white : Colors.black).withOpacity(0.2),
          ),
        ),
        const SizedBox(height: 72),
        _StoreButtons(isDark: isDark, isSmall: isSmall),
      ],
    );
  }
}

class _StoreButtons extends StatelessWidget {
  final bool isDark;
  final bool isSmall;
  const _StoreButtons({required this.isDark, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    final _HomePageState? homeState = context.findAncestorStateOfType<_HomePageState>();
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _StoreButton(
          label: 'App Store',
          subtitle: 'Available on',
          icon: Icons.apple_rounded,
          isDark: isDark,
          onTap: () => homeState?._launchUrl(_HomePageState._appStoreUrl),
        ),
        _StoreButton(
          label: 'Play Store',
          subtitle: 'Get it for',
          icon: Icons.play_arrow_rounded,
          isDark: isDark,
          onTap: () => homeState?._showAndroidInstructions(),
        ),
      ],
    );
  }
}

class _LogoBadge extends StatelessWidget {
  final bool isDark;
  const _LogoBadge({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: (isDark ? Colors.white : Colors.black).withOpacity(0.03),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.08),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/images/logo.png',
              width: 18,
              height: 18,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.waves_rounded, size: 16, color: Color(0xFF6366F1)),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'FLOWLISH',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _Nav extends StatelessWidget {
  final bool isDark;
  final bool isSmall;
  const _Nav({required this.isDark, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 80, vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/logo.png', width: 32, height: 32),
              const SizedBox(width: 12),
              Text(
                'flowlish.',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          if (!isSmall)
            Row(
              children: [
                _NavLink(label: 'Privacy', path: '/privacy', isDark: isDark),
                const SizedBox(width: 32),
                _NavLink(
                  label: 'Support',
                  path: 'mailto:flowlish.contact@gmail.com',
                  isDark: isDark,
                ),
                const SizedBox(width: 32),
                _NavLink(label: 'Legal', path: '/legal', isDark: isDark),
              ],
            ),
        ],
      ),
    );
  }
}

class _StoreButton extends StatefulWidget {
  final String label;
  final String? subtitle;
  final IconData? icon;
  final bool isDark;
  final VoidCallback onTap;

  const _StoreButton({
    required this.label,
    this.subtitle,
    this.icon,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isDark ? Colors.white : Colors.black;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: baseColor.withOpacity(_isHovered ? 0.12 : 0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: baseColor.withOpacity(_isHovered ? 0.25 : 0.1),
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: baseColor.withOpacity(0.05),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 24,
                color: baseColor.withOpacity(_isHovered ? 1.0 : 0.7),
              ),
              const SizedBox(width: 14),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: baseColor.withOpacity(_isHovered ? 1.0 : 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppSimView extends StatelessWidget {
  const _AppSimView();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Container(
        width: 320,
        height: 640,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          border: Border.all(
            color: (isDark ? Colors.white : Colors.black).withOpacity(0.12),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(46),
          child: const _SimulatorUI(),
        ),
      ),
    );
  }
}

class _SimulatorUI extends StatefulWidget {
  const _SimulatorUI();

  @override
  State<_SimulatorUI> createState() => _SimulatorUIState();
}

class _SimulatorUIState extends State<_SimulatorUI> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(color: isDark ? const Color(0xFF020617) : Colors.white),
      child: Stack(
        children: [
          // Subtle App UI
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Visualizer(controller: _controller),
              const SizedBox(height: 80),
              _AnimatedText(
                text: "Listen to the flow.",
                isMain: true,
                controller: _controller,
                delay: 0,
              ),
              const SizedBox(height: 12),
              _AnimatedText(
                text: "Слухайте потік.",
                isMain: false,
                controller: _controller,
                delay: 0.5,
              ),
              const SizedBox(height: 100),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF2563EB).withOpacity(0.2)),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFF2563EB),
                  size: 32,
                ),
              ),
            ],
          ),
          // Dynamic Island replacement (sleek minimal)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Visualizer extends StatelessWidget {
  final AnimationController controller;
  const _Visualizer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(12, (i) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final double v =
                math.sin((controller.value * 2 * math.pi) + (i * 0.8)) * 0.5 + 0.5;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 3,
              height: 20 + (v * 60),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        );
      }),
    );
  }
}

class _AnimatedText extends StatelessWidget {
  final String text;
  final bool isMain;
  final AnimationController controller;
  final double delay;
  const _AnimatedText({
    required this.text,
    required this.isMain,
    required this.controller,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double op = math
            .sin((controller.value * 2 * math.pi) - delay)
            .clamp(0.1, 1.0);
        return Opacity(
          opacity: op,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: isMain
                ? GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  )
                : GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
          ),
        );
      },
    );
  }
}

class _HomeFooter extends StatelessWidget {
  final bool isDark;
  const _HomeFooter({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final baseColor = isDark ? Colors.white : Colors.black;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
          decoration: BoxDecoration(
            color: baseColor.withOpacity(0.03),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: baseColor.withOpacity(0.08)),
          ),
          child: Wrap(
            spacing: 48,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _NavLink(label: 'Privacy Policy', path: '/privacy', isDark: isDark),
              _NavLink(label: 'Legal Notice', path: '/legal', isDark: isDark),
              _NavLink(
                label: 'Support Contact',
                path: 'mailto:flowlish.contact@gmail.com',
                isDark: isDark,
              ),
              _NavLink(label: 'Delete Account', path: '/delete-account', isDark: isDark),
            ],
          ),
        ),
        const SizedBox(height: 64),
        Text(
          'FLOWLISH © 2026',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
            color: baseColor.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String path;
  final bool isDark;
  const _NavLink({required this.label, required this.path, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (path.startsWith('mailto')) {
          launchUrl(Uri.parse(path));
        } else {
          context.go(path);
        }
      },
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.4),
        ),
      ),
    );
  }
}
