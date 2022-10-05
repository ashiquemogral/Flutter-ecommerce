import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatelessWidget {
  const GooglePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);

  final String total;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var _paymentItems = products
        .map(
          (product) => PaymentItem(
              amount: product.price.toString(),
              label: product.name,
              type: PaymentItemType.item,
              status: PaymentItemStatus.final_price),
        )
        .toList();

    _paymentItems.add(
      PaymentItem(
        amount: total,
        label: "Total",
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );

    void onGooglePayResult(paymentResult){
      debugPrint(paymentResult.toString());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width-50,
      child: GooglePayButton(
        paymentConfigurationAsset: 'payment_profile_google_pay.json',
        paymentItems: _paymentItems,
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 15.0),
        onPaymentResult: onGooglePayResult,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
