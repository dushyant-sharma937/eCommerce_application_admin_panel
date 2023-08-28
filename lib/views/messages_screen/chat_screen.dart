import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import '../../controllers/chats_controller.dart';
import '../../services/firestore_services.dart';
import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: white,
            )),
        title: "${controller.friendName}".text.white.semiBold.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreServices.getAllMessages(
                            controller.chatDocId),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return "You have no chat history, Send a message to initiate the chat"
                                .text
                                .makeCentered();
                          } else {
                            return ListView(
                              reverse: true,
                              shrinkWrap: true,
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: ChatBubble(data: data));
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    hintText: "Send a message to the Seller",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                )),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.red,
                  ),
                ),
              ],
            )
                .box
                .margin(const EdgeInsets.symmetric(vertical: 4, horizontal: 8))
                .height(60)
                .make(),
          ],
        ),
      ),
    );
  }
}
