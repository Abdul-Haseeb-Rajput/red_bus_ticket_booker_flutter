import 'package:bus_ticket_booker_flutter/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 4), () {
      checkAuthState();
    });
  }

  @override
  void onClose() {
    super.onClose();
    FirebaseAuth.instance
        .authStateChanges()
        .listen(
          (User? user) {},
        )
        .cancel();
  }

  void checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // User is not logged in, navigate to the signup view
        Get.offNamed(RoutesNames.createAccountView);
      } else {
        // User is logged in, navigate to the home view
        Get.offNamed(RoutesNames.homeView);
      }
    });
  }
}
