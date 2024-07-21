import 'package:bus_ticket_booker_flutter/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/bus.png",
              width: 150,
            ),
            const SizedBox(height: 16,),
            const Text(
              "Bus Ticket Booker",
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
