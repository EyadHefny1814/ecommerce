import 'package:dio/dio.dart';

import 'api_consumer.dart';
class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio);

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      path,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }
}