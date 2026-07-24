import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getProducts();
  }
}