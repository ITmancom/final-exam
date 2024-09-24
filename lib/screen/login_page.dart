import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loggin_page/screen/create_page.dart';
import 'package:loggin_page/screen/main.dart';
import 'package:loggin_page/screen/forgot_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailTextLoginController = TextEditingController();
  final TextEditingController _passwordTextLoginController = TextEditingController();

  void _showCupertinoDialog(String message, BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextLoginController.text,
        password: _passwordTextLoginController.text,
      );
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const ShoeApp()),
      );
    } catch (error) {
      _showCupertinoDialog("Wrong Email or Password", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Login Page'),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(221, 255, 255, 255),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).size.height * 0.1,
          20,
          0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoTextField(
                controller: _emailTextLoginController,
                placeholder: 'Email',
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(CupertinoIcons.mail),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(198, 0, 0, 0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              const SizedBox(height: 15),
              CupertinoTextField(
                controller: _passwordTextLoginController,
                placeholder: 'Password',
                obscureText: true,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(CupertinoIcons.lock),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(199, 0, 0, 0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                onPressed: () => _login(context),
                child: const Text("Sign In"),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) =>  CreatePage()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: CupertinoColors.systemBlue),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => const ForgotPage()),
                      );
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: CupertinoColors.systemGreen),
                    ),
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
