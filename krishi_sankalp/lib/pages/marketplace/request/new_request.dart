import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({super.key, required this.user});
  final User? user;

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final TextEditingController _cropTypeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String errorMessage = '';

  Future<void> postRequest() async {
    if (_cropTypeController.text.isEmpty || _priceController.text.isEmpty) {
      setState(() {
        errorMessage = 'Error: Crop type or price is empty';
      });
      return;
    }
    
    FirebaseFirestore
      .instance
      .collection('users')
      .where("userEmail", isEqualTo: widget.user?.email)
      .get()
      .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          FirebaseFirestore 
            .instance
            .collection('users')
            .doc(doc.id)
            .collection('posts')
            .add({
              'cropType': _cropTypeController.text,
              'price': double.parse(_priceController.text),
              'description': _descController.text,
              'satisfied': false,
            });
        }
        Navigator.pop(context);
      },
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazaar', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 16,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cropTypeController,
              decoration: const InputDecoration(
                labelText: 'Crop Type',
              ),
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 100,),
                Expanded(
                  child: FloatingActionButton(
                    onPressed: postRequest,
                    child: const Text("Post Request"),
                  ),
                ),
                const SizedBox(width: 100,),
              ],
            ),
            const SizedBox(height: 16,),
            Text(errorMessage)
          ],
        ),
      ),
    );
  }
}