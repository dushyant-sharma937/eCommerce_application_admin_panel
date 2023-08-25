import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../views/splash_screen.dart/splash_screen.dart';

class AuthController extends GetxController {
  var isShowing = false.obs;
  var emailController = TextEditingController();
  var passController = TextEditingController();

  var isLoading = false.obs;

  // login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
      // storeUserData(
      //     password: passController.text.trim(),
      //     email: emailController.text.trim());
      emailController.clear();
      passController.clear();
    } on FirebaseAuthException catch (err) {
      VxToast.show(context, msg: err.message.toString());
    } catch (e) {
      print(e.toString());
    }
    isLoading.value = false;
    return userCredential;
  }

  // // storing data
  // storeUserData({password, email}) async {
  //   DocumentReference store =
  //       firestore.collection(vendorCollections).doc(currentUser!.uid);
  //   store.set({
  //     'password': password,
  //     'email': email,
  //     'name': "",
  //     'id': currentUser!.uid,
  //   });
  //   print("data stored successfully");
  // }

  getUserData() async {
    DocumentReference s =
        firestore.collection(vendorCollections).doc(currentUser!.uid);
    await s.snapshots();
  }

  signOut({context}) async {
    try {
      await auth.signOut();
      Get.offAll(() => const SplashScreen());
      VxToast.show(context, msg: "logout successfully");
    } catch (err) {
      VxToast.show(context, msg: err.toString());
    }
  }
}
