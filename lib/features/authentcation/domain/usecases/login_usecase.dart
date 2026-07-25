import '../../domain/entities/user.dart';
import '../../domain/repositories/authentcation_repository.dart';
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(
      String email,
      String password,
  ) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}