import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_button.dart';
import 'package:emart_seller/views/widgets/custom_text_field_widget.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Image.network(
                "https://w7.pngwing.com/pngs/184/113/png-transparent-user-profile-computer-icons-profile-heroes-black-silhouette-thumbnail.png",
                width: 80,
              ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              const Divider(color: white),
              20.heightBox,
              customTextField(
                  label: username,
                  hintText: nameHint,
                  controller: profileController.nameController,
                  color: white,
                  borderColor: Colors.black87),
              10.heightBox,
              customPasswordTextField(
                  isPass: profileController.isShowing.value,
                  label: password,
                  hintText: passwordHint,
                  onPress: () {
                    profileController.isShowing.value =
                        !profileController.isShowing.value;
                  },
                  controller: profileController.passController,
                  color: white,
                  borderColor: Colors.black87),
              10.heightBox,
              customPasswordTextField(
                  isPass: profileController.isShowing.value,
                  label: confirmPassword,
                  onPress: () {
                    profileController.isShowing.value =
                        !profileController.isShowing.value;
                  },
                  hintText: passwordHint,
                  controller: profileController.confirmPassController,
                  color: white,
                  borderColor: Colors.black87),
              50.heightBox,
              profileController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : customButton(
                      title: "Save",
                      onPress: () async {
                        profileController.isLoading.value = true;
                        await profileController.updateProfile(
                          name: profileController.nameController.text.trim(),
                          password:
                              profileController.passController.text.trim(),
                        );
                        VxToast.show(context,
                            msg: "Profile updated successfully");
                      },
                      color: green,
                    ).box.size(context.screenWidth * 0.5, 50).makeCentered(),
            ]),
          ),
        ),
      ),
    );
  }
}
