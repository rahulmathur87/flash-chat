import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _saving = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 200.0,
                child: Hero(tag: 'logo', child: Image.asset('images/logo.png')),
              ),
              SizedBox(height: 48.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kTextField.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextField.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(height: 24.0),
              RoundedButton(
                buttonColor: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    _saving = true;
                  });
                  try {
                    await signIn(email, password);
                    if (!context.mounted) return;
                    Navigator.pushNamed(context, ChatScreen.id);
                    setState(() {
                      _saving = false;
                    });
                  } catch (e) {
                    debugPrint(e as String?);
                  }
                },
                buttonText: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
