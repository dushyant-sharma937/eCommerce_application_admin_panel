import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/firestore_services.dart';
import 'package:emart_seller/views/orders_screen/order_details.dart';
import 'package:emart_seller/views/widgets/app_bar_widget.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Orders"),
      body: StreamBuilder(
          stream: FirestoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: boldText(
                    text: "No orders right now!",
                    color: purpleColor,
                    size: 18.0),
              );
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                      data.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => OrderDetails(
                                  data: data[index],
                                ));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          tileColor: Colors.blueAccent.withOpacity(0.3),
                          title: boldText(
                              text: "${data[index]['order_code']}",
                              color: purpleColor),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: fontGrey,
                                  ),
                                  10.widthBox,
                                  normalText(
                                      text: intl.DateFormat().add_yMd().format(
                                          data[index]['order_date'].toDate()),
                                      color: Colors.black87),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.payment,
                                    color: fontGrey,
                                  ),
                                  10.widthBox,
                                  boldText(
                                      text: data[index]['order_delivered']
                                          ? "Completed"
                                          : "Unpaid",
                                      color: data[index]['order_delivered']
                                          ? green
                                          : red),
                                ],
                              ),
                            ],
                          ).box.margin(const EdgeInsets.all(8)).make(),
                          trailing: boldText(
                              text: "${data[index]['total_amount']}",
                              color: purpleColor,
                              size: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
