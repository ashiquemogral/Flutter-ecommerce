import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:flutter_ecommerce_app/repositories/checkout/checkout_repository.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;

  StreamSubscription? _cartSubScription;
  StreamSubscription? _checkoutSubScription;

  CheckoutBloc(
      {required CartBloc cartBloc,
      required CheckoutRepository checkoutRepository})
      : _cartBloc = cartBloc,
        _checkoutRepository = checkoutRepository,
        super(cartBloc.state is CartLoaded
            ? CheckoutLoaded(
                products: (cartBloc.state as CartLoaded).cart.products,
                subtotal: (cartBloc.state as CartLoaded).cart.subTotalString,
                deliveryFee:
                    (cartBloc.state as CartLoaded).cart.deliveryFeeString,
                total: (cartBloc.state as CartLoaded).cart.totalString,
              )
            : CheckoutLoading()) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);
    _cartSubScription = cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        add(UpdateCheckout(cart: state.cart));
      }
    });
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  )  {
    final state = this.state;
    if (state is CheckoutLoaded) {
      emit(
        CheckoutLoaded(
          email: event.email ?? state.email,
          fullName: event.fullName ?? state.fullName,
          products: event.cart?.products ?? state.products,
          deliveryFee: event.cart?.deliveryFeeString ?? state.deliveryFee,
          subtotal: event.cart?.subTotalString ?? state.subtotal,
          total: event.cart?.totalString ?? state.total,
          address: event.address ?? state.address,
          city: event.city ?? state.city,
          country: event.country ?? state.country,
          zipCode: event.zipCode ?? state.zipCode,
        ),
      );
    }
  }

  void _onConfirmCheckout(
      ConfirmCheckout event,
      Emitter<CheckoutState> emit,
      ) async {
    _checkoutSubScription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
        // print('Done');
        emit(CheckoutLoading());
      } catch (_) {}
    }
  }

  // @override
  // Stream<CheckoutState> mapEventToState(CheckoutEvent event,) async* {
  //   if (event is UpdateCheckout){
  //     yield* _mapUpdateCheckoutToState(event, state);
  //   }
  //   if(event is ConfirmCheckout){
  //     yield* _mapConfirmCheckoutToState(event,state);
  //   }
  // }

  // Stream<CheckoutState> _mapUpdateCheckoutToState(
  //     UpdateCheckout event,
  //     CheckoutState state,
  //     )async*{
  //   if(state is CheckoutLoaded){
  //     yield CheckoutLoaded(
  //       email: event.email ?? state.email,
  //       fullName: event.fullName ?? state.fullName,
  //       products: event.cart?.products ?? state.products,
  //       deliveryFee: event.cart?.deliveryFeeString ?? state.deliveryFee,
  //       subtotal: event.cart?.subTotalString ?? state.subtotal,
  //       total: event.cart?.totalString ?? state.total,
  //       address: event.address ?? state.address,
  //       city: event.city ?? state.city,
  //       country: event.country ?? state.country,
  //       zipCode: event.zipCode ?? state.zipCode,
  //
  //     );
  //   }
  // }

  // Stream<CheckoutState> _mapConfirmCheckoutToState(
  //   ConfirmCheckout event,
  //   CheckoutState state,
  // ) async* {
  //   _checkoutSubScription?.cancel();
  //   if (state is CheckoutLoaded) {
  //     try {
  //       await _checkoutRepository.addCheckout(event.checkout);
  //       print('Done');
  //       yield CheckoutLoading();
  //     } catch (_) {}
  //   }
  // }
}
