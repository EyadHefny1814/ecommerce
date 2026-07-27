import 'package:go_router/go_router.dart';

import '../../features/authentcation/presentation/pages/login_screen.dart';
import '../../features/authentcation/presentation/pages/signup_screen.dart';
import 'routes.dart';
import '../services/splash_screen.dart';
import '../../features/onboarding/onboardingscreen.dart';
import '../../features/product/presentation/screens/home_screen.dart';
import '../../features/authentcation/presentation/pages/otppage.dart';
final appRouter = GoRouter(
  initialLocation:'/' ,
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
      builder: (context, state) => const MainScreen(),
    ),
   GoRoute(
  path: '/',
  name :'splash' ,
  builder: (context, state) => const SplashScreen(),
),

GoRoute(
  path: '/otp',
  builder: (context, state) {
    final email = state.extra as String;

    return OtpPage(
      email: email,
    );
  },
),
GoRoute(
  path: '/onboarding',
  builder: (context, state) => const OnboardingScreen(),
),
  ],
);