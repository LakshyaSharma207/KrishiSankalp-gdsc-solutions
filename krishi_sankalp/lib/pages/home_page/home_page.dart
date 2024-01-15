import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sankalp/api/auth.dart';
import 'package:krishi_sankalp/pages/export.dart';

class HomePage extends StatelessWidget {
  HomePage({ super.key,});
  final User? user = AuthService().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      drawer: NavigationSidebar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CropDisease(user: user),
        ),
      )
    );
  }
}