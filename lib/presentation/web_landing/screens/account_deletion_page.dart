import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_background.dart';

class AccountDeletionPage extends StatelessWidget {
  const AccountDeletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSmall = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      body: PremiumBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isSmall ? 24 : 80, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   IconButton(
                    onPressed: () => context.go('/'),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: isDark ? Colors.white38 : Colors.black26,
                      size: 20,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/logo.png', width: 32, height: 32),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              Text(
                'Account Deletion.',
                style: GoogleFonts.playfairDisplay(
                  fontSize: isSmall ? 40 : 72,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 64),
              
              _DeletionPoint(
                title: 'In-App Deletion',
                content: 'The safest way to delete your account is through the App Settings within the Flowlish mobile application. This verifies your identity instantly.',
                isDark: isDark,
              ),

              _DeletionPoint(
                title: 'What is deleted?',
                content: 'Deleting your account permanently removes your learning history, progress, bookmarks, and account information from our servers. This cannot be undone.',
                isDark: isDark,
              ),

              _DeletionPoint(
                title: 'Manual Request',
                content: 'If you no longer have access to the app, you can request deletion by emailing flowlish.contact@gmail.com from your registered email address.',
                isDark: isDark,
              ),
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeletionPoint extends StatelessWidget {
  final String title;
  final String content;
  final bool isDark;
  const _DeletionPoint({required this.title, required this.content, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.6,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}
