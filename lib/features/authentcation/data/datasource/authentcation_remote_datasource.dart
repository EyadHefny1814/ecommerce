import 'package:ecommerce_app/features/authentcation/domain/entities/user.dart';



abstract class AuthRemoteDataSource {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> verifyEmail({
    required String email,
    required String code,
  });

  Future<void> logout();

  Future<bool> isLoggedIn();
}