import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:flutter_ecommerce_app/models/payment_method_model.dart';
import 'package:flutter_ecommerce_app/widgets/widgets.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const CustomNavBar({
    Key? key,
    required this.screen,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Container(
        height: 70,
        child: (screen == '/product')
            ? AddToCartNavBar(product: product!)
            : (screen == '/cart')
                ? GoToCheckoutNavBar()
                : (screen == '/checkout')
                    ? OrderNowNavBar()
                    : HomeNavBar(),
      ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: _selectNavBar(context, screen)!,
      // ),
    );
  }

  // List<Widget>? _selectNavBar(context, screen) {
  //   switch (screen) {
  //     case '/':
  //       return _buildNavBar(context);
  //     case '/catelog':
  //       return _buildNavBar(context);
  //     case '/wishlist':
  //       return _buildNavBar(context);
  //     case '/order-confirmation':
  //       return _buildNavBar(context);
  //     case '/product':
  //       return _buildAddToCartNavBar(context, product);
  //     case '/car':
  //       return _buildGoToCheckoutNavBar(context);
  //     case '/checkout':
  //       return _buildOrderNowNavBar(context);
  //     case '/payment-selection':
  //       return _buildNavBar(context);
  //
  //     default:
  //       _buildNavBar(context);
  //   }
  // }

  // List<Widget> _buildNavBar(context) {
  //   return [
  //     IconButton(
  //       onPressed: () {
  //         Navigator.pushNamed(context, '/');
  //       },
  //       icon: Icon(
  //         Icons.home,
  //         color: Colors.white,
  //       ),
  //     ),
  //     IconButton(
  //       onPressed: () {
  //         Navigator.pushNamed(context, '/cart');
  //       },
  //       icon: Icon(
  //         Icons.shopping_cart,
  //         color: Colors.white,
  //       ),
  //     ),
  //     IconButton(
  //       onPressed: () {
  //         Navigator.pushNamed(context, '/user');
  //       },
  //       icon: Icon(
  //         Icons.person,
  //         color: Colors.white,
  //       ),
  //     ),
  //   ];
  // }

  // List<Widget> _buildAddToCartNavBar(context, product) {
  //   return [
  //     IconButton(
  //       onPressed: () {},
  //       icon: Icon(
  //         Icons.share,
  //         color: Colors.white,
  //       ),
  //     ),
  //     BlocBuilder<WishlistBloc, WishlistState>(
  //       builder: (context, state) {
  //         return IconButton(
  //           onPressed: () {
  //             context.read<WishlistBloc>().add(AddProductToWishlist(product));
  //             final snackBar =
  //                 SnackBar(content: Text('Added to your wishlist!'));
  //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //           },
  //           icon: Icon(
  //             Icons.favorite,
  //             color: Colors.white,
  //           ),
  //         );
  //       },
  //     ),
  //     BlocBuilder<CartBloc, CartState>(builder: (context, state) {
  //       return ElevatedButton(
  //         style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
  //         onPressed: () {
  //           context.read<CartBloc>().add(AddProduct(product));
  //           Navigator.pushNamed(context, '/cart');
  //         },
  //         child: Text(
  //           'Add to the cart',
  //           style: Theme.of(context).textTheme.headline3,
  //         ),
  //       );
  //     }),
  //   ];
  // }

  // List<Widget> _buildGoToCheckoutNavBar(context) {
  //   return [
  //     ElevatedButton(
  //       style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
  //       onPressed: () {
  //         Navigator.pushNamed(context, '/checkout');
  //       },
  //       child: Text(
  //         'GO TO CHECKOUT',
  //         style: Theme.of(context).textTheme.headline3,
  //       ),
  //     ),
  //   ];
  // }

  // List<Widget> _buildOrderNowNavBar(context) {
  //   return [
  //     BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
  //       if (state is CheckoutLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       if (state is CheckoutLoaded) {
  //         if (Platform.isAndroid) {
  //           switch (state.paymentMethod) {
  //             case PaymentMethod.google_pay:
  //               return GooglePay(
  //                 total: state.total!,
  //                 products: state.products!,
  //               );
  //             case PaymentMethod.credit_card:
  //               return Container(
  //                 child: Text(
  //                   'Pay with Credit Card',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .headline4!
  //                       .copyWith(color: Colors.white),
  //                 ),
  //               );
  //             default:
  //               return GooglePay(
  //                 total: state.total!,
  //                 products: state.products!,
  //               );
  //           }
  //         } else {
  //           return ElevatedButton(
  //             onPressed: () {
  //               Navigator.pushNamed(context, '/payment-selection');
  //             },
  //             child: Text(
  //               'CHOOSE PAYMENT',
  //               style: Theme.of(context).textTheme.headline3,
  //             ),
  //           );
  //         }
  //         // return ElevatedButton(
  //         //   style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
  //         //   onPressed: () {
  //         //     context
  //         //         .read<CheckoutBloc>()
  //         //         .add(ConfirmCheckout(checkout: state.checkout));
  //         //     Navigator.pushNamed(context, '/order-confirmation');
  //         //   },
  //         //   child: Text(
  //         //     'ORDER NOW',
  //         //     style: Theme.of(context).textTheme.headline3,
  //         //   ),
  //         // );
  //       } else {
  //         return Text('Something went wrong');
  //       }
  //     }),
  //   ];
  // }
}

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/user');
          },
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class OrderNowNavBar extends StatelessWidget {
  const OrderNowNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CheckoutLoaded) {
            if(state.paymentMethod == PaymentMethod.credit_card){
              return Container(
                child: Text(
                  'Pay with Credit Card',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white),
                ),
              );
            } else if (Platform.isAndroid && state.paymentMethod == PaymentMethod.google_pay) {
              return GooglePay(
                    total: state.total!,
                    products: state.products!,
                  );
              } else {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment-selection');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  'CHOOSE PAYMENT',
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white,),
                ),
              );
            }
            // return ElevatedButton(
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            //   onPressed: () {
            //     context
            //         .read<CheckoutBloc>()
            //         .add(ConfirmCheckout(checkout: state.checkout));
            //     Navigator.pushNamed(context, '/order-confirmation');
            //   },
            //   child: Text(
            //     'ORDER NOW',
            //     style: Theme.of(context).textTheme.headline3,
            //   ),
            // );
          } else {
            return Text('Something went wrong');
          }
        }),
      ],
    );
  }
}

class GoToCheckoutNavBar extends StatelessWidget {
  const GoToCheckoutNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/checkout');
          },
          child: Text(
            'GO TO CHECKOUT',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}

class AddToCartNavBar extends StatelessWidget {
  const AddToCartNavBar({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.read<WishlistBloc>().add(AddProductToWishlist(product));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to your wishlist!'),
                  ),
                );
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            );
          },
        ),
        BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              context.read<CartBloc>().add(AddProduct(product));
              Navigator.pushNamed(context, '/cart');
            },
            child: Text(
              'Add to the cart',
              style: Theme.of(context).textTheme.headline3,
            ),
          );
        }),
      ],
    );
  }
}
