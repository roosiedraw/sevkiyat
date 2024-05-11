import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sevkiyat/Admin.dart';
import 'package:sevkiyat/screens/Home.dart';
import 'package:sevkiyat/screens/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/services.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController kodgirisController = TextEditingController();
  TextEditingController kodgirisController2 = TextEditingController();
  bool isLoggedIn = false;
  String name = '';
  String kod = "";
  String secilikod = "";
  String uyemail = "";
  bool uyemails = false;
  var item;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', "");

    setState(() {
      name = '';
      isLoggedIn = false;
    });
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', emailController.text);
    prefs.setString('kod', kodgirisController2.text);

    setState(() {
      kod = kodgirisController.text;
      name = emailController.text;
      isLoggedIn = true;
    });

    emailController.clear();
  }

  bool kodgiris = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/images/login.gif",
            ),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.44,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Lütfen Giriş Yapın",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 17),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.6,
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(218, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white38)),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            cursorColor: Color.fromARGB(255, 12, 34, 107),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 12, 34, 107),
                              ),
                              border: InputBorder.none,
                              hintText: "Email",
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.6,
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(218, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white38)),
                          child: TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            cursorColor: Color.fromARGB(255, 12, 34, 107),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 12, 34, 107),
                              ),
                              border: InputBorder.none,
                              hintText: "Şifreniz",
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // uyebul(emailController.text);
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Home(kod: "i"))));
                            /*isLoggedIn ? logout() : loginUser();

                            loginUser();
                            Services()
                                .signIn(emailController.text,
                                    passwordController.text)
                                .then((result) {
                              if (result == null) {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Giriş Bilgileriniz Yanlış"),
                                ));
                              } else {
                                return Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                              kod: uyemails == true ? "i" : "n",
                                            )));
                              }
                            });*/
                          },
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(190, 25, 9, 94),
                              shape: StadiumBorder(),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.6,
                                  MediaQuery.of(context).size.height * 0.07)),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Visibility(
                        visible: !kodgiris,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              kodgiris = true;
                            });
                          },
                          child: Text(
                            "Kodunuz İle Üye Olun",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: kodgiris,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white38)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  onSubmitted: (value) {},
                                  controller: kodgirisController,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 34, 107),
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Kodunuz",
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  saveRoute(kodgirisController.text);
                                });
                                kodgirisController2.text == "admin"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => Admin())))
                                    : kodgirisController.text.isEmpty
                                        ? ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content:
                                                Text("Lütfen Kodunuzu Girin"),
                                          ))
                                        : secilikod == kodgirisController.text
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        Register(
                                                            kod:
                                                                kodgirisController
                                                                    .text))))
                                            : ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Girdiğiniz Kod Hatalı"),
                                              ));
                              },
                              child: Text(
                                "Üye Ol",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(190, 25, 9, 94),
                                  shape: StadiumBorder(),
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.3,
                                      MediaQuery.of(context).size.height *
                                          0.08)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveRoute(kodgiris) async {
    FirebaseFirestore.instance
        .collection('kodlar')
        .where('kod', isEqualTo: kodgiris)
        .snapshots()
        .listen((location) {
      if (location.docs.isNotEmpty) {
        for (int i = 0; i < location.docs.length; i++) {
          setState(() {
            secilikod = location.docs[i]["kod"];
          });
        }
      }
    });
  }

  Future<void> uyebul(email) async {
    FirebaseFirestore.instance
        .collection('uyeler')
        .where('uyemail', isEqualTo: email)
        .snapshots()
        .listen((location) {
      if (location.docs.isNotEmpty) {
        uyemails = true;
        for (int i = 0; i < location.docs.length; i++) {
          setState(() {
            uyemails = location.docs[i]["uyemail"];
            print(uyemails);
          });
        }
      } else {
        uyemails = false;
      }
    });
  }
}
