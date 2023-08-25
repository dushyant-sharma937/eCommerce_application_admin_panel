import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/views/messages_screen/components/chat_bubble.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
        title: boldText(text: chats, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return const ChatBubble();
                    })),
            SizedBox(
              height: 60,
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Enter a message",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor)),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: purpleColor,
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
