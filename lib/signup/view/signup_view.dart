import 'package:bus_ticket_booker_flutter/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.find<SignupController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create an account"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: signUpController.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your name',
                  ),
                  validator: (value) => signUpController.validateName(value!),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: signUpController.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Your Email',
                  ),
                  validator: (value) => signUpController.validateEmail(value!),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    controller: signUpController.passwordController,
                    obscureText: signUpController.isPasswordHidden.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          signUpController.isPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: signUpController.togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) =>
                        signUpController.validatePassword(value),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    controller: signUpController.confirmPasswordController,
                    obscureText: signUpController.isConfirmPasswordHidden.value,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          signUpController.isConfirmPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed:
                            signUpController.toggleConfirmPasswordVisibility,
                      ),
                    ),
                    validator: (value) =>
                        signUpController.validateConfirmPassword(
                            signUpController.passwordController.text, value),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Obx(
                    () => signUpController.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.deepPurple,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                signUpController.signUpWithEmailPassword();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.deepPurple, // button color
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity,
                                  50), // button height and width
                            ),
                            child: const Text('CREATE AN ACCOUNT'),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: signUpController.signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // button color
                          foregroundColor: Colors.black, // text color
                          minimumSize: const Size(
                              double.infinity, 50), // button height and width
                        ),
                        child: const Text('GOOGLE'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: signUpController.signInWithFacebook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // button color
                          foregroundColor: Colors.black, // text color
                          minimumSize: const Size(
                              double.infinity, 50), // button height and width
                        ),
                        child: const Text('FACEBOOK'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: signUpController.navigateToSignIn,
                    child: const Text('Already have an account? Sign In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
