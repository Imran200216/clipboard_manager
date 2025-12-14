import 'package:clipboard_manager/features/home/home.dart';
import 'package:go_router/go_router.dart';
import 'package:clipboard_manager/features/splash/splash.dart';
import 'package:clipboard_manager/core/constants/constants.dart';

GoRouter appRouter = GoRouter(
  initialLocation: "/splash",

  routes: [
    // Splash Screen
    GoRoute(
      path: '/splash',
      name: AppRouterConstants.splash,
      builder: (context, state) {
        return SplashScreen();
      },
    ),

    // Home Screen
    GoRoute(
      path: '/home',
      name: AppRouterConstants.home,
      builder: (context, state) {
        return HomeScreen();
      },
    ),
  ],
);
