import '../entities/user.dart';
import '../repositories/authentcation_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
    );
  }
}