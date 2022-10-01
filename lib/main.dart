import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/blocs.dart';
import 'package:flutter_ecommerce_app/config/app_router.dart';
import 'package:flutter_ecommerce_app/config/theme.dart';
import 'package:flutter_ecommerce_app/repositories/category/category_repository.dart';
import 'package:flutter_ecommerce_app/repositories/checkout/checkout_repository.dart';
import 'package:flutter_ecommerce_app/repositories/product/product_repository.dart';
import 'package:flutter_ecommerce_app/screens/order_confirmation/order_confirmation_screen.dart';
import 'package:flutter_ecommerce_app/simple_bloc_observer.dart';

import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver(); //here some changes in the max if not working then get it from the git
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WishlistBloc()
            ..add(
              LoadWishlist(),
            ),
        ),
        BlocProvider(
          create: (_) => CartBloc()
            ..add(
              LoadCart(),
            ),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
              LoadCategories(),
            ),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(
              LoadProduct(),
            ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-commerce Demo',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        // initialRoute: SplashScreen.routeName,
        initialRoute: OrderConfirmation.routeName,
      ),
    );
  }
}
