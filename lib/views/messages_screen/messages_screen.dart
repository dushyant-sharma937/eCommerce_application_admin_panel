import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import '../../services/firestore_services.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Messages".text.white.semiBold.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getChatMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No messages yet!".text.color(Colors.black87).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Get.to(() => const ChatScreen(), arguments: [
                                  data[index]['sender_name'],
                                  data[index]['fromId'],
                                ]);
                              },
                              leading: const CircleAvatar(
                                backgroundColor: purpleColor,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: "${data[index]['sender_name']}"
                                  .text
                                  .semiBold
                                  .color(Colors.black87)
                                  .make(),
                              subtitle:
                                  "${data[index]['last_msg']}".text.make(),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
