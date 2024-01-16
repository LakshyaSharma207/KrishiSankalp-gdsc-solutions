import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.user});
  final User? user;
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String errorMessage = '';

  void _updateProfile() {
    if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
      setState(() {
        errorMessage = 'Username or Email required for updation';
      });
      return;
    }
    if(_nameController.text != '') {
      widget.user?.updateDisplayName(_nameController.text);
    }
    if(_emailController.text != '') {
      widget.user?.updateEmail(_emailController.text);
    }
    Navigator.pop(context, {'success': true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'New User Name'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'New Email'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 16),
              Text(errorMessage, style: const TextStyle(color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}