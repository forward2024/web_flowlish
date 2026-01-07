import 'package:go_router/go_router.dart';
import '../../presentation/web_landing/screens/home_page.dart';
import '../../presentation/web_landing/screens/privacy_policy_page.dart';
import '../../presentation/web_landing/screens/account_deletion_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: '/privacy',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const PrivacyPolicyPage(),
        ),
      ),
      GoRoute(
        path: '/delete-account',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const AccountDeletionPage(),
        ),
      ),
    ],
  );
}
