import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:livid/screens/auth_screen.dart';
import 'package:livid/screens/explore_screen.dart';
import 'package:livid/screens/home_screen.dart';
import 'package:livid/screens/live_screen.dart';
import 'package:livid/screens/profile_screen.dart';

void main() {
  runApp(LiViD());
}

class LiViD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const MaterialColor myPrimaryColor = MaterialColor(
      0xFF1A1A1A,
      <int, Color>{
        50: Color(0xFF333333),
        100: Color(0xFF333333),
        200: Color(0xFF2d2d2d),
        300: Color(0xFF2d2d2d),
        400: Color(0xFF272727),
        500: Color(0xFF272727),
        600: Color(0xFF1f1f1f),
        700: Color(0xFF1f1f1f),
        800: Color(0xFF1a1a1a),
        900: Color(0xFF1a1a1a),
      },
    );
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went Wrong :('));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return MaterialApp(
          title: 'LiViD',
          theme: ThemeData(
            primarySwatch: myPrimaryColor,
            primaryColor: Colors.amber,
            accentColor: Colors.orange,
            canvasColor: myPrimaryColor,
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 28,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lequire',
              ),
              headline3: TextStyle(
                fontSize: 28,
                color: Colors.amber,
                // fontWeight: FontWeight.bold,
                fontFamily: 'Odin',
              ),
              headline2: TextStyle(
                fontFamily: 'Lequire',
                fontSize: 24,
                color: Colors.orange,
              ),
              bodyText1: TextStyle(
                fontFamily: 'Odin',
                fontSize: 20,
                color: Colors.amber,
                backgroundColor: Colors.black26,
              ),
              bodyText2: TextStyle(
                fontFamily: 'Odin',
                fontSize: 18,
                color: Colors.amber,
                backgroundColor: Colors.black26,
              ),
            ),
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return HomeScreen();
              }
              return AuthScreen();
            },
          ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            LiveScreen.routeName: (ctx) => LiveScreen(),
            ExploreScreen.routeName: (ctx) => ExploreScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
          },
        );
      },
    );
  }
}
