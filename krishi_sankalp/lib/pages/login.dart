import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errormessage = '';
  bool isSignUp = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try{
      await AuthService().signInWithEmailAndPassword(
        email: _controllerEmail.text, 
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch(err) {
      setState(() {
        errormessage = err.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    try{
      await AuthService().createUserWithEmailAndPassword(
        email: _controllerEmail.text, 
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch(err) {
      setState(() {
        errormessage = err.message;
      });
    }
  }

  Widget errorMessage() {
    return Text(errormessage == '' ? '' : 'Error $errormessage');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(),
        ],
      ),
    );
  }
}