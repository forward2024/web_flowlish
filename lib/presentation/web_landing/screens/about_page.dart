// lib/features/app/presentation/screens/about_screen.dart

import 'dart:ui'; // Для ImageFilter
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // --- Меню (ідентичне головній сторінці) ---
  void _showModalMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 200),
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
                    _buildMenuButton(context, 'Головна', '/'),
                    const SizedBox(height: 16),
                    // _buildMenuButton(context, 'Новини', '/news'),
                    // const SizedBox(height: 48),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
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

  Widget _buildMenuButton(BuildContext context, String label, String route) {
    return FilledButton(
      onPressed: () {
        Navigator.pop(context);
        context.go(route);
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Для нативного iOS залишаємо Cupertino, для Web/Android - новий Material дизайн
    if (defaultTargetPlatform == TargetPlatform.iOS && !kIsWeb) {
      return _buildCupertinoVersion(context);
    } else {
      return _buildWebMaterialVersion(context);
    }
  }

  // --- ВЕРСІЯ ДЛЯ WEB (Стиль HomePage) ---
  Widget _buildWebMaterialVersion(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 1000;

    // Відступи, щоб контент не ховався під фіксованою шапкою
    final double topPadding = isSmallScreen ? 80 : 100;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Шар Контенту
          SingleChildScrollView(
            padding: EdgeInsets.only(top: topPadding, bottom: 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100), // Як на головній
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 24 : 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Про додаток',
                          style: isSmallScreen
                              ? theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )
                              : theme.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // --- СЕКЦІЇ ---
                      _buildSectionHeader(context, 'Ідея'),
                      _buildInfoRow(
                        context,
                        'Мета',
                        'Інструмент для тренування сприйняття англійської на слух.',
                      ),
                      _buildInfoRow(
                        context,
                        'Методика',
                        'Відмова від зайвого: лише потік діалогів, що розвиває здатність розуміти контекст без перекладу в думках.',
                      ),
                      const Divider(height: 64),

                      _buildSectionHeader(context, 'Розвиток'),
                      _buildInfoRow(
                        context,
                        'MVP',
                        'Продукт у стадії базової робочої версії. Ведеться робота над оновленням контенту та стабілізацією.',
                      ),
                      _buildInfoRow(
                        context,
                        'Зворотний зв\'язок',
                        'База слів та сценаріїв коригується на основі пропозицій та рапортів користувачів.',
                      ),
                      const Divider(height: 64),

                      _buildSectionHeader(context, 'Функціонал'),
                      _buildInfoRow(
                        context,
                        'Аудіострічка',
                        'Безперервне відтворення діалогів з автоматичним завантаженням.',
                      ),
                      _buildInfoRow(
                        context,
                        'Словник',
                        'Лексика відібрана за популярністю. Контент структурований за рівнями (A1–B1).',
                      ),
                      _buildInfoRow(
                        context,
                        'Фоновий режим',
                        'Підтримка відтворення аудіо при заблокованому екрані.',
                      ),
                      const Divider(height: 64),

                      _buildSectionHeader(context, 'Технології'),
                      _buildInfoRow(
                        context,
                        'AI-озвучка (Beta)',
                        'Синтез мовлення наближений до живого голосу. Можливі цифрові артефакти через статус Beta.',
                      ),
                      const Divider(height: 64),

                      _buildSectionHeader(context, 'Підтримка'),
                      // Оновлений блок підтримки
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.email_outlined, color: theme.colorScheme.primary),
                            const SizedBox(width: 12),
                            // SelectableText дозволяє виділяти текст мишкою,
                            // якщо кнопка копіювання не спрацює
                            SelectableText(
                              'flowlish.contact@gmail.com',
                              style: theme.textTheme.titleMedium?.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                              onTap: () =>
                                  _copyToClipboard(context, 'flowlish.contact@gmail.com'),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.copy, size: 18, color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
                              tooltip: 'Копіювати',
                              onPressed: () =>
                                  _copyToClipboard(context, 'flowlish.contact@gmail.com'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 64),

                      _buildSectionHeader(context, 'Ліцензії'),
                      _buildInfoRow(
                        context,
                        'WordNet®',
                        '''Лексична база опирається на дані WordNet®.

WordNet 3.0 Copyright 2006 by Princeton University. All rights reserved.

THIS SOFTWARE AND DATABASE IS PROVIDED "AS IS" AND PRINCETON UNIVERSITY MAKES NO REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED. BY WAY OF EXAMPLE, BUT NOT LIMITATION, PRINCETON UNIVERSITY MAKES NO REPRESENTATIONS OR WARRANTIES OF MERCHANT-ABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE OR THAT THE USE OF THE LICENSED SOFTWARE, DATABASE OR DOCUMENTATION WILL NOT INFRINGE ANY THIRD PARTY PATENTS, COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS.

The name of Princeton University or Princeton may not be used in advertising or publicity pertaining to distribution of the software and/or database.''',
                      ),

                      const SizedBox(height: 80),
                      _buildFooter(context),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2. Шар Хедера (Glassmorphism Header)
          _buildGlassHeader(context, isSmallScreen),
        ],
      ),
    );
  }

  // --- HEADER WIDGET (Спільний для обох сторінок) ---
  Widget _buildGlassHeader(BuildContext context, bool isSmallScreen) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topCenter,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: isSmallScreen ? 60 : 80,
            color: theme.scaffoldBackgroundColor.withAlpha(200), // Напівпрозорий фон
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 24 : 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // LOGO / TITLE
                    InkWell(
                      onTap: () => context.go('/'),
                      child: Row(
                        children: [
                          // Image.network('favicon.png', width: 24, height: 24), // Лого якщо треба
                          // const SizedBox(width: 12),
                          Text(
                            'Flowlish',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // NAVIGATION
                    if (isSmallScreen)
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => _showModalMenu(context),
                      )
                    else
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => context.go('/'),
                            child: const Text('Головна'),
                          ),
                          // TextButton(
                          //   onPressed: () => context.go('/news'),
                          //   child: const Text('Новини'),
                          // ),
                          // TextButton(
                          //   onPressed: () => context.go('/privacy'),
                          //   child: const Text('Конфіденційність'),
                          // ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Component Helpers ---
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String title, String content) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    if (isMobile) {
      // Vertical layout for mobile
      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
          ],
        ),
      );
    }
    
    // Horizontal layout for tablet/desktop
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Mykola Petrychenko, 2025',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(128),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));

      // Перевіряємо, чи віджет все ще змонтований перед використанням context
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email скопійовано: $text'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: 300, // Обмеження ширини для Web
        ),
      );
    } catch (e) {
      debugPrint('Clipboard error: $e');

      if (!context.mounted) return;

      // Показуємо повідомлення, що не вдалося скопіювати
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не вдалося скопіювати автоматично. Виділіть текст вручну.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // --- iOS VERSION (Залишаємо без змін для AppStore) ---
  Widget _buildCupertinoVersion(BuildContext context) {
    // ... (Твій старий код для iOS - встав сюди те саме що було в попередній відповіді для body)
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Про програму')),
      child: SafeArea(
        child: ListView(
          children: [
            // ... встав вміст CupertinoListSection з попередньої відповіді
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("iOS версія відображається на iPhone"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
