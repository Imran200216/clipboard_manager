import 'package:clipboard_manager/core/router/app_router.dart';
import 'package:clipboard_manager/di/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Service Locator
  serviceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Clipboard Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: appRouter,
    );
  }
}
