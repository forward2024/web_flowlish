import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_background.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                'Privacy Policy.',
                style: GoogleFonts.playfairDisplay(
                  fontSize: isSmall ? 48 : 72,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 64),
              
              _PolicySection(
                title: 'Data Collection',
                content: 'We collect minimal data required to synchronize your learning progress and maintain your account. This includes your email and basic app usage statistics.',
                isDark: isDark,
              ),

              _PolicySection(
                title: 'Security',
                content: 'Your data is encrypted and stored securely. We do not sell or share your personal information with third parties.',
                isDark: isDark,
              ),

              _PolicySection(
                title: 'Consent',
                content: 'By using Flowlish, you agree to the collection and use of information in accordance with this policy.',
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

class _PolicySection extends StatelessWidget {
  final String title;
  final String content;
  final bool isDark;
  const _PolicySection({required this.title, required this.content, required this.isDark});

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
