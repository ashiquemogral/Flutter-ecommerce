import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/models/product_model.dart';
import 'package:flutter_ecommerce_app/repositories/product/product_repository.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()){
    on<LoadProduct>(_onLoadProduct);
    on<UpdateProduct>(_onUpdateProduct);
  }


  void _onLoadProduct(event, Emitter<ProductState> emit){
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getAllProducts().listen(
          (products) => add(
        UpdateProduct(products),
      ),
    );
  }
  void _onUpdateProduct(event, Emitter<ProductState> emit){
    emit(ProductLoaded(products: event.products));
  }
  // @override
  // Stream<ProductState> mapEventToState(
  //   ProductEvent event,
  // ) async* {
  //   if (event is LoadProduct) {
  //     yield* _mapLoadProductToState();
  //   }
  //   if (event is UpdateProduct) {
  //     yield* _mapUpdateProductToState(event);
  //   }
  // }

  // Stream<ProductState> _mapLoadProductToState() async* {
  //   _productSubscription?.cancel();
  //   _productSubscription = _productRepository.getAllProducts().listen(
  //         (products) => add(
  //           UpdateProduct(products),
  //         ),
  //       );
  // }

//   Stream<ProductState> _mapUpdateProductToState(
//     UpdateProduct event,
//   ) async* {
//     yield ProductLoaded(products: event.products);
//   }
 }
