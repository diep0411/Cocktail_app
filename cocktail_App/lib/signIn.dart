import 'package:cocktail_app/main.dart';
import 'package:cocktail_app/signUp.dart';
import 'package:cocktail_app/textinput.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                const SizedBox(height: 50),
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
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor:
                        Colors.blue, // Adjust the color to your liking
                  ),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());

                      if (!context.mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                                title: Text(
                                    textAlign: TextAlign.center,
                                    'Account or password is incorrect'),
                              ));
                    }
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    ),
                    child: const Text(
                      "Register an account?",
                      textAlign: TextAlign.center,
                    ),
                  );
                })
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
