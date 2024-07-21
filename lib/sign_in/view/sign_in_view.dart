import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signin_controller.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final signInController = Get.find<SigninController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Sign in to your account"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: signInController.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) => signInController.validateEmail(value!),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextFormField(
                  controller: signInController.passwordController,
                  obscureText: signInController.isPasswordHidden.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        signInController.isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: signInController.togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) =>
                      signInController.validatePassword(value!),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implement forgot password logic
                  },
                  child: const Text('Forgot your password?'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Obx(
                  () => signInController.isLoading.value == true
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              signInController.signInWithEmailPassword();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple, // button color
                            foregroundColor: Colors.white,
                            minimumSize: const Size(
                                double.infinity, 50), // button height and width
                          ),
                          child: const Text('SIGN IN'),
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
                      onPressed: () {
                        signInController.signInWithGoogle();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // button color
                        foregroundColor: Colors.black, // text color
                        minimumSize: const Size(
                            double.infinity, 50), // button height and width
                      ),
                      child: const Text('GOOGLE'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: signInController.signInWithFacebook,
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
                  onPressed: signInController.signUp,
                  child: const Text('Not a member ? Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
