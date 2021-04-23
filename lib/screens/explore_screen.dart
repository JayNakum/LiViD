import 'package:flutter/material.dart';
import 'package:livid/widgets/app/floating_buttons.dart';

class ExploreScreen extends StatelessWidget {
  static const routeName = '/explore-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'EXPLORE',
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0,
      ),
      body: Center(
        child: Text('Explore Screen'),
      ),
      floatingActionButton: FloatingButtons(2),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
