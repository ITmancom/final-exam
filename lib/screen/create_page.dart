import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loggin_page/screen/login_page.dart';

class CreatePage extends StatelessWidget {
CreatePage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Create Account'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoTextField(
                placeholder: 'Email',
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                placeholder: 'Password',
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: const Text('Create Account'),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => LoginPage()), // Corrected here
                    );
                  } catch (e) {
                    print('Error: $e');
                  }
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => LoginPage()), // Corrected here
                  );
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
