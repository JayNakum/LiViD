import 'package:flutter/material.dart';
import 'package:livid/widgets/app/floating_buttons.dart';
import 'package:livid/widgets/home/current_live_sessions.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'LiViD',
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: CurrentLiveSessions()),
        // SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: <Widget>[
        //       CurrentLiveSessions(),
        //       SizedBox(height: 30),
        //       CurrentLiveSessions(),
        //     ],
        //   ),
        // ),
      ),
      floatingActionButton: FloatingButtons(0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
