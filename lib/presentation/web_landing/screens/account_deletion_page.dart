import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountDeletionPage extends StatelessWidget {
  const AccountDeletionPage({super.key});

  static const String _developerName = 'Mykola Petrychenko';
  static const String _appName = 'Flowlish';
  static const String _contactEmail = 'flowlish.contact@gmail.com';

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
    final isMobile = screenSize.width < 600;
    final isSmallScreen = screenSize.width < 1000;
    final double topPadding = isSmallScreen ? 80 : 100;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: topPadding, bottom: 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Delete Account',
                          style: isMobile
                              ? theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )
                              : theme.textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Видалення облікового запису',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(150),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      _buildInfoCard(context, Icons.apps, 'App', _appName),
                      _buildInfoCard(context, Icons.person, 'Developer', _developerName),
                      const Divider(height: 48),

                      _buildSectionHeader(context, 'How to Delete Your Account'),
                      const SizedBox(height: 16),
                      
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withAlpha(50),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.primary.withAlpha(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Delete from within the app',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'To delete your account, please use the in-app deletion feature. '
                              'This ensures secure verification of your identity.',
                              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      _buildStep(context, '1.', 'Open the Flowlish app'),
                      _buildStep(context, '2.', 'Go to Settings'),
                      _buildStep(context, '3.', 'Open Account Settings'),
                      _buildStep(context, '4.', 'Tap "Delete Account" and confirm'),

                      const Divider(height: 48),

                      _buildSectionHeader(context, 'What Data Is Deleted'),
                      const SizedBox(height: 16),
                      
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error.withAlpha(20),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: theme.colorScheme.error),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Authentication Data',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Your email/Apple ID and account credentials stored in Firebase Authentication will be permanently deleted.',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface.withAlpha(180),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 48),

                      _buildSectionHeader(context, 'Need Help?'),
                      const SizedBox(height: 8),
                      Text(
                        'If you cannot access the app, contact us:',
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      SelectableText(
                        _contactEmail,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),

                      const SizedBox(height: 64),

                      Center(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () => context.go('/privacy'),
                              child: const Text('Privacy Policy'),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Mykola Petrychenko, 2025',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withAlpha(128),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

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
                          InkWell(
                            onTap: () => context.go('/'),
                            child: Text(
                              'Flowlish',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
                                  child: const Text('Home'),
                                ),
                                TextButton(
                                  onPressed: () => context.go('/about'),
                                  child: const Text('About'),
                                ),
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

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 22),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(150),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              number,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
