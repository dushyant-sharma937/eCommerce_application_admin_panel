// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/firestore_services.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/views/products_screen/add_product.dart';
import 'package:emart_seller/views/products_screen/product_detail.dart';
import 'package:emart_seller/views/widgets/app_bar_widget.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

import '../../controllers/products_controller.dart';
import '../widgets/dialogue_box.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => const AddProductScreen());
        },
        backgroundColor: purpleColor,
        child: const Icon(Icons.add),
      ),
      appBar: customAppBar(title: products),
      body: StreamBuilder(
          stream: FirestoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: boldText(
                      text: "No product available",
                      size: 18.0,
                      color: purpleColor));
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      return Card(
                        margin: const EdgeInsets.all(8),
                        color: Colors.grey.shade100,
                        child: ListTile(
                          onTap: () {
                            Get.to(() => ProductDetails(data: data[index]));
                          },
                          leading: Image.network(data[index]['p_imgs'][0],
                              width: 100, height: 100, fit: BoxFit.cover),
                          title: boldText(
                              text: "${data[index]['p_name']}",
                              color: Colors.black87),
                          subtitle: Row(
                            children: [
                              normalText(
                                  text: "${data[index]['p_price']}",
                                  color: Colors.black87),
                              10.widthBox,
                              boldText(
                                  text: data[index]['is_featured']
                                      ? "Featured"
                                      : '',
                                  color: green)
                            ],
                          ),
                          trailing: VxPopupMenu(
                            menuBuilder: () => Column(
                              children: List.generate(
                                popupMenutitle.length,
                                (i) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: controller.isLoading.value == true
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.black87))
                                      : Row(
                                          children: [
                                            Icon(
                                              popupMenuIconsList[i],
                                              color:
                                                  "${data[index]['featured_id']}" ==
                                                              currentUser!
                                                                  .uid &&
                                                          i == 0
                                                      ? green
                                                      : Colors.black87,
                                            ),
                                            10.widthBox,
                                            normalText(
                                              text:
                                                  "${data[index]['featured_id']}" ==
                                                              currentUser!
                                                                  .uid &&
                                                          i == 0
                                                      ? "Remove Featured"
                                                      : popupMenutitle[i],
                                              color: Colors.black87,
                                            )
                                          ],
                                        ).onTap(() async {
                                          switch (i) {
                                            case 0:
                                              controller.isLoading.value = true;
                                              if (data[index]['is_featured'] ==
                                                  true) {
                                                await controller.removeFeatured(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg:
                                                        "Removed from Featured");
                                              } else {
                                                await controller.addFeatured(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: "Added to Featured");
                                              }
                                              break;
                                            case 1:
                                              Get.offAll(() => const Home());
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    CustomDialogueBox(
                                                  text:
                                                      "Are you sure to remove this order",
                                                  context: context,
                                                  onPressNo: () {
                                                    Navigator.pop(context);
                                                  },
                                                  onPressYes: () async {
                                                    controller.isLoading.value =
                                                        true;
                                                    await controller
                                                        .removeProduct(
                                                            data[index].id);
                                                    VxToast.show(context,
                                                        msg:
                                                            "Product removed successfully");
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                barrierDismissible: false,
                                              );

                                              break;
                                          }
                                        }),
                                ),
                              ),
                            ).box.rounded.white.width(200).make(),
                            clickType: VxClickType.singleClick,
                            child: const Icon(Icons.more_vert_rounded),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            }
          }),
    );
  }
}
