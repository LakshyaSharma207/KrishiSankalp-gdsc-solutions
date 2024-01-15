import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sankalp/pages/home_page/crop_diseases/disease_card.dart';

class CropDisease extends StatelessWidget {
  const CropDisease({ super.key, required this.user, });
  final User? user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore
              .instance
              .collection('users')
              .where('userEmail', isEqualTo: user?.email)
              .snapshots(), 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        else if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No data available.');
        }
        else {
          DocumentSnapshot userDocument = snapshot.data!.docs.first;
    
          return StreamBuilder<QuerySnapshot>(
            stream: userDocument.reference.collection('cropDiseases').snapshots(), 
            builder: (context, diseasesnapshot) {
              if (diseasesnapshot.hasError) {
                return Text('Error: ${diseasesnapshot.error}');
              }
              else if(!diseasesnapshot.hasData || diseasesnapshot.data!.docs.isEmpty) {
                return const Text('No data available.');
              }
              else{
                return ListView.builder(
                  itemCount: diseasesnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final docRef = diseasesnapshot.data!.docs[index];
                    final cropData = docRef.data() as Map<String, dynamic>;
                    final docId = docRef.id;
                    return DiseaseCard(data: cropData, user: user, docId: docId);
                  },
                );
              }
            }
          );
        }
      }
    );
  }
}
