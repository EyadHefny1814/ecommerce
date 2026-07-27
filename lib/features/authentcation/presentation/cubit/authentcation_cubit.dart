import 'package:bloc/bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/verifyemail_usecase.dart';

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
  final RegisterUseCase registerUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;

  AuthCubit(
    this.loginUseCase,
    this.registerUseCase,
    this.verifyEmailUseCase,
  ) : super(const AuthState());

  Future<void> login(
    String email,
    String password,
  ) async {
    final user = await loginUseCase(
      email,
      password,
    );

    emit(
      AuthState(
        isLoggedIn: true,
        user: user,
      ),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phonenumber,
  }) async {
    final user = await registerUseCase(
      name: name,
      email: email,
      password: password,
      phonenumber: phonenumber,
    );

    emit(
      AuthState(
        isLoggedIn: false,
        user: user,
      ),
    );
  }

  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    await verifyEmailUseCase(
      email: email,
      code: code,
    );

    emit(
      AuthState(
        isLoggedIn: true,
        user: state.user,
      ),
    );
  }

  void logout() {
    emit(const AuthState());
  }
}
