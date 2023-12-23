import 'package:flutter/material.dart';
import 'package:social/pages/user.dart';
import 'package:social/pages/login.dart';
import 'package:social/pages/forgot.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: avoid_print

// ignore_for_file: use_build_context_synchronously

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var email = '';

  var password = '';
  var confirmpassword = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  userRegistration() async {
    if (password == confirmpassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Registered Successfully , please LogIn',
              style: TextStyle(fontSize: 18),
            ),
          ),
        );

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('password is too weak');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.blueGrey,
              content: Text(
                'Password is too weak',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print('Account already exists');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.blueGrey,
              content: Text(
                'Email already exists',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          );
        }
      }
    } else {
      print('Password and confirm Password does not match');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Password and confirm Password does not match',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
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
              padding: EdgeInsets.all(10.0),
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
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                autofocus: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.black26, fontSize: 15),
                ),
                controller: confirmpasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter previous Password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
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
                        confirmpassword = confirmpasswordController.text;
                      });
                      userRegistration();
                    }

                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, a, b) => const LoginPage(),
                            transitionDuration: Duration(seconds: 0),
                          ));
                    },
                    child: const Text('Log In'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
