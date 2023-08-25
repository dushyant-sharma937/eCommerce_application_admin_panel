import 'package:emart_seller/const/const.dart';

class FirestoreServices {
  static getUserData(uid) {
    return firestore
        .collection(vendorCollections)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getMessages(uid) {
    return firestore
        .collection(chatCollections)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getProducts(uid) {
    return firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }
}
