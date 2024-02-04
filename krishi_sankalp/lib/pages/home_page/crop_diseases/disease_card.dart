import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseCard extends StatelessWidget {
  const DiseaseCard({super.key, required this.data, required this.user, required this.docId});
  final Map<String, dynamic> data;
  final User? user;
  final String docId;

  Future<void> markAsTreated() async {
    var userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: user?.email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      var userDocument = userQuery.docs.first;
      await userDocument.reference
          .collection('cropDiseases')
          .doc(docId)
          .update({'hasTreated': true});
    } else {
      print('User not found with email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return !data['hasTreated'] ? Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data['cropName'] ?? 'No Crop',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  data['disease'] ?? 'No disease',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              data['treatment'] != null ? '${data['treatment']}' : 'Information not available',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8,),
            ElevatedButton(
              onPressed: markAsTreated, 
              child: const Text('Mark as Treated'),
            ),
          ],
        ),
      ),
    ) : Container();
  }
}