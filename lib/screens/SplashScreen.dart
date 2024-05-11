import 'package:flutter/material.dart';

import 'package:sevkiyat/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  String name = '';
  String kod = "";
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      autoLogIn();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    final String? kods = prefs.getString('kod');
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
        kod = kods!;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: ((context) => Home(
                      kod: kod,
                    ))),
            (route) => false);
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 34, 107),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "assets/images/login.gif",
          ),
          fit: BoxFit.cover,
        )),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
