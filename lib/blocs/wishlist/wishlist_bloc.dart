import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:flutter_ecommerce_app/models/wishlist_model.dart';
import 'package:flutter_ecommerce_app/repositories/local_storage/local_storage_repository.dart';
import 'package:hive/hive.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepository _localStorageRepository;

  WishlistBloc({
    required LocalStorageRepository localStorageRepository,
  })  : _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<StartWishlist>(_onStartWishlist);
    on<AddProductToWishlist>(_onAddProductToWishlist);
    on<RemoveProductFromWishlist>(_onRemoveProductFromWishlist);
  }

  void _onStartWishlist(
    event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      Box box = await _localStorageRepository.openBox();
      List<Product> products = _localStorageRepository.getWishList(box);
      await Future<void>.delayed(Duration(seconds: 1));
      emit(
        WishlistLoaded(
          wishlist: Wishlist(products: products),
        ),
      );
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _onAddProductToWishlist(event, Emitter<WishlistState> emit) async {
    final state = this.state;

    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.addProductToWishList(box, event.product);
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products: List.from(state.wishlist.products)..add(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveProductFromWishlist(
    event,
    Emitter<WishlistState> emit,
  ) async {
    final state = this.state;

    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.removeProductFromWishlist(box, event.product);
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products: List.from(state.wishlist.products)
                ..remove(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }
// @override
// Stream<WishlistState> mapEventToState(
//   WishlistEvent event,
// ) async* {
//   if (event is LoadWishlist) {
//     yield* _mapStartWishlistToState();
//   } else if (event is AddProductToWishlist) {
//     yield* _mapAddWishlistProductToState(event, state);
//   } else if (event is RemoveProductFromWishlist) {
//     yield* _mapRemoveWishlistToProductToState(event, state);
//   }
// }

// Stream<WishlistState> _mapStartWishlistToState() async* {
//   yield WishlistLoading();
//   try {
//     await Future<void>.delayed(Duration(seconds: 1));
//     yield const WishlistLoaded();
//   } catch (_) {}
// }

// Stream<WishlistState> _mapAddWishlistProductToState(
//     AddProductToWishlist event, WishlistState state) async* {
//   if (state is WishlistLoaded) {
//     try {
//       yield WishlistLoaded(
//         wishlist: Wishlist(
//           products: List.from(state.wishlist.products)
//             ..add(event.product),
//         ),
//       );
//     } catch (_) {}
//   }
// }

// Stream<WishlistState> _mapRemoveWishlistToProductToState(
//     RemoveProductFromWishlist event, WishlistState state) async* {
//   if (state is WishlistLoaded) {
//     try {
//       yield WishlistLoaded(
//         wishlist: Wishlist(
//           products: List.from(state.wishlist.products)
//             ..remove(event.product),
//         ),
//       );
//     } catch (_) {}
//   }
// }
}
