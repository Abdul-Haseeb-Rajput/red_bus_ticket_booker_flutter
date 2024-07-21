import 'package:bus_ticket_booker_flutter/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!GetUtils.isEmail(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Sign in function
  Future<void> signInWithEmailPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (validateEmail(email) == null && validatePassword(password) == null) {
      try {
        isLoading.value = true;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
        if (user != null) {
          naviagteToHome();
        }
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'user-not-found':
            message = 'No user found for that email.';
            break;
          case 'wrong-password':
            message = 'Wrong password provided.';
            break;
          case 'invalid-email':
            message = 'The email address is not valid.';
            break;
          default:
            message = 'An unknown error occurred.';
        }

        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: message,
            duration: const Duration(seconds: 3),
          ),
        );
      } catch (e) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: 'An error occurred. Please try again. ${e.toString()}',
            duration: const Duration(seconds: 3),
          ),
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'Please enter valid email and password.',
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void signInWithGoogle() {}

  void signInWithFacebook() {}

  void signUp() {
    Get.toNamed(RoutesNames.signupView);
  }

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    super.onClose();
  }

  void naviagteToHome() {
    Get.toNamed(RoutesNames.homeView);
  }
}
