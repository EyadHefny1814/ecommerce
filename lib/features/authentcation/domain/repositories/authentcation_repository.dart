import '../../domain/entities/user.dart';
abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String phonenumber ,
  });

  Future<void> verifyEmail({
    required String email,
    required String code,
  });

  Future<void> logout();

  Future<bool> isLoggedIn();
}