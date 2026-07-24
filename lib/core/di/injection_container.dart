import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';

import '../../features/product/data/datasource/product_remote_datasource.dart';
import '../../features/product/data/repositories/product_repositoryImpl.dart';

import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/usecases/get_product_usecase.dart';

import '../../features/product/presentation/cubit/product_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Core
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(sl()),
  );

  // Data Source
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  // Use Case
  sl.registerLazySingleton(
    () => GetProductUseCase(sl()),
  );

  // Cubit
  sl.registerFactory(
    () => ProductCubit(sl()),
  );
}