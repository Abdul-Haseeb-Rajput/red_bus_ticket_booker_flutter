import 'dart:io';

import 'package:bus_ticket_booker_flutter/models/user_model.dart';
import 'package:bus_ticket_booker_flutter/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  Rx<UserModel> userModel = UserModel(
    uid: '',
    name: '',
    email: '',
    profileUrl: '',
  ).obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      loading.value = true;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      userModel.value =
          UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('Failed to fetch user data: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> updateProfilePicture() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        loading.value = true;
        final userId = FirebaseAuth.instance.currentUser!.uid;
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pics')
            .child('$userId.jpg');

        await storageRef.putFile(File(pickedFile.path));
        final downloadUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'profileUrl': downloadUrl});

        userModel.update((user) {
          if (user != null) {
            user.profileUrl = downloadUrl;
          }
        });
      }
    } catch (e) {
      // print('Failed to update profile picture: $e');
    } finally {
      loading.value = false;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offNamed(RoutesNames.signInView);
  }
}
