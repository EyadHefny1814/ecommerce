import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_product_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase getProductUseCase;

  ProductCubit(this.getProductUseCase) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());

    try {
      final products = await getProductUseCase();

      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}