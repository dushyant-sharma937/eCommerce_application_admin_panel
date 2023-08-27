import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/controllers/home_controller.dart';
import 'package:get/get.dart';
import '../const/const.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatCollections);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  var isLoading = false.obs;

  dynamic chatDocId;

  getChatId() async {
    isLoading.value = true;
    await chats
        .where('users', isEqualTo: {
          friendId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': "",
              'users': {friendId: null, currentId: null},
              'toId': "",
              'fromId': "",
              'friend_name': senderName,
              'sender_name': friendName,
            }).then((value) => chatDocId = value.id);
          }
        });
    isLoading.value = false;
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': currentId,
        'fromId': friendId,
      });

      chats.doc(chatDocId).collection(messagesCollections).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
