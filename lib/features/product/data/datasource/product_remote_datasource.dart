import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_points.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProductRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await apiConsumer.get(EndPoints.products);

    return (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}