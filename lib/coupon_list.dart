import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:incento/common_response.dart';
import 'package:incento/data_source.dart';
import 'coupon.dart';

class MyCoupons extends StatefulWidget {
  const MyCoupons({super.key, required this.apiKey});

  final String apiKey;

  @override
  State<MyCoupons> createState() => _MyCouponsState();
}

class _MyCouponsState extends State<MyCoupons> {
  Color primaryColor = const Color(0xffcbf3f0);
  Color secondaryColor = const Color(0xff368f8b);
  List<Coupons> cpns = [];

  Widget coupon(Coupons cp) {
    return CouponCard(
      height: 150,
      backgroundColor: primaryColor,
      curveAxis: Axis.vertical,
      firstChild: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '23%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.white54, height: 0),
            const Expanded(
              child: Center(
                child: Text(
                  'WINTER IS\nHERE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coupon Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 4),
            Text(
              cp.code ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              'Valid Till - ${cp.expiresAt}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Coupons>> getAllCoupons(String key) async {
    await DataSource.getAllCoupons(
      key,
      successCompletion: (CommonResponse cp) {
        if (cp.data != null && cp.data != []) {
          print(cp.data);
          for (int i = 0; i < cp.data; i++) {
            cpns.add(Coupons.fromJson(cp.data[i]));
          }
        }
        setState(() {});
      },
      errCompletion: (CommonResponse cp) {
        print(cp.message);
      },
    );
    print(cpns.length);
    return cpns;
  }

  @override
  void initState() {
    getAllCoupons(widget.apiKey);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
      itemCount: cpns.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(height: 130, width: 300, child: coupon(cpns[index]));
      },
    ));
  }
}
