import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/screens/screens.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return router;
});

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: SplashScreen());
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/login_screen',
      name: 'login_screen',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: LoginScreen());
      },
      routes: [
        GoRoute(
          path: 'email_login_screen',
          name: 'email_login_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: EmailLoginScreen());
          },
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/register_step1_screen',
      name: 'register_step1_screen',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: RegisterStep1Screen());
      },
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      pageBuilder: (context, state, child) => NoTransitionPage(
        child: MainScreen(child: child)
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: '/home_screen',
          name: 'home_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: HomeScreen());
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: '/shop_screen',
          name: 'shop_screen',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: ShopScreen());
          },
        ),
      ],
    ),
  ],
);
