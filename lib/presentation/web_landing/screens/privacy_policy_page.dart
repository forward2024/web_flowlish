// lib/presentation/web_landing/screens/privacy_policy_page.dart

import 'dart:ui'; // Для ImageFilter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  // --- Меню ---
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
                    _menuBtn(context, 'Головна', '/'),
                    const SizedBox(height: 16),
                    _menuBtn(context, 'Про додаток', '/about'),
                    // const SizedBox(height: 16),
                    // _menuBtn(context, 'Новини', '/news'),
                    const SizedBox(height: 48),
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

  Widget _menuBtn(BuildContext context, String title, String path) {
    return FilledButton(
      onPressed: () {
        Navigator.pop(context);
        context.go(path);
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 800;
    final double topPadding = isSmallScreen ? 80 : 100;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Content Layer
          SingleChildScrollView(
            padding: EdgeInsets.only(top: topPadding, bottom: 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800), // Вужче для тексту
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 24 : 0),
                  child: SelectableText.rich(
                    TextSpan(
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        fontSize: 16,
                      ),
                      children: [
                        _header(theme, 'Privacy Policy'),
                        _paragraph(
                          'This privacy policy is applicable to the Flowlish app (hereinafter referred to as "Application") for mobile devices, which was developed by Mykola Petrychenko (hereinafter referred to as "Service Provider") as a Free service. This service is provided "AS IS".',
                        ),

                        _subHeader(
                          theme,
                          'What information does the Application obtain and how is it used?',
                        ),
                        _boldLabel(theme, 'User Provided Information'),
                        _paragraph(
                          'The Application acquires the information you supply when you download and register the Application. Registration with the Service Provider is not mandatory.\nThe Service Provider may also use the information you provided them to contact you from time to time to provide you with important information, required notices and marketing promotions.',
                        ),

                        _boldLabel(theme, 'Automatically Collected Information'),
                        _paragraph(
                          'In addition, the Application may collect certain information automatically, including, but not limited to, the type of mobile device you use, your mobile devices unique device ID, the IP address of your mobile device, your mobile operating system, the type of mobile Internet browsers you use, and information about the way you use the Application.',
                        ),

                        _subHeader(
                          theme,
                          'Does the Application collect precise real time location information of the device?',
                        ),
                        _paragraph(
                          'This Application does not gather precise information about the location of your mobile device.',
                        ),

                        _subHeader(
                          theme,
                          'Do third parties see and/or have access to information obtained by the Application?',
                        ),
                        _paragraph(
                          'Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service.',
                        ),

                        // ... решта тексту політики (скорочено для прикладу, встав сюди повний текст) ...
                        _subHeader(theme, 'Contact us'),
                        _paragraph(
                          'If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at flowlish.contact@gmail.com.',
                        ),

                        const TextSpan(text: '\n\n'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Header Layer (Fixed & Blurred)
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
                          InkWell(
                            onTap: () => context.go('/'),
                            child: Text(
                              'Flowlish',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Nav
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
                                TextButton(
                                  onPressed: () => context.go('/about'),
                                  child: const Text('Про додаток'),
                                ),
                                // TextButton(
                                //   onPressed: () => context.go('/news'),
                                //   child: const Text('Новини'),
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
          ),
        ],
      ),
    );
  }

  // --- Helper Styles ---
  TextSpan _header(ThemeData theme, String text) {
    return TextSpan(
      text: '$text\n\n',
      style: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  TextSpan _subHeader(ThemeData theme, String text) {
    return TextSpan(
      text: '\n$text\n\n',
      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  TextSpan _boldLabel(ThemeData theme, String text) {
    return TextSpan(
      text: '$text\n',
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  TextSpan _paragraph(String text) {
    return TextSpan(text: '$text\n\n');
  }
}
