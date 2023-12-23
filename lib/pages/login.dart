import 'package:flutter/material.dart';
import 'package:social/pages/user.dart';
import 'package:social/pages/forgot.dart';
import 'package:social/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: avoid_print

// ignore_for_file: use_build_context_synchronously

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email = '';

  var password = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const UserMain()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found in that email');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No user found in that email',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('wrong password');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Wrong password provided by the user',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.black26, fontSize: 15),
                ),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter valid email';
                  } else if (!value.contains('@')) {
                    return 'please enter valid email';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                autofocus: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.black26, fontSize: 15),
                ),
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter valid Password';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      userLogin();
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPass()),
                    );
                  },
                  child: const Text(
                    'Fogot Password',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('do not have an account? '),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, a, b) => const SignUp(),
                          transitionDuration: const Duration(seconds: 0),
                        ));
                  },
                  child: const Text('Sign Up'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
