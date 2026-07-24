import 'package:flutter/material.dart';

import 'core/di/injection_container.dart';
import 'features/authentcation/presentation/pages/login_screen.dart';
import 'core/router/app_router.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
  debugShowCheckedModeBanner: false,
  routerConfig: appRouter ,
);
  }
}