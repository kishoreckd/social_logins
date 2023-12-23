import 'package:flutter/material.dart';
import 'package:social/pages/login.dart';
import 'package:social/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: avoid_print

// ignore_for_file: use_build_context_synchronously

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  var email = '';
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password Reset Email has been Sent',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: const Text(
              "reset Link will be send to your email",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black12,
                            fontSize: 16,
                          ),
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
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    email = emailController.text;
                                  });
                                  resetPassword();
                                }
                              },
                              child: const Text(
                                'Send Email',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Do not have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, a, b) =>
                                          const SignUp()),
                                  (route) => false);
                            },
                            child: const Text('SignUp'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
