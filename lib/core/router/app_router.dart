import 'package:go_router/go_router.dart';

import '../../features/authentcation/presentation/pages/login_screen.dart';
import '../../features/authentcation/presentation/pages/signup_screen.dart';
import 'routes.dart';


final appRouter = GoRouter(
  initialLocation: Routes.login,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) => const SignupScreen(),
    ),
  ],
);