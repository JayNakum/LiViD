import 'package:flutter/material.dart';
import 'package:livid/screens/explore_screen.dart';
import 'package:livid/screens/home_screen.dart';
import 'package:livid/screens/live_screen.dart';
import 'package:livid/screens/profile_screen.dart';

class FloatingButtons extends StatelessWidget {
  final int _index;
  // 0 - HomeScreen
  // 1 - LiveScreen
  // 2 - ExploreScreen
  // 3 - ProfileScreen
  FloatingButtons(this._index);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        if (_index == 2 || _index == 3)
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              heroTag: 'button1',
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.home_rounded),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
            ),
          ),
        if (_index == 0)
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              heroTag: 'button2',
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.explore_rounded),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(ExploreScreen.routeName);
              },
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            width: 80,
            child: FloatingActionButton(
              heroTag: 'button3',
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.play_arrow_rounded,
                size: 69,
                // color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(LiveScreen.routeName);
              },
            ),
          ),
        ),
        if (_index == 0 || _index == 2)
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: 'button4',
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.person_rounded),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProfileScreen.routeName);
              },
            ),
          ),
        if (_index == 3)
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              heroTag: 'button5',
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.explore_rounded),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(ExploreScreen.routeName);
              },
            ),
          ),
      ],
    );
  }
}
