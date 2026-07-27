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

import 'package:ecommerce_app/features/authentcation/data/datasource/authentcation_remote_datasource.dart';
import 'package:ecommerce_app/features/authentcation/data/datasource/authentication_remote_datasource_impl.dart';
import 'package:ecommerce_app/features/authentcation/data/repositories/authentcation_repository_impl.dart';
import 'package:ecommerce_app/features/authentcation/domain/repositories/authentcation_repository.dart';
import 'package:ecommerce_app/features/authentcation/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/authentcation/domain/usecases/register_usecase.dart';
import 'package:ecommerce_app/features/authentcation/domain/usecases/verifyemail_usecase.dart';
import 'package:ecommerce_app/features/authentcation/presentation/cubit/authentcation_cubit.dart';

// ================= Database =================

import 'package:ecommerce_app/database/database_helper.dart';

// ================= Cart =================



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
  // Database
  // =================================================

  sl.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper.instance,
  );

  // =================================================
  // Cart
  // =================================================



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

  /// UseCase
  sl.registerLazySingleton<GetProductUseCase>(
    () => GetProductUseCase(sl()),
  );

  /// Cubit
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(sl()),
  );

  // =================================================
  // Authentication Feature
  // =================================================

  /// Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  /// Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  /// UseCases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl()),
  );

  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl()),
  );

  sl.registerLazySingleton<VerifyEmailUseCase>(
    () => VerifyEmailUseCase(sl()),
  );

  /// Cubit
 sl.registerFactory<AuthCubit>(
  () => AuthCubit(
    sl(), // LoginUseCase
    sl(), // RegisterUseCase
    sl(), // VerifyEmailUseCase
  ),
);
}