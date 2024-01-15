import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sankalp/api/auth.dart';
import 'package:krishi_sankalp/pages/export.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = AuthService().currentUser;

  Future<void> signOut() async{
    await AuthService().signOut();
  }

  Future<void> updateProfile(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(user: user)));

    if(result != null) {
      setState(() {
        user = result['user'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect Disease', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      drawer: NavigationSidebar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              const SizedBox(height: 16),
              Text(
                (user?.displayName == '' ? 'UserName' : user?.displayName)!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? 'user email',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => {
                  updateProfile(context),},
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: signOut,
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      )
    );
  }
}