import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/home_controller.dart';
import 'package:emart_seller/services/firestore_services.dart';
import 'package:emart_seller/views/products_screen/product_detail.dart';
import 'package:emart_seller/views/widgets/app_bar_widget.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

import '../widgets/dashboard_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      appBar: customAppBar(title: dashboard),
      body: StreamBuilder(
          stream: FirestoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: purpleColor,
              ));
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: boldText(
                      text: "There are no popular products right now",
                      size: 18,
                      color: purpleColor));
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              controller.getQuantity(data);
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DashBoardButton(
                              title: totalproducts,
                              number: "${data.length}",
                              image: icProducts,
                            ),
                            DashBoardButton(
                              title: quantity,
                              number: "${controller.quantity.value}",
                              image: icProducts,
                            ),
                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DashBoardButton(
                              title: rating,
                              number: "${controller.avgRating.value}",
                              image: icProducts,
                            ),
                            DashBoardButton(
                              title: quantity,
                              number: "${controller.quantity.value}",
                              image: icProducts,
                            ),
                          ],
                        ),
                        10.heightBox,
                        const Divider(),
                        10.heightBox,
                        boldText(
                            text: popularProducts,
                            color: Colors.black,
                            size: 16.0),
                        ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(data.length, (index) {
                            return data[index]['p_wishlist'].length == 0
                                ? const SizedBox()
                                : Card(
                                    margin: const EdgeInsets.all(8),
                                    color: Colors.grey.shade100,
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(() => ProductDetails(
                                              data: data[index],
                                            ));
                                      },
                                      leading: Image.network(
                                          data[index]['p_imgs'][0],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover),
                                      title: boldText(
                                          text: "${data[index]['p_name']}",
                                          color: Colors.black87),
                                      subtitle: normalText(
                                          text: "${data[index]['p_price']}",
                                          color: Colors.red),
                                    ),
                                  );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
