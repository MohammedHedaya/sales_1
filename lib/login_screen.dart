import 'package:flutter/material.dart';
import 'package:sales_1/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login',),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/login.jpg'),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 300,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.pink,
              ),
              child: MaterialButton(
                splashColor: Colors.white,
                onPressed: () {
                  AuthService().signInWithGoogle();
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Google تسجيل الدخول عبر حساب ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Image.asset(
                        'assets/google.png',
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
