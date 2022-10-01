import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/blocs.dart';
import 'package:flutter_ecommerce_app/blocs/cart/cart_bloc.dart';

import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool additionalButtons;

  const ProductCard({
    Key? key,
    required this.product,
    this.widthFactor = 2.5,
    this.leftPosition = 5,
    this.additionalButtons = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Stack(
        children: [
          Container(
            width: widthValue,
            height: 150,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: leftPosition,
            child: Container(
              width: widthValue - 5 - leftPosition,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
              width: widthValue - 15 - leftPosition,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '\$${product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CartBloc,CartState>(
                      builder: (context, state) {
                        if(state is CartLoading){
                          return Center(
                            child: CircularProgressIndicator(color: Colors.white,),
                          );
                        }
                        if(state is CartLoaded){
                          return Expanded(
                            child: IconButton(
                              onPressed: () {
                                final snackBar = SnackBar(content: Text('Added to your cart!'),);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                context.read<CartBloc>().add(AddProduct(product));
                              },
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        else{
                          return Text('Something went wrong!');
                        }
                      }
                    ),
                    additionalButtons
                        ? Expanded(
                            child: IconButton(
                              onPressed: () {
                                final snackBar = SnackBar(content: Text('Removed from your wishlist'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                context.read<WishlistBloc>().add(RemoveProductFromWishlist(product));
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
