
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentcation_repository.dart';
import '../datasource/authentcation_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login({
    required String email,
    required String password,
  }) {
   return remote.login(
  email: email,
  password: password,
);
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String phonenumber ,
  }) {
    return remote.register(
      name: name,
      email: email,
      password: password,
      phonenumber:phonenumber,
    );
  }

  @override
  Future<void> verifyEmail({
    required String email,
    required String code,
  }) {
    return remote.verifyEmail(
      email: email,
      code: code,
    );
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }

  @override
  Future<bool> isLoggedIn() {
    return remote.isLoggedIn();
  }
}