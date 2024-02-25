import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sankalp/api/auth.dart';
import 'package:krishi_sankalp/pages/export.dart';

class Marketplace extends StatelessWidget {
  Marketplace({super.key});
  final User? user = AuthService().currentUser;

  @override
  Widget build(BuildContext context) {
    final surfaceVariantColor = Theme.of(context).colorScheme.surfaceVariant;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazaar', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      drawer: const NavigationSidebar(),
      body: Column(
        children: [
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your Request: '),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.greenAccent, 
                  border: Border.all(color: Colors.black, width: 1,),
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                ),
              ),
              const SizedBox(width: 50,),
              const Text('Others: '),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: surfaceVariantColor, 
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
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
                      final isCurrentUser = bazaarDocument['userEmail'] == user?.email;

                      return StreamBuilder<QuerySnapshot>(
                        stream: bazaarDocument.reference.collection('posts').snapshots(),
                        builder: (context, postSnapshot) {
                          if(postSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (postSnapshot.hasError) {
                            return Center(child: Text("Error: ${postSnapshot.error}"));
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: postSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final docref = postSnapshot.data!.docs[index];
                                final postData = docref.data() as Map<String, dynamic>;

                                if (postData['satisfied'] == false) {
                                  return InkWell(
                                    onTap: () => {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: isCurrentUser ? Colors.greenAccent : null,
                                        child: ListTile(
                                          leading: const Icon(Icons.local_florist_outlined),
                                          title: Text(postData['cropType']),
                                          subtitle: Text(postData['description']),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              isCurrentUser ? const Icon(Icons.delete, color: Colors.red) : const Text(''),
                                              const SizedBox(width: 10,),
                                              Text('₹${postData['price']} / kg'), 
                                            ],
                                          )
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return null;
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewRequest(user: user)));
              },
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