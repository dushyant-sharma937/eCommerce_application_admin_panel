import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
        title: boldText(
            text: "${data['p_name']}", color: Colors.black87, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                height: 350,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemCount: data['p_imgs'].length,
                // itemCount: data['p_imgs'].length,
                itemBuilder: (context, index) {
                  return Image.network(
                    data['p_imgs'][index],
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  );
                }),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "${data['p_name']}",
                      color: Colors.black87,
                      size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: Colors.black87,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text: "${data['p_subcategory']}",
                          color: Colors.black87,
                          size: 16.0),
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                    isSelectable: false,
                    stepInt: false,
                  ),
                  10.heightBox,
                  boldText(text: "${data['p_price']}", color: red, size: 18.0),
                  10.heightBox,
                  20.heightBox,
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: "Quantity: "
                            .text
                            .color(textfieldGrey)
                            .color(Colors.black87)
                            .bold
                            .make(),
                      ),
                      normalText(
                          text: "${data['p_quantity']}", color: Colors.black87)
                    ],
                  ).box.white.shadowSm.padding(const EdgeInsets.all(8)).make(),
                  const Divider(),
                  10.heightBox,
                  "Description".text.color(Colors.black87).semiBold.make(),
                  10.heightBox,
                  normalText(text: "${data['p_desc']}", color: Colors.black54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
