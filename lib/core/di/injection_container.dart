import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';

// ==================== Product ====================

import '../../features/product/data/datasource/product_remote_datasource.dart';
import '../../features/product/data/repositories/product_repositoryImpl.dart';

import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/usecases/get_product_usecase.dart';

import '../../features/product/presentation/cubit/product_cubit.dart';

// ================= Authentication =================

final sl = GetIt.instance;

Future<void> init() async {
  // =================================================
  // External
  // =================================================

  sl.registerLazySingleton<Dio>(
    () => Dio(),
  );

  // =================================================
  // Core
  // =================================================

  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(sl()),
  );

  // =================================================
  // Product Feature
  // =================================================

  /// Data Source
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  /// Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  /// UseCases
  sl.registerLazySingleton(
    () => GetProductUseCase(sl()),
  );

  /// Cubit
  sl.registerFactory(
    () => ProductCubit(sl()),
  );

  // =================================================
  // Authentication Feature
  // =================================================

  /// Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  /// Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  /// UseCases
  sl.registerLazySingleton(
    () => LoginUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => RegisterUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => VerifyEmailUseCase(sl()),
  );

  /// Cubit
  sl.registerFactory(
    () => AuthCubit(
      sl(),
      sl(),
      sl(),
    ),
  );
}