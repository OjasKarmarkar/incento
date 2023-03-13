import 'package:get/get.dart';
import 'package:incento_demo/Models/product.dart';
import 'package:incento_demo/Utils/helper.dart';
import '../Models/common_response.dart';
import '../Utils/data_source.dart';

class DataController extends GetxController {
  List<Product> allProducts = <Product>[];
  List<Product> cart = <Product>[];
  bool isLoading = false;
  num totalAmt = 0;
  bool couponRedeemed = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getAllProducts() {
    DataSource.getProducts(successCompletion: (CommonResponse cp) {
      isLoading = true;
      update();
      try {
        if (cp.data != null && cp.data != []) {
          for (var d in cp.data) {
            Product v = Product.fromJson(d);

            allProducts.add(v);
          }
        }
        isLoading = false;
      } catch (e) {
        isLoading = false;
        print(e);
      }
      update();
    }, errCompletion: (CommonResponse cp) {
      print(cp.message);
      showSnackbar('Error', cp.message ?? "Unknown error");
    });
  }

  void editCart(Product pt) {
    final items = cart.where((element) => element.name == pt.name).toList();
    if (items.isEmpty) {
      cart.add(pt);
    } else {
      cart.remove(pt);
    }
    totalAmt = 0;
    cart.forEach((element) => totalAmt += element.price ?? 0);
    print(cart);
    print(totalAmt);
    update();
  }
}
