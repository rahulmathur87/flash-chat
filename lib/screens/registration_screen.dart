import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              buttonColor: Colors.blueAccent,
              onPressed: () async {
                debugPrint(email);
                debugPrint(password);
                try {
                  await signUp(email, password);
                  if (!context.mounted) return;
                  Navigator.pushNamed(context, ChatScreen.id);
                } catch (e) {
                  debugPrint(e as String?);
                }
              },
              buttonText: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
