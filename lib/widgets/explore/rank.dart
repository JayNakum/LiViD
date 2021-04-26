import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rank extends StatefulWidget {
  final String field;
  Rank({@required this.field});
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.field == null
          ? _users
              .orderBy(
                'streams',
                descending: true,
              )
              .get()
          : _users
              .where(
                'name',
                isEqualTo: widget.field,
              )
              .orderBy(
                'streams',
                descending: true,
              )
              .get(),
      builder: (ctx, snapshot) {
        if (snapshot.data == null)
          return Center(child: CircularProgressIndicator());
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final users = snapshot.data.docs;

        return ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, i) {
              return ListTile(
                tileColor: Colors.black26,
                leading: Container(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    users[i].data()['photo'],
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  users[i].data()['name'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Text(
                  users[i].data()['streams'].toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              );
            });
      },
    );
  }
}
