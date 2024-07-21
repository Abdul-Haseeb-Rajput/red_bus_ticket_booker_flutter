import 'package:bus_ticket_booker_flutter/models/user_model.dart';
import 'package:bus_ticket_booker_flutter/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!GetUtils.isEmail(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'name cannot be empty';
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

  String? validateConfirmPassword(String password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password cannot be empty';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> signUpWithEmailPassword() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (validateName(name) == null &&
        validateEmail(email) == null &&
        validatePassword(password) == null &&
        validateConfirmPassword(password, confirmPassword) == null &&
        passwordController.text == confirmPasswordController.text) {
      try {
        isLoading.value = true;
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
        if (user != null) {
          UserModel newUser = UserModel(
            uid: user.uid,
            name: nameController.text,
            email: email,
            profileUrl: '',
          );
          await firestore
              .collection('users')
              .doc(user.uid)
              .set(newUser.toMap())
              .then(
                (value) => Get.snackbar(
                  "Account created",
                  "",
                  duration: const Duration(seconds: 2),
                ),
              );

          // Navigate to another screen if needed
        }
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'weak-password':
            message = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            message = 'The account already exists for that email.';
            break;
          case 'invalid-email':
            message = 'The email address is not valid.';
            break;
          default:
            message = 'An unknown error occurred.';
        }

        Get.showSnackbar(
          GetSnackBar(
            title: message,
          ),
        );
      } catch (e) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'An error occurred. Please try again. ${e.toString()}',
          ),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void signInWithGoogle() {}

  void signInWithFacebook() {}

  void navigateToSignIn() {
    Get.offNamed(RoutesNames.signInView);
  }

  void navigateToSignUp() {
    Get.offNamed(RoutesNames.signupView);
  }

  @override
  void onClose() {
    super.onClose();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
