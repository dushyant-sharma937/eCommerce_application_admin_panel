import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

Widget productDropdown(
    {hint,
    required List<String> list,
    dropvalue,
    required ProductsController controller}) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: Colors.black87),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (value) {
          if (hint == "Category") {
            controller.subcategoryValue.value = '';
            controller.populateSubcategoryList(value.toString());
          }
          dropvalue.value = value.toString();
        },
      ),
    )
        .box
        .white
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .roundedSM
        .make(),
  );
}
