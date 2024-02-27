import 'package:chatboat/chat_screen.dart';
import 'package:chatboat/src/features/authentication/screens/signin_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required Null Function()});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future singIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  bool isLoading = false;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreen()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user  found for that email ')),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Worng Password Provided for that user ')),
        );
      }
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image(
              image: AssetImage('assets/741.gif'),
              fit: BoxFit.cover,
              height: 400,
              width: width * 4,
            ),
            Text('Welcome back ,',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _emailController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Email is empty';
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: 'E-Mail',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 11, 227, 62)),
                              hintText: 'Enter Email',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 162, 249)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent,
                                      width: 10)))), //email box
                      SizedBox(
                        height: 9,
                      ),
                      TextFormField(
                        obscureText: _obscurePassword,
                        controller: _passwordController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'PAssword is empty';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 11, 227, 62)),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 162, 249)),
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
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signInWithEmailAndPassword();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen()));
                            }
                          },
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Login'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 3, 209, 113)),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('OR'),
                          SizedBox(
                            height: 13,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            },
                            child: Text.rich(
                              TextSpan(
                                  text: 'Dont Have An account? ',
                                  style: TextStyle(color: Colors.white),
                                  children: const [
                                    TextSpan(
                                        text: 'Sign In',
                                        style: TextStyle(color: Colors.blue))
                                  ]),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ]),
        ),
      )),
    );
  }
}
