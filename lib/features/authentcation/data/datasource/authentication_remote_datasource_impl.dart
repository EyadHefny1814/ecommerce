import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user.dart' as entity;
import 'authentcation_remote_datasource.dart';
import '../models/userModel.dart';
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Future<entity.User> login({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final authUser = response.user;

    if (authUser == null) {
      throw Exception('Login failed');
    }

    final profile = await supabase
        .from('profiles')
        .select()
        .eq('id', authUser.id)
        .single();

    return UserModel(
  id: authUser.id,
  name: profile['name'] ?? '',
  email: authUser.email ?? '',
  token: response.session?.accessToken ?? '',
);
  }

  @override
  Future<entity.User> register({
    required String name,
    required String email,
    required String password,
    required String phonenumber,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final authUser = response.user;

    if (authUser == null) {
      throw Exception('Registration failed');
    }

    await supabase.from('profiles').insert({
      'id': authUser.id,
      'name': name,
      'phone_number': phonenumber,
    });

    // TODO: Replace with UserModel.fromSupabase(authUser, {...})
    throw UnimplementedError('Create UserModel then return it here.');
  }

  @override
  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    final response = await supabase.auth.verifyOTP(
      email: email,
      token: code,
      type: OtpType.signup,
    );

    if (response.user == null) {
      throw Exception('Invalid OTP');
    }
  }

  @override
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  @override
  Future<bool> isLoggedIn() async {
    return supabase.auth.currentUser != null;
  }
}