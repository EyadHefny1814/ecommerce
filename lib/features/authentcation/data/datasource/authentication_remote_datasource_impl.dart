import 'package:ecommerce_app/core/api/api_consumer.dart' ;

import 'package:ecommerce_app/features/authentcation/domain/entities/user.dart';
import 'authentcation_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() async {
    throw UnimplementedError();
  }
}