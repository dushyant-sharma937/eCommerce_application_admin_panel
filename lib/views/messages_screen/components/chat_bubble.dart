import 'package:emart_seller/views/widgets/normal_text.dart';

import '../../../const/const.dart';

class ChatBubble extends StatelessWidget {
  // final dynamic data;
  const ChatBubble({
    super.key,
    // required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // var t = data['created_on'] == null
    //     ? DateTime.now()
    //     : data['created_on'].toDate();
    // var time = intl.DateFormat("h:mma").format(t);
    return Directionality(
      // textDirection: data['uid'] == currentUser!.uid
      //     ? TextDirection.rtl
      //     : TextDirection.ltr,
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          // color: data['uid'] == currentUser!.uid
          //     ? Colors.greenAccent.withOpacity(0.5)
          //     : Colors.blueAccent.withOpacity(0.5),
          color: purpleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            // bottomLeft: data['uid'] == currentUser!.uid
            //     ? const Radius.circular(20)
            //     : const Radius.circular(0),
            // bottomRight: data['uid'] == currentUser!.uid
            //     ? const Radius.circular(0)
            //     : const Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          // "${data['msg']}".text.size(16).make(),
          normalText(text: "Your message here"),
          10.heightBox,
          // time.text.color(Colors.black.withOpacity(0.5)).size(12).make(),
          normalText(text: "9:45PM"),
        ]),
      ),
    );
  }
}
