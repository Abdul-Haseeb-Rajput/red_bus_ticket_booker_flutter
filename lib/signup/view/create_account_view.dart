import 'package:bus_ticket_booker_flutter/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final signupController = Get.find<SignupController>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Column(
                children: [
                  Text(
                    "Start By creating an account",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    "Fugiat irure ullamco excepteur duis mollit ullamco aute. Sunt ut enim mollit non duis.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      signupController.navigateToSignUp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // button color
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                          double.infinity, 50), // button height and width
                    ),
                    child: const Text('CREATE AN ACCOUNT'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signupController.navigateToSignIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // button color
                      foregroundColor: Colors.black, // text color
                      minimumSize: const Size(
                          double.infinity, 50), // button height and width
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustRoundRectButton extends StatelessWidget {
  const CustRoundRectButton({
    super.key,
    required this.screenWidth,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    required this.overlayColor,
  });

  final double screenWidth;
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color overlayColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap.call,
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        overlayColor: WidgetStatePropertyAll(
          overlayColor,
        ),
        fixedSize: WidgetStatePropertyAll(
          Size(screenWidth, 50),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),
      child: Text(text),
    );
  }
}
