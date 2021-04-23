import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:livid/widgets/app/call.dart';

class CurrentLiveSessions extends StatelessWidget {
  // final isFollowing;
  // CurrentLiveSessions({this.isFollowing = true});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('streams')
          .orderBy('title')
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final sessions = snapshot.data.docs;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: MediaQuery.of(context).size.height * 0.75,
          child: sessions.length == 0
              ? Center(child: Text('No one is Live :('))
              : PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sessions.length,
                  itemBuilder: (ctx, i) => Session(
                    sessionId: sessions[i].data()['channelName'],
                    title: sessions[i].data()['title'],
                    description: sessions[i].data()['description'],
                    thumbnailUrl: sessions[i].data()['thumbnail'],
                  ),
                ),
        );
      },
    );
  }
}

class Session extends StatefulWidget {
  final String sessionId;
  final String title;
  final String description;
  final String thumbnailUrl;
  Session({
    @required this.sessionId,
    @required this.title,
    @required this.description,
    @required this.thumbnailUrl,
  });
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onJoin,
      child: Container(
        // color: Colors.amber,
        width: MediaQuery.of(context).size.width,
        // margin: const EdgeInsets.only(top: 5.0),
        child: Stack(
          children: <Widget>[
            Image.network(
              widget.thumbnailUrl,
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
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
          channelName: widget.sessionId,
          role: ClientRole.Audience,
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
