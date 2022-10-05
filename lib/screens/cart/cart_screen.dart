import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:flutter_ecommerce_app/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CartScreen(),
    );
  }

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cart",
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                child: Text(
                  'GO TO CHECKOUT',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CartLoaded) {
          Map cart = state.cart.productQuantity(state.cart.products);
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.cart.freeDeliveryString,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(),
                            elevation: 0,
                          ),
                          child: Text(
                            'Add More Items',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: cart.keys.length,
                        itemBuilder: (context, index) {
                          return ProductCard.cart(
                            product: cart.keys.elementAt(index),
                            quantity: cart.values.elementAt(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                OrderSummary(),
                // Column(
                //   children: [
                //     Divider(
                //       thickness: 2,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 40.0, vertical: 10.0),
                //       child: Column(
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 "SUB TOTAL :",
                //                 style: Theme.of(context).textTheme.headline5,
                //               ),
                //               Text(
                //                 '\$${state.cart.subTotalString}',
                //                 style: Theme.of(context).textTheme.headline5,
                //               ),
                //             ],
                //           ),
                //           SizedBox(
                //             height: 10.0,
                //           ),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 "DELIVERY FEE :",
                //                 style: Theme.of(context).textTheme.headline5,
                //               ),
                //               Text(
                //                 '\$${state.cart.deliveryFeeString}',
                //                 style: Theme.of(context).textTheme.headline5,
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //     Stack(
                //       children: [
                //         Container(
                //           width: MediaQuery.of(context).size.width,
                //           height: 60,
                //           decoration: BoxDecoration(
                //             color: Colors.black.withAlpha(50),
                //           ),
                //         ),
                //         Container(
                //           width: MediaQuery.of(context).size.width,
                //           margin: EdgeInsets.all(5.0),
                //           height: 50,
                //           decoration: BoxDecoration(color: Colors.black),
                //           child: Padding(
                //             padding:
                //                 const EdgeInsets.symmetric(horizontal: 30.0),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   "TOTAL :",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .headline5!
                //                       .copyWith(color: Colors.white),
                //                 ),
                //                 Text(
                //                   '\$${state.cart.totalString}',
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .headline5!
                //                       .copyWith(color: Colors.white),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        } else {
          return Text('Something went wrong!');
        }
      }),
    );
  }
}
