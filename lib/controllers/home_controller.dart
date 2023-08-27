import 'package:emart_seller/const/const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUsername();
  }

  var navIndex = 0.obs;
  var username = '';
  var quantity = 0.obs;
  var avgRating = (0.0).obs;

  getUsername() async {
    var n = await firestore
        .collection(vendorCollections)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }

  getQuantity(data) async {
    quantity.value = 0;
    avgRating.value = 0.0;
    for (int i = 0; i < data.length; i++) {
      quantity.value += int.parse(data[i]['p_quantity']);
      avgRating.value += double.parse(data[i]['p_rating']);
    }
    double x = avgRating.value / double.parse("${data.length}");
    avgRating.value = x;
  }
}
