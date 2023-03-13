import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:incento/coupon_list.dart';
import 'package:incento/incento.dart';
import 'package:incento_demo/Const/colors.dart';
import 'package:incento_demo/Controller/data_controller.dart';
import 'package:incento_demo/Utils/helper.dart';
import 'package:incento_demo/Utils/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../Utils/wrapper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Razorpay _razorpay;
  late IncentoSDK incentoSDK;
  final TextEditingController cc = TextEditingController();
  DataController controller = Get.find();

  var maskFormatter = MaskTextInputFormatter(
      mask: '###-###-####', filter: {"#": RegExp(r'^[a-zA-Z0-9]$')});

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    incentoSDK = IncentoSDK();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(num amt) async {
    var options = {
      'key': 'rzp_test_3Sczn3cgezybpy',
      'amount': amt * 100,
      'name': 'Ojas',
      'description': 'Payment',
      'prefill': {'contact': '9167403295', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    incentoSDK.redeem({
      "company_name": "myntra",
      "coupon_code": cc.text,
      "category": "Hats",
      "uid": "ojas"
    }).then((value) {
      if (value['status'] == IncentoSDK.EVENT_REDEEM_SUCCESS) {
        controller.cart.clear();
        controller.couponRedeemed = true;
        controller.update();
      }
    }); 
    Get.back();
    Get.snackbar("SUCCESS: " + response.paymentId!, "Payment Done ! ");
    Get.back();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("ERROR: " + response.code.toString(), response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("EXTERNAL_WALLET: " + response.walletName!, "");
  }

  @override
  Widget build(BuildContext context) {
    return themeWrapper(
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: SingleChildScrollView(
                  child: GetBuilder<DataController>(builder: (controller) {
                    return controller.cart.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/nothing_ill.svg',
                                  height: 200,
                                  width: 200,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text("Cart is empty!!  "),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                circularIconButton(FeatherIcons.chevronLeft,
                                    () {
                                  Get.back();
                                }),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('Shopping Cart',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.cart.length,
                                    itemBuilder: (context, i) {
                                      return Row(
                                        children: [
                                          ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: Size.fromRadius(
                                                      30), // Image radius
                                                  child: Image.network(
                                                    controller.allProducts[i]
                                                            .imageUrl ??
                                                        "",
                                                    height: 50,
                                                    width: 50,
                                                  ))),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.cart[i].name ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    ?.copyWith(
                                                        color: accentColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                              ),
                                              Text(
                                                r'''₹''' +
                                                    ' ${controller.cart[i].price}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    ?.copyWith(
                                                        color: Colors.black
                                                            .withOpacity(0.9),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Summary',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text('₹ ${controller.totalAmt}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: TextField(
                                      inputFormatters: [maskFormatter],
                                      controller: cc,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(FeatherIcons.dollarSign),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 16),
                                        hintText: "Coupon Code",
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: accentColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              onPressed: () async {
                                                if (cc.text.isNotEmpty) {
                                                  Map<String, dynamic> data =
                                                      await incentoSDK.verify({
                                                    "company_name": "myntra",
                                                    "coupon_code": cc.text,
                                                    "category": "hat",
                                                    "amt": controller.totalAmt,
                                                    "uid": "ojas"
                                                  });
                                                  if (data['status'] != null &&
                                                      data['status'] ==
                                                          IncentoSDK
                                                              .EVENT_VERIFY_SUCCESS) {
                                                    showSnackbar("Incento-SDK",
                                                        data['status']);
                                                    openCheckout(data['amt'] ??
                                                        controller.totalAmt);
                                                  } else {
                                                    showSnackbar("Incento-SDK",
                                                        data['status']);
                                                  }
                                                } else {
                                                  showSnackbar("Error",
                                                      "Fill in coupon code");
                                                }
                                              },
                                              child: Text(
                                                "Apply",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        hintStyle: const TextStyle(
                                            color: Color(0xff282828)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: const BorderSide(
                                              color: accentColor, width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).errorColor),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).errorColor),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: accentColor),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                // MyCoupons(apiKey: 'myntra'),
                                // Spacer(),
                                // Align(
                                //   alignment: Alignment.bottomCenter,
                                //   child: SizedBox(
                                //     width: double.infinity,
                                //     child: TextButton(
                                //       child: const Padding(
                                //         padding:
                                //             EdgeInsets.symmetric(vertical: 4),
                                //         child: Text(
                                //           'Proceed to Payment',
                                //           style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 16,
                                //               fontWeight: FontWeight.bold),
                                //           textAlign: TextAlign.end,
                                //         ),
                                //       ),
                                //       style: TextButton.styleFrom(
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(5.0),
                                //         ),
                                //         primary: Colors.white,
                                //         backgroundColor: accentColor,
                                //         onSurface: Colors.grey,
                                //       ),
                                //       onPressed: () {
                                //         openCheckout(controller.totalAmt);
                                //       },
                                //     ),
                                //   ),
                                // ),
                              ]);
                  }),
                ))));
  }
}
