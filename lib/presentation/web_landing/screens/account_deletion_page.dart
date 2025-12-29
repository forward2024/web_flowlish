// lib/presentation/web_landing/screens/account_deletion_page.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountDeletionPage extends StatelessWidget {
  const AccountDeletionPage({super.key});

  static const String _developerName = 'Mykola Petrychenko';
  static const String _appName = 'Flowlish';
  static const String _contactEmail = 'flowlish.contact@gmail.com';

  Future<void> _sendDeletionRequest() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _contactEmail,
      queryParameters: {
        'subject': 'Account and Data Deletion Request - Flowlish',
        'body': '''
Dear Flowlish Support,

I would like to request the deletion of my account and all associated data from Flowlish.

My account email: [Please enter your account email]
Reason (optional): [You may provide a reason]

I understand that this action is irreversible and all my data will be permanently deleted.

Thank you.
''',
      },
    );

    if (!await launchUrl(emailUri)) {
      debugPrint('Could not launch email client');
    }
  }

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
          // Content Layer
          SingleChildScrollView(
            padding: EdgeInsets.only(top: topPadding, bottom: 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Center(
                        child: Text(
                          'Account & Data Deletion',
                          style: isMobile
                              ? theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )
                              : theme.textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'Видалення облікового запису та даних',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color?.withAlpha(179),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // App Info Section
                      _buildSectionHeader(context, 'Application Information'),
                      _buildInfoCard(
                        context,
                        icon: Icons.apps,
                        title: 'App Name',
                        content: _appName,
                      ),
                      _buildInfoCard(
                        context,
                        icon: Icons.person,
                        title: 'Developer',
                        content: _developerName,
                      ),
                      const Divider(height: 48),

                      // Instructions Section
                      _buildSectionHeader(context, 'How to Request Deletion'),
                      _buildStepCard(
                        context,
                        step: 1,
                        title: 'Send a Request',
                        content:
                            'Click the button below to send an email requesting deletion of your account and data.',
                      ),
                      _buildStepCard(
                        context,
                        step: 2,
                        title: 'Provide Your Email',
                        content:
                            'Include the email address associated with your Flowlish account in the request.',
                      ),
                      _buildStepCard(
                        context,
                        step: 3,
                        title: 'Confirmation',
                        content:
                            'We will process your request within 30 days and send you a confirmation email.',
                      ),
                      const Divider(height: 48),

                      // Data Types Section
                      _buildSectionHeader(context, 'Data That Will Be Deleted'),
                      _buildDataTypeItem(
                        context,
                        icon: Icons.account_circle,
                        title: 'Account Information',
                        description: 'Email address and authentication data',
                        willDelete: true,
                      ),
                      _buildDataTypeItem(
                        context,
                        icon: Icons.history,
                        title: 'Learning Progress',
                        description: 'Your vocabulary progress and listening history',
                        willDelete: true,
                      ),
                      _buildDataTypeItem(
                        context,
                        icon: Icons.settings,
                        title: 'Preferences',
                        description: 'Playback settings and app preferences',
                        willDelete: true,
                      ),
                      _buildDataTypeItem(
                        context,
                        icon: Icons.payment,
                        title: 'Purchase History',
                        description:
                            'Transaction records (retained for 90 days for legal requirements)',
                        willDelete: false,
                      ),
                      const Divider(height: 48),

                      // CTA Button
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: _sendDeletionRequest,
                              icon: const Icon(Icons.email_outlined),
                              label: const Text('Request Account Deletion'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade700,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 24 : 32,
                                  vertical: isMobile ? 16 : 20,
                                ),
                                textStyle: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Or send email directly to: $_contactEmail',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color?.withAlpha(128),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 64),

                      // Footer
                      Center(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () => context.go('/privacy'),
                              child: const Text('Privacy Policy'),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '© 2025 Flowlish. All rights reserved.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
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

          // Header Layer (Fixed & Blurred)
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withAlpha(128),
                ),
              ),
              Text(
                content,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(
    BuildContext context, {
    required int step,
    required String title,
    required String content,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$step',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color: theme.textTheme.bodySmall?.color?.withAlpha(179),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTypeItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool willDelete,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: willDelete ? Colors.red.shade400 : Colors.orange.shade400,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: willDelete
                            ? Colors.red.shade100
                            : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        willDelete ? 'Will be deleted' : 'Retained temporarily',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: willDelete
                              ? Colors.red.shade700
                              : Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withAlpha(179),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
