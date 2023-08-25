import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/views/products_screen/components/product_dropdown_widget.dart';
import 'package:emart_seller/views/products_screen/components/product_images.dart';
import 'package:emart_seller/views/widgets/custom_text_field_widget.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import '../../const/const.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
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
          title: boldText(text: "Add Product", size: 16.0),
          actions: [
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator(color: white))
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImages();
                      await controller.uploadProducts(context);
                      controller.clearAllControllers();
                      Get.back();
                    },
                    child: boldText(text: "Save", color: white))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                  borderColor: Colors.black87,
                  color: white,
                  hintText: "Enter you product name",
                  label: "Product Name",
                  controller: controller.pnameController,
                ),
                20.heightBox,
                customTextField(
                  borderColor: Colors.black87,
                  color: white,
                  hintText: "Tell us something about this product",
                  label: "Description",
                  isDesc: true,
                  controller: controller.pdescController,
                ),
                20.heightBox,
                customTextField(
                  borderColor: Colors.black87,
                  color: white,
                  hintText: "What should be the price of this product",
                  label: "Price",
                  controller: controller.ppriceController,
                ),
                20.heightBox,
                customTextField(
                  borderColor: Colors.black87,
                  color: white,
                  hintText: "Enter the quantity of the product you have",
                  label: "Quantity",
                  controller: controller.pquantityController,
                ),
                20.heightBox,
                productDropdown(
                    list: controller.categoryList,
                    hint: "Category",
                    dropvalue: controller.categoryValue,
                    controller: controller),
                20.heightBox,
                productDropdown(
                    hint: "Subcategory",
                    list: controller.subcategoryList,
                    dropvalue: controller.subcategoryValue,
                    controller: controller),
                20.heightBox,
                const Divider(color: white),
                20.heightBox,
                boldText(text: "Choose product Images"),
                20.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => controller.pImageList[index] != null
                          ? Image.file(
                              controller.pImageList[index],
                              width: 100,
                            ).onTap(() {
                              controller.pickImagea(index, context);
                            })
                          : productImage(label: (index + 1).toString())
                              .onTap(() {
                              controller.pickImagea(index, context);
                            }),
                    ),
                  ),
                ),
                10.heightBox,
                normalText(
                    text: "(First image will be your display image)",
                    color: lightGrey),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
