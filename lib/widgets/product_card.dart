import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/blocs.dart';
import 'package:flutter_ecommerce_app/blocs/cart/cart_bloc.dart';

import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard.catalog({
    Key? key,
    required this.product,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 150,
    this.isCatalog = true,
    this.isCart = false,
    this.isSummary = false,
    this.isWishlist = false,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
  }) : super(key: key);

  const ProductCard.cart({
    Key? key,
    required this.product,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 80,
    this.isCatalog = false,
    this.isCart = true,
    this.isSummary = false,
    this.isWishlist = false,
    this.iconColor = Colors.black,
    this.fontColor = Colors.black,
  }) : super(key: key);

  const ProductCard.wishlist({
    Key? key,
    required this.product,
    this.quantity,
    this.widthFactor = 1.1,
    this.height = 150,
    this.isCatalog = false,
    this.isCart = false,
    this.isSummary = false,
    this.isWishlist = true,
    this.iconColor = Colors.white,
    this.fontColor = Colors.white,
  }) : super(key: key);

  const ProductCard.summary({
    Key? key,
    required this.product,
    this.quantity,
    this.widthFactor = 2.25,
    this.height = 80,
    this.isCatalog = false,
    this.isCart = false,
    this.isSummary = true,
    this.isWishlist = false,
    this.iconColor = Colors.black,
    this.fontColor = Colors.black,
  }) : super(key: key);

  final Product product;
  final int? quantity;
  final double widthFactor;
  final double height;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final bool isSummary;
  final Color iconColor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double adjWidth = width / widthFactor;
    return InkWell(
      onTap: () {
        if (isCatalog || isWishlist)
          Navigator.pushNamed(
            context,
            '/product',
            arguments: product,
          );
      },
      child: isCart || isSummary ?
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(children: [
            ProductImage(
              adjWidth: 100,
              product: product,
              height: height,
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: ProductInformation(
                product: product,
                fontColor: fontColor,
                quantity: quantity,
                isOrderSummary: isSummary ? true: false,
              ),
            ),
            const SizedBox(width: 10,),
            ProductActions(
              product: product,
              quantity: quantity,
              isCart: isCart,
              isCatalog: isCatalog,
              isWishlist: isWishlist,
              iconColor: iconColor,
            ),
          ],),
        )
      : Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ProductImage(
            adjWidth: adjWidth,
            product: product,
            height: height,
          ),
          ProductBackground(adjWidth: adjWidth, widgets: [
            ProductInformation(
              product: product,
              fontColor: fontColor,
            ),
            ProductActions(
              product: product,
              isCart: isCart,
              isCatalog: isCatalog,
              isWishlist: isWishlist,
              iconColor: iconColor,
            ),
          ]),
          // Positioned(
          //   top: 60,
          //   left: 5,
          //   child: Container(
          //     width: adjWidth - 10,
          //     height: 80,
          //     decoration: BoxDecoration(
          //       color: Colors.black.withAlpha(50),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 65,
          //   left: 10,
          //   child: Container(
          //     width: adjWidth - 20,
          //     height: 70,
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: ProductActions(product: product),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ProductActions extends StatelessWidget {
  const ProductActions({
    Key? key,
    required this.product,
    required this.isCatalog,
    required this.isCart,
    required this.isWishlist,
    required this.iconColor,
    this.quantity,
  }) : super(key: key);

  final Product product;
  final bool isCatalog;
  final bool isCart;
  final bool isWishlist;
  final Color iconColor;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is CartLoaded) {
              IconButton addProduct = IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to your cart!'),
                    ),
                  );
                  context.read<CartBloc>().add(AddProduct(product));
                },
                icon: Icon(
                  Icons.add_circle,
                  color: iconColor,
                ),
              );
              IconButton removeProduct = IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Removed from your cart!'),
                    ),
                  );
                  context.read<CartBloc>().add(RemoveProduct(product));
                },
                icon: Icon(
                  Icons.remove_circle,
                  color: iconColor,
                ),
              );
              IconButton removeFromWishlist = IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Removed from your wishlist')),
                  );
                  context
                      .read<WishlistBloc>()
                      .add(RemoveProductFromWishlist(product));
                },
                icon: Icon(
                  Icons.delete,
                  color: iconColor,
                ),
              );

              Text productQuantity = Text(
                '$quantity',
                style: Theme.of(context).textTheme.headline4,
              );
              if (isCatalog) {
                return Row(
                  children: [addProduct],
                );
              }
              if (isWishlist) {
                return Row(
                  children: [
                    addProduct,
                    removeFromWishlist,
                  ],
                );
              }
              if (isCart) {
                return Row(
                  children: [
                    removeProduct,
                    productQuantity,
                    addProduct,
                  ],
                );
              } else {
                return SizedBox();
              }
            } else {
              return Text('Something went wrong!');
            }
          },
        ),
      ],
    );
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    Key? key,
    required this.product,
    required this.fontColor,
    this.isOrderSummary = false,
    this.quantity,
  }) : super(key: key);

  final Product product;
  final Color fontColor;
  final bool isOrderSummary;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: fontColor),
            ),
            Text(
              '\$${product.price}',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: fontColor),
            ),
          ],
        ),
        isOrderSummary ? Text(
          'Qty. $quantity',
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: fontColor),
        ): const SizedBox(),
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.adjWidth,
    required this.height,
    required this.product,
  }) : super(key: key);

  final double adjWidth;
  final double height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: adjWidth,
      height: height,
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ProductBackground extends StatelessWidget {
  const ProductBackground({
    Key? key,
    required this.adjWidth,
    required this.widgets,
  }) : super(key: key);

  final double adjWidth;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: adjWidth - 5,
      height: 80,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(50),
      ),
      child: Container(
        width: adjWidth - 10,
        height: 70,
        margin: EdgeInsets.only(bottom: 5),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [...widgets],
          ),
        ),
      ),
    );
  }
}
