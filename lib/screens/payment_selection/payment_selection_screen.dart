import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/category/category_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/payment/payment_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product/product_bloc.dart';
import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:flutter_ecommerce_app/models/payment_method_model.dart';
import 'package:flutter_ecommerce_app/widgets/widgets.dart';
import 'package:pay/pay.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => PaymentSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Payment Selection",
      ),
      bottomNavigationBar: CustomNavBar(
        screen: routeName,
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
        if (state is PaymentLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state is PaymentLoaded) {
          return ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              // RawApplePayButton(style: ApplePayButtonStyle.black,type: ApplePayButtonType.inStore,onPressed: (){
              //   print('Apple Pay Selected');
              // },),
              Platform.isAndroid
                  ? RawGooglePayButton(
                      type: GooglePayButtonType.pay,
                      onPressed: () {
                        context.read<PaymentBloc>().add(
                              SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.google_pay),
                            );
                        Navigator.pop(context);
                      },
                    )
                  : SizedBox(),
              ElevatedButton(
                onPressed: () {
                  context.read<PaymentBloc>().add(
                        SelectPaymentMethod(
                          paymentMethod: PaymentMethod.credit_card,
                        ),
                      );
                  Navigator.pop(context);
                },
                child: Text('Pay with Credit Card'),
              ),
            ],
          );
        } else {
          return Text('Something went wrong');
        }
      }),
    );
  }
}
