import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/widgets/bottom_navigator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? image;
  String name = '';
  String email = '';
  String password = '';
  bool isLoading = false;

  final storageRef = FirebaseStorage.instance.ref();

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    if (email.isNotEmpty && password.isNotEmpty) {
      // print(email);
      // print(password);

      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (credential.user != null) {
          final profileRef = storageRef.child(image!.path);
          credential.user!.updateDisplayName(name);
          credential.user!.updatePhotoURL(await profileRef.putFile(image!).then(
              (value) => value.ref.getDownloadURL()));
          await context.read<GetRecipes>().getAllRecipes();
          context.read<GetRecipes>().getRecipesByLiked(credential.user!.uid);
          context.read<GetRecipes>().getRecipesByUser(credential.user!.uid);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigator()),
          );
          setState(() {
            isLoading = false;
          });
        }
        // print(credential.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // print('Wrong password provided for that user.');
        }
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future pickImage(String source) async {
    try {
      final image = await ImagePicker().pickImage(
          source:
              source == 'camera' ? ImageSource.camera : ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future showOptions() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                pickImage('camera');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () {
                pickImage('gallery');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
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
                const Text('TastyTrade',
                    style:
                        TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                const Text('Register below with your details!',
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 16),
                MaterialButton(
                  onPressed: () {
                    showOptions();
                  },
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: image != null ? FileImage(image!) : null,
                      backgroundColor: Colors.grey[300],
                      child: image == null
                          ? const Icon(Icons.add_a_photo, color: Colors.white)
                          : null),
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
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      cursorColor: Colors.black,
                      onChanged: (value) => name = value,
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
                  onTap: signUp,
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
                          : const Text('Sign up',
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
                    const Text('Already have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Sign in',
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
