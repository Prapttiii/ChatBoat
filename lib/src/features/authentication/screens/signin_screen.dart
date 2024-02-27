import 'package:chatboat/chat_screen.dart';
import 'package:chatboat/src/features/authentication/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<void> signUp() async {
    if (passwordConfirmed()) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Create user
    }
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmpasswordController.text.trim();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/963.gif',
                fit: BoxFit.cover,
                height: 300,
                width: width * 4,
              ),
              Text(
                'Get On Board!!',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            validator: _validateField,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 11, 227, 62),
                              ),
                              hintText: 'Enter Name',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 162, 249),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: BorderSide(
                                  color: Colors.lightGreenAccent,
                                  width: 10,
                                ),
                              ),
                            ),
                          ), // Name box

                          SizedBox(height: 7),

                          TextFormField(
                            controller: _emailController,
                            validator: _validateField,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'E-Mail',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 11, 227, 62),
                              ),
                              hintText: 'Enter Email',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 162, 249),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: BorderSide(
                                  color: Colors.lightGreenAccent,
                                  width: 10,
                                ),
                              ),
                            ),
                          ), // Email box

                          SizedBox(height: 7),

                          TextFormField(
                            controller: _phoneController,
                            validator: _validateField,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              labelText: 'Phone No',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 11, 227, 62),
                              ),
                              hintText: 'Enter Phone No',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 162, 249),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: BorderSide(
                                  color: Colors.lightGreenAccent,
                                  width: 10,
                                ),
                              ),
                            ),
                          ), // Phone box

                          SizedBox(height: 7),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            validator: _validateField,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.fingerprint),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 11, 227, 62),
                              ),
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 162, 249),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ), // Password box

                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('validation is done');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(),
                                    ),
                                  );
                                }
                              },
                              child: Text('Sign in'.toUpperCase()),
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('OR'),
                              SizedBox(height: 8),
                              SizedBox(height: 8),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                        Function: () {},
                                      ),
                                    ),
                                  );
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Already Have An account? ',
                                    style: TextStyle(color: Colors.white),
                                    children: const [
                                      TextSpan(
                                        text: 'Log In',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
