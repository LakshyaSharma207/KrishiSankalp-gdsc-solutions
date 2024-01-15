import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../api/auth.dart';

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
      setState(() {
        errormessage = 'success';
      });
    } on FirebaseAuthException catch(err) {
      setState(() {
        errormessage = err.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    if(_controllerConfirmPassword != _controllerPassword) {
      setState(() {
        errormessage = 'passwords don\'t match';
      });
    } else {
      try{
        await AuthService().createUserWithEmailAndPassword(
          email: _controllerEmail.text, 
          password: _controllerPassword.text,
        );
        setState(() {
          errormessage = 'success';
        });
      } on FirebaseAuthException catch(err) {
        setState(() {
          errormessage = err.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset('assets/homeBg.png', 
          height: MediaQuery.of(context).size.height, 
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(isSignUp ? 'Sign Up' : 'Log In'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _controllerEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controllerPassword,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                isSignUp ? TextField(
                  controller: _controllerConfirmPassword, 
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                )
                : const Text(''),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isSignUp
                      ? createUserWithEmailAndPassword
                      : signInWithEmailAndPassword,
                  child: Text(isSignUp ? 'Sign Up' : 'Log In'),
                ),
                const SizedBox(height: 16),
                Text(errormessage == '' ? 'no error' : 'Error $errormessage'),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignUp = !isSignUp;
                      errormessage = '';
                    });
                  },
                  child: Text(isSignUp
                      ? 'Already have an account? Log In'
                      : 'Don\'t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}