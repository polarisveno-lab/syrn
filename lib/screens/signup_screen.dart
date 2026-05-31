import 'package:flutter/material.dart';

import '../services/api_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();

  final firstNameController =
  TextEditingController();

  final lastNameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final confirmPasswordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> signup() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            'Passwords do not match',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await ApiService.register(

      firstNameController.text.trim(),
      lastNameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      'user',
    );

    setState(() {
      isLoading = false;
    });

    if (result['success']) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            'Account created successfully',
          ),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(result['message']),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: SingleChildScrollView(

          child: Form(

            key: _formKey,

            child: Column(

              children: [

                Text(
                  'Create Account',
                  style:
                  Theme.of(context)
                      .textTheme
                      .headlineLarge,
                ),

                const SizedBox(height: 40),

                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller:
                  confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                    isLoading ? null : signup,
                    child: isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      'Create Account',
                    ),
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