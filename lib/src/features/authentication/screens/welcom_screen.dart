import 'package:chatboat/src/features/authentication/screens/login_screen.dart';
import 'package:chatboat/src/features/authentication/screens/signin_screen.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/852.gif"),
                  height: height * 0.5,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'AI is a Bridge  Between  Art and Science',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(
                          () => LoginScreen(
                            Function: () {},
                          ),
                        ),
                        child: Text(
                          'LogIn'.toUpperCase(),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(width: 3, color: Colors.black),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                      height: 15.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const SignInScreen()),
                        child: Text(
                          'Sign-Up'.toUpperCase(),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(width: 3, color: Colors.black),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
