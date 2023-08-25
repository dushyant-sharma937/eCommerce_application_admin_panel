import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/orders_controller.dart';
import 'package:emart_seller/views/widgets/custom_button.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'components/order_details_text_widget.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkGrey,
            ),
          ),
          title: boldText(
              text: "Order Details", color: Colors.black87, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenHeight,
            child: customButton(
              color: green,
              onPress: () {
                controller.confirmed(true);
                controller.changeStatus(
                    title: "order_confirmed",
                    status: true,
                    docId: widget.data.id);
              },
              title: "Confirm Order",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 8, right: 8),
                  child: Column(
                    children: [
                      //order delivery status section
                      Visibility(
                        visible: controller.confirmed.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(
                                text: "Order status:",
                                color: purpleColor,
                                size: 16.0),
                            SwitchListTile(
                              activeColor: green,
                              value: true,
                              onChanged: (value) {},
                              title: boldText(
                                  text: "Placed", color: Colors.black87),
                            ),
                            SwitchListTile(
                              activeColor: green,
                              value: controller.confirmed.value,
                              onChanged: (value) {
                                controller.confirmed.value = value;
                                controller.changeStatus(
                                    title: "order_confirmed",
                                    status: value,
                                    docId: widget.data.id);
                              },
                              title: boldText(
                                  text: "Confirmed", color: Colors.black87),
                            ),
                            SwitchListTile(
                              activeColor: green,
                              value: controller.onDelivery.value,
                              onChanged: (value) {
                                controller.onDelivery.value = value;
                                controller.changeStatus(
                                    title: "order_on_delivery",
                                    status: value,
                                    docId: widget.data.id);
                              },
                              title: boldText(
                                  text: "on Delivery", color: Colors.black87),
                            ),
                            SwitchListTile(
                              activeColor: green,
                              value: controller.delivered.value,
                              onChanged: (value) {
                                controller.delivered.value = value;
                                controller.changeStatus(
                                    title: "order_delivered",
                                    status: value,
                                    docId: widget.data.id);
                              },
                              title: boldText(
                                  text: "Delivered", color: Colors.black87),
                            ),
                          ],
                        )
                            .box
                            .outerShadowMd
                            .white
                            .padding(const EdgeInsets.all(8))
                            .border(color: lightGrey)
                            .roundedSM
                            .make(),
                      ),

                      //order details section
                      Column(
                        children: [
                          OrderPlaceDetails(
                            t1: "Order Code",
                            d1: "${widget.data['order_code']}",
                            t2: "Shipping Method",
                            d2: "${widget.data['shipping_method']}",
                          ),
                          5.heightBox,
                          OrderPlaceDetails(
                            t1: "Order Date",
                            d1: intl.DateFormat.yMd()
                                .format(widget.data['order_date'].toDate()),
                            t2: "Payment Method",
                            d2: "${widget.data['payment_method']}",
                          ),
                          5.heightBox,
                          const OrderPlaceDetails(
                            t1: "Payment Status ",
                            d1: "Unpaid",
                            t2: "Delivery Status",
                            d2: "Order Placed",
                          ),
                          5.heightBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    boldText(
                                        text: "Shipping Address",
                                        color: purpleColor),
                                    10.heightBox,
                                    "${widget.data['order_by_name']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_email']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_address']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_city']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_state']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_mobile']}"
                                        .text
                                        .make(),
                                    "${widget.data['order_by_pincode']}"
                                        .text
                                        .make(),
                                  ],
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      boldText(
                                          text: "Total Amount",
                                          color: purpleColor),
                                      boldText(
                                          text:
                                              "${widget.data['total_amount']}",
                                          color: red,
                                          size: 16.0),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                              .box
                              .outerShadowMd
                              .white
                              .border(color: lightGrey)
                              .roundedSM
                              .make(),
                          const Divider(thickness: 1),
                          10.heightBox,
                          boldText(
                              text: "Orderd Products",
                              color: fontGrey,
                              size: 16.0),
                          10.heightBox,
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                                controller.ordersList.length, (index) {
                              return OrderPlaceDetails(
                                  t1: "${controller.ordersList[index]['title']}",
                                  t2: "${controller.ordersList[index]['tprice']}",
                                  d1: "Quantity: ${controller.ordersList[index]['quantity']}",
                                  d2: "Refundable");
                            }).toList(),
                          )
                              .box
                              .outerShadowMd
                              .white
                              .margin(const EdgeInsets.only(bottom: 4))
                              .make(),
                          20.heightBox,
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
