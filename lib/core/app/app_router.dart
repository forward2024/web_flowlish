// lib/core/app/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:web_flowlish/presentation/web_landing/screens/not_found_page.dart';
import '../../presentation/web_landing/screens/home_page.dart';
import '../../presentation/web_landing/screens/about_page.dart';
import '../../presentation/web_landing/screens/privacy_policy_page.dart';
import '../../presentation/web_landing/screens/news_feed_page.dart';
import '../../presentation/web_landing/screens/account_deletion_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        // ВИДАЛЕНО 'const'
        pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        path: '/about',
        // ВИДАЛЕНО 'const'
        pageBuilder: (context, state) => NoTransitionPage(child: AboutScreen()),
      ),
      GoRoute(
        path: '/privacy',
        // ВИДАЛЕНО 'const'
        pageBuilder: (context, state) => NoTransitionPage(child: PrivacyPolicyPage()),
      ),
      GoRoute(
        path: '/news',
        // ВИДАЛЕНО 'const'
        pageBuilder: (context, state) => NoTransitionPage(child: NewsFeedPage()),
      ),
      GoRoute(
        path: '/delete-account',
        pageBuilder: (context, state) => NoTransitionPage(child: AccountDeletionPage()),
      ),
    ],

    // ВИПРАВЛЕНО:
    // 'errorBuilder' повинен повертати 'Widget', а не 'Page'.
    // Ми просто повертаємо сторінку 404 напряму.
    errorBuilder: (context, state) {
      return const NotFoundPage();
    },
  );
}

//
// === ДОПОМІЖНИЙ КЛАС ДЛЯ ВІДКЛЮЧЕННЯ АНІМАЦІЙ ===
//
class NoTransitionPage extends CustomTransitionPage {
  // ВИДАЛЕНО 'const' З КОНСТРУКТОРА
  NoTransitionPage({required super.child})
    : super(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      );
}
