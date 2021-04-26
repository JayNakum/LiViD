import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:livid/models/cur_user.dart';
import 'package:livid/widgets/pickers/user_image_picker.dart';

class UserProfile extends StatefulWidget {
  final String documentId;
  final bool isMine;

  UserProfile({
    @required this.documentId,
    this.isMine = true,
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  File _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _updatePhoto() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('profilePhoto')
        .child(widget.documentId + '.jpg');

    await ref.putFile(_userImageFile).whenComplete(() => null);
    final url = await ref.getDownloadURL();
    users.doc(widget.documentId).update({'photo': url});
    Navigator.of(context).pop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users.doc(widget.documentId).get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          CurUser(
            name: data['name'],
            streamCount: data['streams'],
            lCoins: data['lcoins'],
            photoUrl: data['photo'],
          );
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        data['photo'],
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    data['name'],
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                if (widget.isMine)
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_a_photo_rounded,
                                      color: Colors.deepOrangeAccent,
                                    ),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          titleTextStyle: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 20,
                                          ),
                                          backgroundColor: Colors.black54,
                                          contentTextStyle:
                                              TextStyle(color: Colors.white),
                                          elevation: 3,
                                          title: Text(
                                            'Update Image',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          content:
                                              UserImagePicker(_pickedImage),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                'Set',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              onPressed: _updatePhoto,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 25.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.play_circle_fill_rounded,
                            size: 28,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(
                            data['streams'].toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Center(
                        child: ListTile(
                          title: Text(
                            data['lcoins'].toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          leading: const Text(
                            'LCoins',
                            style: TextStyle(
                              fontFamily: 'Odin',
                              fontSize: 20,
                              color: Colors.orange,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
