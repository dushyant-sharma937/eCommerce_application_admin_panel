import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/firestore_services.dart';
import 'package:emart_seller/views/messages_screen/chat_screen.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            )),
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var t = data[index]['created_on'] == null
                          ? DateTime.now()
                          : data[index]['created_on'].toDate();
                      var time = intl.DateFormat("h:mma").format(t);
                      return ListTile(
                        onTap: () {
                          Get.to(() => const ChatScreen());
                        },
                        leading: const CircleAvatar(
                          backgroundColor: purpleColor,
                          child: Icon(
                            Icons.person,
                            color: white,
                          ),
                        ),
                        title: boldText(
                            text: "${data[index]['sender_name']}",
                            color: Colors.black87),
                        subtitle: normalText(
                            text: "${data[index]['last_msg']}",
                            color: Colors.black87),
                        trailing: normalText(text: time, color: Colors.black87),
                      );
                    }),
                  ),
                ),
              );
            }
          }),
    );
  }
}
