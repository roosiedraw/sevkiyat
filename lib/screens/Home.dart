import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sevkiyat/bottomNavPages/AnasayfaNakliye.dart';
import 'package:sevkiyat/bottomNavPages/Araclar.dart';
import 'package:sevkiyat/bottomNavPages/Ilanver.dart';
import 'package:sevkiyat/bottomNavPages/Isler.dart';
import 'package:sevkiyat/bottomNavPages/IstasyonTalep.dart';
import 'package:sevkiyat/bottomNavPages/NakliyeTalep.dart';
import 'package:sevkiyat/bottomNavPages/Sevkiyat%C4%B1m.dart';
import 'package:sevkiyat/screens/LoginScreen.dart';
import 'package:sevkiyat/screens/drawerScreens/Bildirim.dart';
import 'package:sevkiyat/screens/drawerScreens/Kampanya.dart';
import 'package:sevkiyat/screens/drawerScreens/Oneri.dart';
import 'package:sevkiyat/screens/drawerScreens/Profile.dart';
import 'package:sevkiyat/screens/drawerScreens/Seferlerim.dart';
import 'package:sevkiyat/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottomNavPages/Anasayfaistasyon.dart';
import 'detay/kvkk.dart';
import 'drawerScreens/Nakliyem.dart';

class Home extends StatefulWidget {
  String kod = "";

  Home({required this.kod});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool naknak = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.kod.characters.first == "i" ? naknak = true : naknak = false;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoggedIn = false;
  String name = '';

  int _index = 1;
  List<Widget> PagesIstasyon = [
    IstasyonTalep(),
    AnasayfaIstasyon(),
    Sevkiyatim()
  ];
  List<Widget> PagesNakliye = [NakliyeTalep(), AnasayfaNakliye(), Isler()];
  List<String> IstasyonAdlar = [
    "İstasyon Talep",
    "İstasyon Anasayfa",
    "Sevkiyatım"
  ];
  List<String> NakliyeAdlar = ["Nakliye Talep", "Nakliye Anasayfa", "İşlerim"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      key: _scaffoldKey,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            }),
        title: Text(
          "${widget.kod == "i" ? IstasyonAdlar[_index] : NakliyeAdlar[_index]} ${widget.kod}",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              radius: 2.8,
              stops: [
                0.0,
                0.57,
                50,
              ],
              colors: [
                Color.fromARGB(255, 150, 206, 223),
                Color.fromARGB(255, 18, 91, 150),
                Color.fromARGB(255, 4, 19, 32),
              ],
            ),
          ),
        ),
      ),
      drawer: new Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
        width: MediaQuery.of(context).size.width * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Profile(
                                      kod: widget.kod,
                                    ))));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Color.fromARGB(237, 25, 9, 94),
                              size: 30,
                            ),
                            Text(
                              "  Profilim     ",
                              style: TextStyle(
                                  color: Color.fromARGB(237, 25, 9, 94),
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Bildirim())));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Color.fromARGB(237, 25, 9, 94),
                              size: 30,
                            ),
                            Text(
                              "  Bildirim      ",
                              style: TextStyle(
                                  color: Color.fromARGB(237, 25, 9, 94),
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Oneri())));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.align_vertical_bottom,
                              color: Color.fromARGB(237, 25, 9, 94),
                              size: 30,
                            ),
                            Text(
                              "  Öneriler      ",
                              style: TextStyle(
                                  color: Color.fromARGB(237, 25, 9, 94),
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Kampanya())));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.campaign,
                              color: Color.fromARGB(237, 25, 9, 94),
                              size: 30,
                            ),
                            Text(
                              "   Kampanya",
                              style: TextStyle(
                                  color: Color.fromARGB(237, 25, 9, 94),
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Visibility(
                          visible: naknak,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Nakliyem())));
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.oil_barrel,
                                    color: Color.fromARGB(237, 25, 9, 94),
                                    size: 30,
                                  ),
                                  Text(
                                    "   Nakliyem   ",
                                    style: TextStyle(
                                        color: Color.fromARGB(237, 25, 9, 94),
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !naknak,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Seferlerim())));
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.fire_truck,
                                    color: Color.fromARGB(237, 25, 9, 94),
                                    size: 30,
                                  ),
                                  Text(
                                    "   Seferlerim",
                                    style: TextStyle(
                                        color: Color.fromARGB(237, 25, 9, 94),
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Kvkk())));
                      },
                      child: Text(
                        "Sözleşme Metni       ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 90, 147, 247),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Kvkk())));
                      },
                      child: Text(
                        "KVKK Metni       ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 90, 147, 247),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      logout();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: ((context) => Login())),
                          (route) => false);
                    },
                    child: Text(
                      "Çıkış Yap",
                      style: TextStyle(
                          color: Color.fromARGB(237, 25, 9, 94),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: Color.fromARGB(237, 25, 9, 94),
                                width: 2)),
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.3,
                            MediaQuery.of(context).size.height * 0.07)),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: widget.kod == "i" ? PagesIstasyon[_index] : PagesNakliye[_index],
      bottomNavigationBar: Container(
        height: 77,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: RadialGradient(
            radius: 3.4,
            stops: [
              0.0,
              0.57,
              50,
            ],
            colors: [
              Color.fromARGB(255, 150, 206, 223),
              Color.fromARGB(255, 18, 91, 150),
              Color.fromARGB(255, 4, 19, 32),
            ],
          ),
        ),
        child: FloatingNavbar(
          backgroundColor: Colors.transparent,
          onTap: (int val) {
            setState(() {
              _index = val;
            });
            //returns tab id which is user tapped
          },
          currentIndex: _index,
          items: [
            FloatingNavbarItem(icon: Icons.list_alt, title: 'Taleplerim'),
            FloatingNavbarItem(icon: Icons.home, title: 'Anasayfa'),
            FloatingNavbarItem(icon: Icons.punch_clock, title: 'Sevkiyatım')
          ],
        ),
      ),
    );
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', "");
    prefs.setString('kod', "b");

    setState(() {
      name = '';
      isLoggedIn = false;
    });
  }
}
