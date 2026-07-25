import 'package:bloc/bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';




class AuthState {
  final bool isLoggedIn;
  final User? user;

  const AuthState({
    this.isLoggedIn = false,
    this.user,
  });
}

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit(this.loginUseCase)
      : super(const AuthState());

  Future<void> login(
      String email,
      String password,
  ) async {

    final user =
        await loginUseCase(email, password);

    emit(
      AuthState(
        isLoggedIn: true,
        user: user,
      ),
    );
  }

  void logout() {
    emit(const AuthState());
  }
}


