import 'package:flutter/material.dart';
import 'package:krishi_sankalp/pages/export.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: NavigationSidebar(), 
      body: Center(
        child: Column(
          children: [
            const Text('Flutter is '),
            const SizedBox(height: 10,),
            Image.asset('assets/2Gb.gif'),
          ],
        ),
      ),
    );
  }
}