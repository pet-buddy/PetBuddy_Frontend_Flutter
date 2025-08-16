import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/route/go_refresh_stream.dart';
import 'package:petbuddy_frontend_flutter/route/go_security_provider.dart';
import 'package:petbuddy_frontend_flutter/screens/screens.dart';
import 'package:petbuddy_frontend_flutter/screens/camera/camera_web_screen.dart'; // 모바일, 웹 분기처리

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  // 전역 토큰 체크 -> 토큰 없으면 로그인 화면으로
  final goSecurityState = ref.watch(goSecurityProvider.notifier);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(goSecurityState.stream),
    redirect: (BuildContext context, GoRouterState state) {
      if(!kIsWeb) return null;

      final location = state.uri.toString();

      final entryPointCheck = location.contains('home') || location.contains('camera') || location.contains('my');
      // debugPrint(location);
      // debugPrint(goSecurityState.get().toString());
      if (entryPointCheck && !goSecurityState.get() && !location.contains('login')) return '/login_screen';
      if (entryPointCheck && goSecurityState.get()) return location;
    },
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
              return CustomTransitionPage(
                child: const EmailLoginScreen(), 
                transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) 
                  => SlideTransition(
                      position: animation.drive(
                        Tween<Offset>(
                          begin: const Offset(0.75, 0),
                          end: Offset.zero,
                        ).chain(CurveTween(curve: Curves.easeIn)),
                      ),
                      child: child,
                    ),
                );
            },
            
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/register_screen',
        name: 'register_screen',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: RegisterScreen());
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/preorder_screen',
        name: 'preorder_screen',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: PreorderScreen());
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/camera_screen',
        name: 'camera_screen',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(child: CameraScreen());
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/camera_web_screen',
        name: 'camera_web_screen',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: CameraWebScreen(),
          );
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
            routes: [
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'home_mission_screen',
                name: 'home_mission_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(child: HomeMissionScreen(
                    missionCont: state.uri.queryParameters['missionCont'] ?? '',
                    missionGif: state.uri.queryParameters['missionGif'] ?? '',
                  ));
                },
              ),
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'home_activity_report_screen',
                name: 'home_activity_report_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: HomeActivityReportScreen());
                },
              ),
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'home_poop_report_screen',
                name: 'home_poop_report_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: HomePoopReportScreen());
                },
              ),
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'home_sleep_report_screen',
                name: 'home_sleep_report_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: HomeSleepReportScreen());
                },
              ),
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'home_feed_report_screen',
                name: 'home_feed_report_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: HomeFeedReportScreen());
                },
              ),
            ]
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: '/camera_upload_screen',
            name: 'camera_upload_screen',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: CameraUploadScreen());
            },
            routes: []
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: '/shop_screen',
            name: 'shop_screen',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: ShopScreen());
            },
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: '/my_screen',
            name: 'my_screen',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: MyScreen());
            },
            routes: [
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'my_profile_update_screen',
                name: 'my_profile_update_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: MyProfileUpdateScreen());
                },
              ),
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'my_pet_add_screen',
                name: 'my_pet_add_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(
                    child: MyPetAddScreen()
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'my_pet_update_screen',
                name: 'my_pet_update_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(
                    child: MyPetUpdateScreen(
                      pet_id: int.parse(state.uri.queryParameters['pet_id'] ?? '-1'),
                    )
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: shellNavigatorKey,
                path: 'my_setting_screen',
                name: 'my_setting_screen',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage(
                    child: const MySettingScreen(), 
                    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) 
                      => SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: const Offset(0.75, 0),
                              end: Offset.zero,
                            ).chain(CurveTween(curve: Curves.easeIn)),
                          ),
                          child: child,
                        ),
                    );
                },
              ),
            ]
          ),
        ],
      ),
    ],
  );
});
