import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tastytrade/routes/auth/sign_up.dart';
import 'package:tastytrade/widgets/bottom_navigator.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });
    if (email.isNotEmpty && password.isNotEmpty) {
      print(email);
      print(password);

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (credential.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavigator()),
          );
          setState(() {
            isLoading = false;
          });
        }
        print(credential.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD2B3),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   child: Lottie.asset('assets/food.json', repeat: false),
                // ),
                const Text('TastyTrade',
                    style:
                        TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                const Text('Welcome back, you\'ve been missed!',
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[50],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      cursorColor: Colors.black,
                      onChanged: (value) => email = value,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[50],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      cursorColor: Colors.black,
                      onChanged: (value) => password = value,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: login,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color(0xFFFF8737),
                    ),
                    child: Center(
                      child: isLoading
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                  strokeWidth: 3, color: Colors.white),
                            )
                          : const Text('Sign in',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: const Text('Sign up',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
