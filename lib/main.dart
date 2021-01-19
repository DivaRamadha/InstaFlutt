import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instaflutt/db/authAPi.dart';
import 'package:instaflutt/db/sharedPref.dart';
import 'package:instaflutt/pages/auth/login.dart';
import 'package:instaflutt/pages/root_app.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPref pref = new SharedPref();
  Future<void> initPlatformState(BuildContext context) async {
    String uid = await pref.read('uid');
    print('.....................');
    print(uid);
    if (!mounted) return;

    print('aaaaa');

    if (uid != null ) {
      AuthApi().getUser(userFid: uid, context: context, a: 1).then((value) =>
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
              ModalRoute.withName('\homePage')));
    } else {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          settings: const RouteSettings(name: '/masuk'),
          builder: (context) => new LoginScreen()));
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  navigationPage() {
    return initPlatformState(context);
    // return null;
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "Instagram",
              style: TextStyle(
                  fontFamily: 'Billabong',
                  fontSize: 50,
                  color: textFieldBackground),
            ),
          )),
    );
  }
}
