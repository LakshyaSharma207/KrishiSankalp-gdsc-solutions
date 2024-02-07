import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sankalp/api/auth.dart';

class Marketplace extends StatelessWidget {
  Marketplace({super.key});
  final User? user = AuthService().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazaar', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where("userEmail", isNotEqualTo: user?.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot bazaarDocument = snapshot.data!.docs[index];
                      return StreamBuilder<QuerySnapshot>(
                        stream: bazaarDocument.reference.collection('posts').snapshots(),
                        builder: (context, postSnapshot) {
                          if(postSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (postSnapshot.hasError) {
                            return Center(child: Text("Error: ${postSnapshot.error}"));
                          } else if (!postSnapshot.hasData || postSnapshot.data!.docs.isEmpty) {
                            return const Center(child: Text("No data available"));
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: postSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final docref = postSnapshot.data!.docs[index];
                                final postData = docref.data() as Map<String, dynamic>;

                                return InkWell(
                                  onTap: () {
                                    print("Card Tapped");
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: const Icon(Icons.local_florist_outlined),
                                      title: Text(postData['cropType']),
                                      subtitle: Text(postData['message']),
                                      trailing: Text('\$${index + 1}0'),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Post a Request', style: TextStyle(fontSize: 16),),
              ),
            ),
          ),
        ]
      )
    );
  }
}