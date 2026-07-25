import '../../domain/entities/user.dart';
class AuthState {
  final bool isLoggedIn;
  final User? user;

  const AuthState({
    this.isLoggedIn = false,
    this.user,
  });
}