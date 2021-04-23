import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:livid/widgets/live/index.dart';

class LiveScreen extends StatefulWidget {
  static const routeName = '/live-screen';

  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  // var _isLoading = false;
  final _auth = FirebaseAuth.instance;

  void _startLive(
    String streamId,
    String streamTitle,
    String streamDescription,
    File thumbnail,
  ) async {
    try {
      // setState(() {
      //   _isLoading = true;
      // });
      final ref = FirebaseStorage.instance
          .ref()
          .child('thumbnails')
          .child(streamId + '.jpg');

      await ref.putFile(thumbnail).whenComplete(() => null);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('streams')
          .doc(_auth.currentUser.uid)
          .set({
        'channelName': streamId,
        'title': streamTitle,
        'description': streamDescription,
        'thumbnail': url,
      });
    } catch (err) {
      print(err);

      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'GO LIVE',
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0,
      ),
      body: IndexPage(
        _startLive,
        // _isLoading,
      ),
    );
  }
}
