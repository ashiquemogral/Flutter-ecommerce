import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/models/cart_model.dart';
import 'package:flutter_ecommerce_app/models/models.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
  }

  void _onLoadCart(event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      emit(const CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onAddProduct(event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from(state.cart.products)..add(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onRemoveProduct(event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from(state.cart.products)..remove(event.product),
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }

  // @override
  // Stream<CartState> mapEventToState(
  //   CartEvent event,
  // ) async* {
  //   if (event is LoadCart) {
  //     yield* _mapCartStartedToState();
  //   } else if (event is AddProduct) {
  //     yield* _mapCartProductAddedToState(event, state);
  //   } else if (event is RemoveCart) {
  //     yield* _mapCartProductRemovedToState(event, state);
  //   }
  // }

  // Stream<CartState> _mapCartStartedToState() async* {
  //   yield CartLoading();
  //   try {
  //     await Future<void>.delayed(Duration(seconds: 1));
  //     yield CartLoaded();
  //   } catch (_) {}
  // }

  // Stream<CartState> _mapCartProductAddedToState(
  //   AddProduct event,
  //   CartState state,
  // ) async* {
  //   if (state is CartLoaded) {
  //     try {
  //       yield CartLoaded(
  //         cart: Cart(
  //           products: List.from(state.cart.products)..add(event.product),
  //         ),
  //       );
  //     } catch (_) {}
  //   }
  // }

  // Stream<CartState> _mapCartProductRemovedToState(
  //   RemoveCart event,
  //   CartState state,
  // ) async* {
  //   if (state is CartLoaded) {
  //     try {
  //       yield CartLoaded(
  //         cart: Cart(
  //           products: List.from(state.cart.products)..remove(event.product),
  //         ),
  //       );
  //     } catch (_) {}
  //   }
  // }
}
