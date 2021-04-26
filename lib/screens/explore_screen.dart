import 'package:flutter/material.dart';
import 'package:livid/widgets/app/floating_buttons.dart';
import 'package:livid/widgets/explore/rank.dart';
import 'package:livid/widgets/explore/search.dart';

class ExploreScreen extends StatefulWidget {
  static const routeName = '/explore-screen';

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _search;

  void search(String userName) {
    setState(() {
      _search = userName;
    });
    print(_search);
  }

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
      body: Column(
        children: <Widget>[
          Search(search),
          SizedBox(height: 20),
          Expanded(
            child: Rank(
              field: _search,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingButtons(2),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
