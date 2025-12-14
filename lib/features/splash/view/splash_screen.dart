import 'package:clipboard_manager/core/constants/app_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      // Home Screen
      GoRouter.of(context).pushReplacementNamed(AppRouterConstants.home);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('splash')));
  }
}
