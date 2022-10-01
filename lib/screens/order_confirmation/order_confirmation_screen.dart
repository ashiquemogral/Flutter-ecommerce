import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:flutter_ecommerce_app/widgets/custom_appbar.dart';
import 'package:flutter_ecommerce_app/widgets/custom_navbar.dart';
import 'package:flutter_ecommerce_app/widgets/order_summary.dart';
import 'package:flutter_ecommerce_app/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Order Confirmation',
      ),
      bottomNavigationBar: CustomNavBar(
        screen: routeName,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width - 100) / 2,
                  top: 125,
                  child: SvgPicture.asset(
                    'assets/svgs/garlands.svg',
                  ),
                ),
                Positioned(
                  top: 250,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Your Order is Completed!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDER CODE: #k123-324',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Thank you for purchasing from Unidoor',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ORDER CODE: #k123-324',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  OrderSummary(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ORDER DETAILS',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      OrderSummaryProductCard(product: Product.products[0],quantity: 2,),
                      OrderSummaryProductCard(product: Product.products[1],quantity: 2,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


