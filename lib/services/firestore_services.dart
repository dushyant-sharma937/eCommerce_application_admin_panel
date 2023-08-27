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
        .where('fromId', isEqualTo: uid)
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

  static getAllMessages(docId) {
    return firestore
        .collection(chatCollections)
        .doc(docId)
        .collection(messagesCollections)
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  static getChatMessages() {
    return firestore
        .collection(chatCollections)
        .where('toId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getUsers() {
    return firestore.collection(userCollections).snapshots();
  }
}
