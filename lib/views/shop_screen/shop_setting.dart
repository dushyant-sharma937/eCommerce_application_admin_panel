import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_text_field_widget.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ShopSettingScreen extends StatelessWidget {
  const ShopSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: purpleColor,
          appBar: AppBar(
            title: boldText(text: shopSettings, size: 16.0),
            actions: [
              controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : TextButton(
                      onPressed: () async {
                        controller.isLoading.value = true;
                        await controller.updateShop(
                          shopAdd: controller.shopAddController.text.trim(),
                          shopDesc: controller.shopDescController.text.trim(),
                          shopMob: controller.shopMobController.text.trim(),
                          shopName: controller.shopNameController.text.trim(),
                          shopWeb: controller.shopWebController.text.trim(),
                        );

                        VxToast.show(context, msg: "Shop updated successfully");
                      },
                      child: normalText(text: save))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                customTextField(
                    label: shopName,
                    hintText: nameHint,
                    controller: controller.shopNameController,
                    color: white,
                    borderColor: Colors.black87),
                10.heightBox,
                customTextField(
                    label: address,
                    hintText: shopAddressHint,
                    controller: controller.shopAddController,
                    color: white,
                    borderColor: Colors.black87),
                10.heightBox,
                customTextField(
                    label: mobile,
                    hintText: shopMobileHint,
                    controller: controller.shopMobController,
                    color: white,
                    borderColor: Colors.black87),
                10.heightBox,
                customTextField(
                    label: website,
                    hintText: shopWebsiteHint,
                    controller: controller.shopWebController,
                    color: white,
                    borderColor: Colors.black87),
                10.heightBox,
                customTextField(
                    label: description,
                    hintText: shopDescHint,
                    isDesc: true,
                    controller: controller.shopDescController,
                    color: white,
                    borderColor: Colors.black87),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
