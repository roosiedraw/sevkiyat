import 'dart:io' as file;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sevkiyat/services/services.dart';

class Profile extends StatefulWidget {
  String kod = "";
  Profile({required this.kod});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController yetkiliadsoyadController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  bool duzenle = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "PROFİL",
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
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection(widget.kod.characters.first == "i"
                    ? "usersistasyon"
                    : "usersnakliye")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(216, 38, 93, 145),
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Visibility(
                              visible: duzenle,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 12, 34, 107))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextField(
                                        controller: yetkiliadsoyadController,
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        cursorColor:
                                            Color.fromARGB(255, 12, 34, 107),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 74, 86, 124),
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Yetkili Ad Soyad",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 12, 34, 107))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextField(
                                        controller: emailController,
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        cursorColor:
                                            Color.fromARGB(255, 12, 34, 107),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 74, 86, 124),
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Email",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 12, 34, 107))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextField(
                                        controller: adresController,
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        cursorColor:
                                            Color.fromARGB(255, 12, 34, 107),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 74, 86, 124),
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Adres",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Visibility(
                                visible: !duzenle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.person,
                                                color: Color.fromARGB(
                                                    216, 38, 93, 145)),
                                            Text(
                                              " Yetkili Ad Soyad :  ",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      237, 25, 9, 94),
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 1),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Text(
                                                snapshot.data?.get("firmaad"),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        237, 25, 9, 94),
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.email,
                                              color: Color.fromARGB(
                                                  216, 38, 93, 145),
                                            ),
                                            Text(
                                              "  Email: ",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      237, 25, 9, 94),
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 1),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                snapshot.data?.get("email"),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        237, 25, 9, 94),
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_city,
                                              color: Color.fromARGB(
                                                  216, 38, 93, 145),
                                            ),
                                            Text(
                                              "  Adres :  ",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      237, 25, 9, 94),
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 1),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Text(
                                                snapshot.data?.get("adres"),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        237, 25, 9, 94),
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: duzenle,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            duzenle = false;
                            widget.kod.characters.first == "i"
                                ? Services().istasyonUyeUpdate(
                                    yetkiliadsoyadController.text,
                                    emailController.text,
                                    adresController.text,
                                    FirebaseAuth.instance.currentUser!.uid)
                                : Services().NakliyeUyeUpdate(
                                    yetkiliadsoyadController.text,
                                    emailController.text,
                                    adresController.text,
                                    FirebaseAuth.instance.currentUser!.uid);
                          });
                        },
                        child: Text(
                          "Tamam",
                          style: TextStyle(
                              color: Color.fromARGB(237, 25, 9, 94),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(237, 25, 9, 94))),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.3,
                                MediaQuery.of(context).size.height * 0.07)),
                      ),
                    ),
                    Visibility(
                      visible: !duzenle,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: RadialGradient(
                            radius: 3,
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
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              duzenle = true;
                            });
                          },
                          child: Text(
                            "Düzenle",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shape: StadiumBorder(),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.3,
                                  MediaQuery.of(context).size.height * 0.07)),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // or your loading widget here

                return Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                );
              }
            },
          )),
    );
  }
}
