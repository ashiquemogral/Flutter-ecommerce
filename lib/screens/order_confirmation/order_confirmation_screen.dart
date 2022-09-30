import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/widgets/custom_appbar.dart';
import 'package:flutter_ecommerce_app/widgets/custom_navbar.dart';

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
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
