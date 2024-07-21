import 'package:bus_ticket_booker_flutter/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Obx(
        () {
          if (profileController.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Obx(
                        () {
                          final profileUrl =
                              profileController.userModel.value.profileUrl;
                          return CircleAvatar(
                            radius: 80,
                            backgroundImage: profileUrl.isNotEmpty
                                ? NetworkImage(profileUrl)
                                : const AssetImage('assets/images/dummy_user.png')
                                    as ImageProvider,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await profileController.updateProfilePicture();
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        "Name",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        profileController.userModel.value.name,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Email",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        profileController.userModel.value.email,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      profileController.logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
