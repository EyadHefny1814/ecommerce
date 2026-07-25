import 'package:go_router/go_router.dart';

import '../../features/authentcation/presentation/pages/login_screen.dart';
import '../../features/authentcation/presentation/pages/signup_screen.dart';
import 'routes.dart';
import '../../features/product/presentation/screens/product_screen.dart';


final appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) => const SignupScreen(),
    ),
   GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);