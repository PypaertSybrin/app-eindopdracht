import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/routes/auth/sign_up.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/utils/permission_handler.dart';
import 'package:tastytrade/widgets/bottom_navigator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = 'sybrin.pypaert@student.howest.be';
  String password = 'Sybrin1234';
  bool isLoading = false;
  bool error = false;

  void login() {
    setState(() {
      isLoading = true;
    });
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((credential) {
          if (credential.user != null) {
            context.read<GetRecipes>().getAllRecipes().then((_) {
              context.read<GetRecipes>().updateRecipesByLiked(credential.user!.uid);
              context.read<GetRecipes>().updateRecipesByUser(credential.user!.uid);
              context.read<GetRecipes>().updateShoppingListsPerUser(credential.user!.uid);
              PermissionHandler().requestNotificationPermission();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavigator()),
              );
            });
          } else {
            setState(() {
              error = true;
              isLoading = false;
            });
          }
        }).catchError((e) {
          setState(() {
            error = true;
            isLoading = false;
          });
          if (e is FirebaseAuthException) {
            if (e.code == 'user-not-found') {
              // Handle user not found
            } else if (e.code == 'wrong-password') {
              // Handle wrong password
            }
          }
        });
      } catch (e) {
        setState(() {
          error = true;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        error = true;
        isLoading = false;
      });
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
                const Icon(Icons.food_bank,
                    size: 100, color: Color(0xFFFF8737)),
                const Text('TastyTrade',
                    style:
                        TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                const Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
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
                        errorText: error ? 'Incorrect email or password' : null,
                        errorStyle: const TextStyle(color: Colors.red),
                        labelText: 'Email',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                        errorText: error ? 'Incorrect email or password' : null,
                        errorStyle: const TextStyle(color: Colors.red),
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
                                  strokeWidth: 3, color: Colors.black),
                            )
                          : const Text('Sign in',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
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
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
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
