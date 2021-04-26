import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:livid/widgets/app/floating_buttons.dart';
import 'package:livid/widgets/profile/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'MY PROFILE',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              elevation: 0,
              icon: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).accentColor,
              ),
              items: [
                DropdownMenuItem(
                  value: 'Logout',
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app_rounded,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'Logout') {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      titleTextStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                      ),
                      backgroundColor: Colors.black54,
                      contentTextStyle: TextStyle(color: Colors.white),
                      elevation: 3,
                      title: Text('Are you sure?'),
                      content: Text('Do you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'No',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          onPressed: () {
                            _auth.signOut();
                            SystemNavigator.pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: UserProfile(documentId: _auth.currentUser.uid),
      ),
      floatingActionButton: FloatingButtons(3),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
