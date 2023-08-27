import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/services/firestore_services.dart';
import 'package:emart_seller/views/messages_screen/messages_screen.dart';
import 'package:emart_seller/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_seller/views/profile_screen/show_users_screen.dart';
import 'package:emart_seller/views/shop_screen/shop_setting.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    var profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: "Your Profile", size: 20.0),
        actions: [
          TextButton(
            onPressed: () async {
              await authController.signOut(context: context);
            },
            child: normalText(text: logout, size: 18.0),
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getUserData(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.network(
                        "https://w7.pngwing.com/pngs/184/113/png-transparent-user-profile-computer-icons-profile-heroes-black-silhouette-thumbnail.png",
                        width: 80,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                      title: boldText(text: data['name'], size: 16.0),
                      subtitle: normalText(text: data['email'], size: 16.0),
                    ),
                    const Divider(color: white),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: List.generate(
                            profileButtonIcons.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const ShopSettingScreen());
                                        break;
                                      case 1:
                                        Get.to(() => const MessagesScreen());
                                        break;
                                      case 2:
                                        profileController.isShowing.value =
                                            true;
                                        profileController.nameController.text =
                                            data['name'];
                                        profileController.passController.text =
                                            data['password'];
                                        Get.to(() =>
                                            EditProfileScreen(data: data));
                                        break;
                                      case 3:
                                        Get.to(() => const ShowUserScreen());
                                        break;
                                    }
                                  },
                                  leading: Icon(
                                    profileButtonIcons[index],
                                    color: white,
                                  ),
                                  title: normalText(
                                      text: profileButtonTitles[index],
                                      size: 18.0),
                                )),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
