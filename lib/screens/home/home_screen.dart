import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/category/category_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product/product_bloc.dart';
import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:flutter_ecommerce_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "E-commerce App",
      ),
      bottomNavigationBar: CustomNavBar(screen: routeName,),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryLoaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.5,
                    viewportFraction: .9,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: state.categories
                      .map((category) => HeroCarouselCard(category: category))
                      .toList(),
                );
              } else {
                return Text('Something went wrong');
              }
            },
          ),
          SectionTitle(
            title: 'RECOMMENDED',
          ),
          // ProductCard(
          //   product: Product.products[0],
          // ),
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is ProductLoaded){
              return ProductCarousel(
                products: state.products
                    .where((product) => product.isRecommended)
                    .toList(),
              );
            }
            else{
              return Text('Something went wrong');
            }

          }),
          SectionTitle(
            title: 'MOST POPULAR',
          ),
          BlocBuilder<ProductBloc,ProductState>(
            builder: (context, state) {
              if(state is ProductLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              if(state is ProductLoaded){
                return ProductCarousel(
                  products:
                  Product.products.where((product) => product.isPopular).toList(),
                );
              }
              else{
                return Text('Something went wrong');
              }

            }
          ),
        ],
      ),
    );
  }
}
