import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:incento_demo/Const/colors.dart';
import 'package:incento_demo/Controller/data_controller.dart';
import 'package:incento_demo/Screens/Auth/login.dart';
import 'package:incento_demo/Screens/Mainscreen/cart.dart';
import 'package:incento_demo/Utils/helper.dart';

import '../../Utils/wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return themeWrapper(
        child: Scaffold(
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              circularIconButton(FeatherIcons.logOut, () {
                                Get.offAll(() => Login());
                              }),
                              circularIconButton(FeatherIcons.shoppingCart, () {
                                Get.to(() => const CartScreen());
                              }),
                              //   languageSwitcher(),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Discover\nOur Store',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30)),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Popular Products',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18)),
                          GetBuilder<DataController>(
                            builder: (controller) {
                              return controller.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: accentColor,
                                      ),
                                    )
                                  : controller.allProducts.isEmpty
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/nothing_ill.svg',
                                                height: 200,
                                                width: 200,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                  "There is nothing here."),
                                              TextButton(
                                                child: const Text("Reload"),
                                                onPressed: () {
                                                  controller.getAllProducts();
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: MasonryGridView.count(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                            itemCount:
                                                controller.allProducts.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 5,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(controller
                                                              .allProducts[
                                                                  index]
                                                              .imageUrl ??
                                                          ""),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        controller
                                                                .allProducts[
                                                                    index]
                                                                .name ??
                                                            "Clothes",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1
                                                            ?.copyWith(
                                                                color:
                                                                    accentColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            r'''$''' +
                                                                ' ${controller.allProducts[index].price}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.9),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                controller.editCart(
                                                                    controller
                                                                            .allProducts[
                                                                        index]);
                                                              },
                                                              icon: controller
                                                                      .cart
                                                                      .contains(
                                                                          controller.allProducts[
                                                                              index])
                                                                  ? Icon(
                                                                      FeatherIcons
                                                                          .trash,
                                                                      color: Colors
                                                                          .redAccent,
                                                                    )
                                                                  : Icon(
                                                                      FeatherIcons
                                                                          .plus))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                            },
                          )
                        ])))));
  }
}
