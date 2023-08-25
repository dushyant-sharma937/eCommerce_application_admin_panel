import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  var ordersList = [];

  getOrders(data) {
    ordersList.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        ordersList.add(item);
      }
    }
  }

  changeStatus({title, status, docId}) async {
    var store = firestore.collection(ordersCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
