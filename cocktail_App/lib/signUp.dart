import 'package:cocktail_app/signIn.dart';
import 'package:cocktail_app/textinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_back_outlined),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('images/cocktail.png')),
                const SizedBox(height: 50),
                const Text(
                  'Account',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 5),
                UITextInput(
                  controller: emailController,
                  hint: 'example@gmail.com',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Password',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 5),
                UITextInput(
                  controller: passwordController,
                  hint: 'example123@',
                  isObscure: isObscure,
                  keyboardType: TextInputType.visiblePassword,
                  onSuffixIconPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter the password',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 5),
                UITextInput(
                  controller: rePasswordController,
                  hint: 'example123@',
                  isObscure: isObscure,
                  keyboardType: TextInputType.visiblePassword,
                  onSuffixIconPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    if (passwordController.text.trim() !=
                        rePasswordController.text.trim()) {
                      showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                                title: Text(
                                    textAlign: TextAlign.center,
                                    'Passwords do not match'),
                              ));
                      return;
                    }
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());

                      if (!context.mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                      );
                      showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                                title: Text(
                                    textAlign: TextAlign.center,
                                    'Sign Up Success'),
                              ));
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                                title: Text(
                                    textAlign: TextAlign.center,
                                    'Registration failed'),
                              ));
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
