import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/firestore_services.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';

class ShowUserScreen extends StatelessWidget {
  const ShowUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: "Show Users".text.bold.white.make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: "There are no registered users right now"
                      .text
                      .bold
                      .black
                      .make());
            } else {
              var data = snapshot.data!.docs;
              return SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(
                          text: "Registered Users",
                          color: purpleColor,
                          size: 16.0),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              elevation: 2,
                              shadowColor: purpleColor,
                              margin: const EdgeInsets.all(8),
                              // color: Colors.grey,
                              color: Colors.grey.shade100,
                              child: ListTile(
                                leading: Image.asset(
                                  icProfile,
                                  width: 20,
                                  height: 20,
                                  color: Colors.blueAccent,
                                )
                                    .box
                                    .margin(const EdgeInsets.only(
                                        right: 8, top: 8, bottom: 8))
                                    .padding(const EdgeInsets.all(8))
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    // .size(60, 60)
                                    .border(color: Colors.blueAccent, width: 2)
                                    .make(),
                                title: boldText(
                                    text: "${data[index]['name']}",
                                    color: Colors.black87,
                                    size: 20.0),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    normalText(
                                        text: "${data[index]['phone']}",
                                        color: Colors.black87,
                                        size: 18.0),
                                    normalText(
                                        text: "${data[index]['address']}",
                                        color: Colors.black87,
                                        size: 16.0),
                                  ],
                                ),
                              )
                                  .box
                                  .padding(const EdgeInsets.only(
                                      top: 8, bottom: 16, right: 16))
                                  .make(),
                            );
                          })
                    ],
                  ),
                ),
              ));
            }
          }),
    );
  }
}
