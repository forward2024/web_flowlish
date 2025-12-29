// lib/presentation/web_landing/screens/home_page.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // --- Налаштування Контенту ---
  static final Uri _appStoreUrl = Uri.parse(
    'https://apps.apple.com/us/app/flowlish/id0000000000',
  );

  void _showModalMenu(BuildContext context) {
    final theme = Theme.of(context);

    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 50),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      },
      pageBuilder: (context, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(color: Colors.black.withAlpha(128)),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // FilledButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     context.go('/news');
                    //   },
                    //   style: FilledButton.styleFrom(
                    //     backgroundColor: Colors.white,
                    //     foregroundColor: Colors.black,
                    //     shape: const StadiumBorder(),
                    //     padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    //   ),
                    //   child: Text(
                    //     'Новини',
                    //     style: theme.textTheme.titleMedium?.copyWith(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/about');
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      ),
                      child: Text(
                        'Про додаток',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchAppStore() async {
    if (!await launchUrl(_appStoreUrl, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $_appStoreUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    // Responsive breakpoints: mobile < 600, tablet < 1000, desktop >= 1000
    final bool isMobile = screenSize.width < 600;
    final bool isTablet = screenSize.width >= 600 && screenSize.width < 1000;
    final bool isSmallScreen = screenSize.width < 1000; // for backward compat
    final double iconSize = isMobile ? 22 : (isTablet ? 26 : 28);
    // Feature cards per row: 1 on mobile, 2 on tablet, 3 on desktop
    final int featureCardsPerRow = isMobile ? 1 : (isTablet ? 2 : 3);
    final double featureCardWidth = isMobile ? double.infinity : 320.0;

    // === НАВІГАЦІЯ ===
    final List<Widget> navigationActions = isSmallScreen
        ? [
            IconButton(
              icon: Icon(Icons.menu, size: iconSize),
              onPressed: () => _showModalMenu(context),
            ),
          ]
        : [
            //TextButton(onPressed: () => context.go('/news'), child: const Text('Новини')),
            TextButton(
              onPressed: () => context.go('/about'),
              child: const Text('Про додаток'),
            ),
            const SizedBox(width: 24),
          ];

    final Widget heroHeadline = Text(
      'Інструмент для розвитку інтуїтивного сприйняття англійської',
      textAlign: TextAlign.center,
      style: (isMobile 
          ? theme.textTheme.headlineMedium 
          : (isTablet ? theme.textTheme.headlineLarge : theme.textTheme.displaySmall))
              ?.copyWith(letterSpacing: isMobile ? 1.0 : 4.0),
    );

    final Widget heroSubheadline = Text(
      'Уявіть керовану стрічку діалогів, яка тренує сприйняття мови\nСотні діалогів розвивають здатність розуміти контекст без перекладу в голові',
      textAlign: TextAlign.center,
      style: (isMobile ? theme.textTheme.bodyLarge : (isTablet ? theme.textTheme.titleLarge : theme.textTheme.headlineSmall))
          ?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withAlpha(179),
            height: 1.4,
          ),
    );

    final Widget ctaButtons = Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 24 : 32,
              vertical: isSmallScreen ? 16 : 20,
            ),
            textStyle: isSmallScreen
                ? theme.textTheme.titleMedium
                : theme.textTheme.titleLarge,
            backgroundColor: theme.brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            foregroundColor: theme.brightness == Brightness.light
                ? Colors.white
                : Colors.black,
          ),
          onPressed: _launchAppStore,
          icon: Icon(Icons.apple, size: iconSize),
          label: const Text('Завантажити'),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 24 : 32,
              vertical: isSmallScreen ? 16 : 20,
            ),
            textStyle: isSmallScreen
                ? theme.textTheme.titleMedium
                : theme.textTheme.titleLarge,
          ),
          onPressed: () => context.go('/about'),
          child: const Text('Детальніше'),
        ),
      ],
    );

    final List<Widget> featureCards = [
      _FeatureCard(
        icon: Icons.graphic_eq,
        title: 'Аудіострічка',
        description:
            'Діалоги відтворюються нон-стоп, автоматично завантажуючись по мірі прослуховування',
        theme: theme,
      ),
      _FeatureCard(
        icon: Icons.psychology_outlined,
        title: 'Інтуїтивне розуміння',
        description:
            'Розвивайте навичку прямого сприйняття: вчіться розуміти англійську миттєво, не витрачаючи час на уявний переклад слів',
        theme: theme,
      ),
      _FeatureCard(
        icon: Icons.smart_toy_outlined,
        title: 'AI-озвучка',
        description:
            'Синтез мовлення нового покоління, наближений до живого голосу\n(Через експериментальний статус можливі нюанси звучання)',
        theme: theme,
      ),
      _FeatureCard(
        icon: Icons.school_outlined,
        title: 'Цільовий словник',
        description:
            'Фокус на найважливішому: лексична база сформована за принципом частотності вживання та структурована за рівнями A1–B1',
        theme: theme,
      ),
      _FeatureCard(
        icon: Icons.play_circle_fill_outlined,
        title: 'Фонове навчання',
        description:
            'Підтримка фонового режиму: аудіопотік не переривається при блокуванні екрану або згортанні додатку',
        theme: theme,
      ),
      _FeatureCard(
        icon: Icons.tune,
        title: 'Повний контроль',
        description:
            'Персоналізація: зміна швидкості, налаштування циклічних повторень та вибір пріоритетної мови озвучки',
        theme: theme,
      ),
    ];

    final Widget featuresSection = Column(
      children: [
        Text(
          'Ключові можливості Flowlish',
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 32,
          runSpacing: 32,
          alignment: WrapAlignment.center,
          children: featureCards.map((card) {
            return SizedBox(width: featureCardWidth, child: card);
          }).toList(),
        ),
      ],
    );

    // === 3. ФУТЕР ===
    final Widget footer = Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          TextButton(
            onPressed: () => context.go('/privacy'),
            child: const Text('Політика конфіденційності'),
          ),
          const SizedBox(height: 16),
          Text(
            'Mykola Petrychenko, 2025',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ],
      ),
    );

    // Top padding to account for fixed header
    final double topPadding = isSmallScreen ? 80 : 100;

    return Scaffold(
      body: Stack(
        children: [
          // Content Layer
          SingleChildScrollView(
            padding: EdgeInsets.only(top: topPadding),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 24 : 48,
                    vertical: 48,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: isSmallScreen ? 20 : 60),
                      heroHeadline,
                      const SizedBox(height: 24),
                      heroSubheadline,
                      const SizedBox(height: 40),
                      ctaButtons,
                      SizedBox(height: isSmallScreen ? 80 : 120),
                      const Divider(height: 1),
                      SizedBox(height: isSmallScreen ? 80 : 120),
                      featuresSection,
                      const SizedBox(height: 80),
                      const Divider(height: 1),
                      footer,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Glassmorphism Header Layer
          Align(
            alignment: Alignment.topCenter,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  height: isSmallScreen ? 60 : 80,
                  color: theme.scaffoldBackgroundColor.withAlpha(200),
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 24 : 48),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo
                          Row(
                            children: [
                              Image.network(
                                'favicon.png',
                                width: iconSize,
                                height: iconSize,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.language, size: iconSize);
                                },
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Flowlish',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Navigation
                          if (isSmallScreen)
                            IconButton(
                              icon: Icon(Icons.menu, size: iconSize),
                              onPressed: () => _showModalMenu(context),
                            )
                          else
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => context.go('/about'),
                                  child: const Text('Про додаток'),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- КАРТКА ФУНКЦІОНАЛУ ---
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.theme,
  });

  final IconData icon;
  final String title;
  final String description;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 36, color: theme.colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withAlpha(179),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
