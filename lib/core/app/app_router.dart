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
        pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        path: '/about',
        pageBuilder: (context, state) => NoTransitionPage(child: AboutScreen()),
      ),
      GoRoute(
        path: '/privacy',
        pageBuilder: (context, state) => NoTransitionPage(child: PrivacyPolicyPage()),
      ),
      GoRoute(
        path: '/news',
        pageBuilder: (context, state) => NoTransitionPage(child: NewsFeedPage()),
      ),
      GoRoute(
        path: '/delete-account',
        pageBuilder: (context, state) => NoTransitionPage(child: AccountDeletionPage()),
      ),
    ],
    errorBuilder: (context, state) {
      return const NotFoundPage();
    },
  );
}

class NoTransitionPage extends CustomTransitionPage {
  NoTransitionPage({required super.child})
    : super(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      );
}
