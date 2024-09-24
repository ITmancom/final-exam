import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loggin_page/screen/create_page.dart';
import 'package:loggin_page/screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController _emailTextController = TextEditingController();

  void _showCupertinoDialog(String message) {
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

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailTextController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => LoginPage()),
      );
    } catch (error) {
      _showCupertinoDialog("Error: ${error.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Forgot Password'),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 234, 248, 231), Color.fromARGB(255, 255, 255, 255)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoTextField(
                controller: _emailTextController,
                placeholder: 'Enter your Email',
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(CupertinoIcons.mail),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                onPressed: _resetPassword,
                child: const Text("Get New Password"),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: CupertinoColors.systemBlue),
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
