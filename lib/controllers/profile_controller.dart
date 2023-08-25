import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  var isShowing = false.obs;

  var nameController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  var shopNameController = TextEditingController();
  var shopAddController = TextEditingController();
  var shopMobController = TextEditingController();
  var shopWebController = TextEditingController();
  var shopDescController = TextEditingController();

  updateProfile({name, password}) async {
    var store = firestore.collection(vendorCollections).doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
    }, SetOptions(merge: true));
    isLoading.value = false;
  }

  updateShop({shopName, shopAdd, shopMob, shopDesc, shopWeb}) async {
    var store = firestore.collection(vendorCollections).doc(currentUser!.uid);
    await store.set({
      'shop_name': shopName,
      'shop_add': shopAdd,
      'shop_mob': shopMob,
      'shop_desc': shopDesc,
      'shop_web': shopWeb
    }, SetOptions(merge: true));
    isLoading.value = false;
  }
}
