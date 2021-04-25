import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
// import 'package:livid/screens/auth_screen.dart';
import 'package:livid/widgets/app/floating_buttons.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
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
                  FirebaseAuth.instance.signOut();
                  SystemNavigator.pop();
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //   AuthScreen.routeName,
                  //   ModalRoute.withName('/'),
                  // );
                }
              },
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
      floatingActionButton: FloatingButtons(3),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
