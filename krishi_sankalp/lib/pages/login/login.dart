import 'package:cloud_firestore/cloud_firestore.dart';
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
      // setState(() {
      //   errormessage = 'success';
      // });
    } on FirebaseAuthException catch(err) {
      setState(() {
        errormessage = err.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    if(_controllerConfirmPassword.text != _controllerPassword.text) {
      setState(() {
        errormessage = 'passwords don\'t match';
      });
    } else {
      try{
        await AuthService().createUserWithEmailAndPassword(
          email: _controllerEmail.text, 
          password: _controllerPassword.text,
        );
        try {
          await FirebaseFirestore.instance
                  .collection('users')
                  .add({'userEmail': _controllerEmail.text});
        } catch(err){
          setState(() {
            errormessage = '$err';
          });
        }
        // setState(() {
        //   errormessage = 'success';
        // });
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
          backgroundColor: const Color.fromARGB(100, 0, 0, 0),
          appBar: AppBar(
            title: Text(isSignUp ? 'Sign Up' : 'Log In', style: const TextStyle(color: Colors.white),),
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _controllerEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _controllerPassword,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      obscureText: true,
                    ),
                    isSignUp ? TextField(
                      controller: _controllerConfirmPassword, 
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      obscureText: true,
                    )
                    : const Text(''),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(const Color.fromARGB(255, 21, 77, 50))),
                      onPressed: isSignUp
                          ? createUserWithEmailAndPassword
                          : signInWithEmailAndPassword,
                      child: Text(isSignUp ? 'Sign Up' : 'Log In', style: const TextStyle(color: Colors.white),),
                    ),
                    const SizedBox(height: 10),
                    Text(errormessage == '' ? '' : 'Error $errormessage', style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isSignUp = !isSignUp;
                          errormessage = '';
                        },);
                      },
                      child: Text(isSignUp
                          ? 'Already have an account? Log In'
                          : 'Don\'t have an account? Sign Up', style: const TextStyle(color: Colors.white,),),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 65,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await AuthService().signInWithGoogle();
                          setState(() {
                            errormessage = 'success';
                          });
                        },
                        icon: const Icon(Icons.g_mobiledata_rounded, size: 50),
                        label: const Text('Continue with Google', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}