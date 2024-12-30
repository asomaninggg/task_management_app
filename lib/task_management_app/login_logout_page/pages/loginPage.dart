import 'package:beginner/components/square_tile.dart';
import 'package:flutter/material.dart';
import '../../../components/textfield.dart';
import '../../../components/signInbutton.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              //logo
              Icon(
                Icons.lock,
                color: Color(0xffada3a3),
                size: 100,
              ),
              SizedBox(height: 50),

              Text(
                'Welcome back, you\'ve been missed!',
                style: TextStyle(color: Color(0xff5f5e5e), fontSize: 17),
              ),
              SizedBox(height: 20),

              myTextfield(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              myTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xff5f5e5e),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.5),
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.2,
                        color: Color(0xfff6efef),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Color(0xff5f5e5e),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.2,
                        color: Color(0xfff6efef),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'images/google logo.png'),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      color: Color(0xff5f5e5e),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Register Now',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
