import '../entities/user.dart';
import '../repositories/authentcation_repository.dart';
import '../usecases/verifyemail_usecase.dart' ;
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> call({
    required String name,
    required String email,
    required String password,
    required String phonenumber ,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      phonenumber: phonenumber ,
    );
  }
}