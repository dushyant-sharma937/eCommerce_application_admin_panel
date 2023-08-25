import 'package:emart_seller/views/widgets/normal_text.dart';

import '../../../const/const.dart';

class OrderPlaceDetails extends StatelessWidget {
  final String t1, t2, d1, d2;
  const OrderPlaceDetails({
    super.key,
    required this.t1,
    required this.t2,
    required this.d1,
    required this.d2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // t1.text.fontFamily(semibold).make(),
              // d1.text.color(Colors.red).fontFamily(semibold).make(),
              boldText(text: t1, color: fontGrey),
              boldText(text: d1, color: red),
            ],
          ),
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // t2.text.fontFamily(semibold).make(),
                // d2.text.color(Colors.red).fontFamily(semibold).make(),
                boldText(text: t2, color: purpleColor),
                boldText(text: d2, color: fontGrey)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
