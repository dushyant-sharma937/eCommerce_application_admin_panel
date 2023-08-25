import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:emart_seller/views/widgets/custom_button.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/custom_text_field_widget.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenEmailAuthState();
}

class _LoginScreenEmailAuthState extends State<LoginScreen> {
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: "Login", color: white, size: 20.0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 15),
              customTextField(
                  hintText: "eg. vendor@gmail.com",
                  label: "Email Address",
                  controller: controller.emailController,
                  borderColor: Colors.black87,
                  color: white),
              const SizedBox(height: 15),
              customPasswordTextField(
                hintText: passwordHint,
                label: password,
                controller: controller.passController,
                isPass: !controller.isShowing.value,
                onPress: () {
                  controller.isShowing.value = !controller.isShowing.value;
                },
                color: white,
                borderColor: Colors.black87,
              ),
              const SizedBox(height: 15),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : customButton(
                        title: "Login",
                        onPress: () async {
                          controller.isLoading.value = true;
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context,
                                  msg: "Logged in successfully");
                              Get.offAll(() => const Home());
                            }
                          });
                        },
                        titleColors: Colors.black87,
                        color: white),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
