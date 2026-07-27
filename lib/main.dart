import 'package:flutter/material.dart';

import 'core/di/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentcation/presentation/cubit/authentcation_cubit.dart';
import 'core/router/app_router.dart';
import 'package:flutter/services.dart';
import  'core/services/local_storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFF0D0D0D),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

await LocalStorageService.init();
  await Supabase.initialize(
    url: 'https://himzlcraabqfegkuwvcm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhpbXpsY3JhYWJxZmVna3V3dmNtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODUxNDQ5OTUsImV4cCI6MjEwMDcyMDk5NX0.72iw0Bz0G-onG5wRAoq8XrhKCwxs4x5Q6QDUipgdBcI',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => sl<AuthCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0D0D0D),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF5A1F),
            brightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}