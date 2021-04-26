import 'dart:io';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:livid/widgets/pickers/user_image_picker.dart';
import 'package:livid/widgets/live/call.dart';

class IndexPage extends StatefulWidget {
  final void Function(
    String streamId,
    String streamTitle,
    String streamDescription,
    File thumbnail,
  ) sessionStart;
  // final bool _isLoading;
  IndexPage(
    this.sessionStart,
    // this._isLoading,
  );
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  final _formKey = GlobalKey<FormState>();
  final _userId = FirebaseAuth.instance.currentUser.uid;
  var _streamTitle = '';
  var _streamDescription = '';
  File _userImageFile;
  // https://firebasestorage.googleapis.com/v0/b/livid-jay.appspot.com/o/App%20Logo.jpeg?alt=media&token=1d0269fe-7c1c-4c9a-89e7-26c56b04fbfc

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    if (_userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick a thumbnail'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (_isValid) {
      _formKey.currentState.save();
      widget.sessionStart(
        _userId.trim(),
        _streamTitle.trim(),
        _streamDescription.trim(),
        _userImageFile,
      );
      onJoin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      filled: true,
                      fillColor: Theme.of(context).primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _streamTitle = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Description',
                      filled: true,
                      fillColor: Theme.of(context).primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onSaved: (value) {
                      _streamDescription = value;
                    },
                  ),
                  SizedBox(height: 20),
                  UserImagePicker(_pickedImage),
                  SizedBox(height: 20),
                  OutlinedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                    onPressed: _trySubmit,
                    child: Container(
                      child: Text(
                        'GO LIVE',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Lequire',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.play_arrow_rounded,
            //     color: Colors.black26,
            //   ),
            //   onPressed: onJoin,
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: _userId,
          role: ClientRole.Broadcaster,
          streamTitle: _streamTitle,
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
