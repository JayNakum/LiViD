import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserDetails extends StatelessWidget {
  final String documentId;
  final String field;
  static var userData;
  GetUserDetails(this.documentId, this.field);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          GetUserDetails.userData = data[field];
          return Text(
            data[field].toString(),
            style: Theme.of(context).textTheme.headline3,
          );
        }
        return Text("loading");
      },
    );
  }
}
