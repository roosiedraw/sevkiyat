import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sevkiyat/services/services.dart';

class Sevkiyatim extends StatefulWidget {
  Sevkiyatim({Key? key}) : super(key: key);

  @override
  State<Sevkiyatim> createState() => _SevkiyatimState();
}

class _SevkiyatimState extends State<Sevkiyatim> {
  bool seciliid = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIlandurum(FirebaseAuth.instance.currentUser!.uid);
  }

  void getIlandurum(uidi) async {
    var collection = FirebaseFirestore.instance.collection('ilanlar');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      if (documentID == FirebaseAuth.instance.currentUser!.uid) {
        setState(() {
          seciliid = true;
        });
      } else {
        setState(() {
          seciliid = false;
        });
      }
      print(documentID);
    }
  }

  bool teslimOnay = false;
  Color butonColor = Color.fromARGB(255, 140, 223, 6);
  String butonText = "Teslimatı Onayla";
  bool absorb = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: seciliid
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("ilanlar")
                      .doc(FirebaseAuth.instance.currentUser?.uid ??
                          "7MMTjJ249uMlnTrmW43VBhBEjAE3")
                      .collection("ilansevkiyat")
                      .snapshots(),
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var item = snapshot.data!.docs;
                      return item.first["sevkiyatdurum"] == false
                          ? Container(
                              color: Colors.grey.shade200,
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.not_interested_rounded,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Sevkiyat Yok...",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            letterSpacing: 1)),
                                  ),
                                ],
                              )),
                            )
                          : Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "Sevkiyat Detaylarına Buradan Ulaşabilirsiniz",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 168, 166, 166),
                                          letterSpacing: 1),
                                    ),
                                    Stack(
                                      children: [
                                        Visibility(
                                          visible: !item.first["surucuonay"],
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.22,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                    width: 150,
                                                    height: 120,
                                                    image: AssetImage(
                                                        "assets/images/truck.gif")),
                                                Text(
                                                  "Sevkiyat Süreci Başladı",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 140, 223, 6),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: item.first["surucuonay"],
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.22,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                    width: 150,
                                                    height: 120,
                                                    image: AssetImage(
                                                        "assets/images/login.gif")),
                                                Text(
                                                  "Sevkiyat Bitti",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 223, 6, 115),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: RadialGradient(
                                            radius: 2.4,
                                            stops: [
                                              0.0,
                                              0.57,
                                              50,
                                            ],
                                            colors: [
                                              Color.fromARGB(
                                                  255, 150, 206, 223),
                                              Color.fromARGB(255, 18, 91, 150),
                                              Color.fromARGB(255, 4, 19, 32),
                                            ],
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Ürün Cinsi:",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255, 23, 31, 34),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text("Ürün Miktarı:",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255, 23, 31, 34),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text("Araç Plaka:",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255, 23, 31, 34),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text("Sürücü Adı:",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255, 23, 31, 34),
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.first["uruncinsi"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    item.first["urunmiktar"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    item.first["aracplaka"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    item.first["surucuadsoyad"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Siparişiniz Teslim Edildiğinde Teslimatı Onaylayın",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 168, 166, 166),
                                          letterSpacing: 1),
                                    ),
                                    Stack(
                                      children: [
                                        Visibility(
                                          visible: !item.first["surucuonay"],
                                          child: Text(
                                            "Sürücünün Teslimatı Onaylamasını bekleyin...",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 168, 166, 166),
                                                letterSpacing: 1),
                                          ),
                                        ),
                                        Visibility(
                                          visible: item.first["surucuonay"],
                                          child: AbsorbPointer(
                                            absorbing: absorb,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  absorb = true;
                                                  butonColor = Colors.grey;
                                                  butonText =
                                                      "Teslimat Tamamlandı";

                                                  //Nakliye sefer sayısını artır
                                                  //Sevkiyatı Sil
                                                  Services()
                                                      .Updatesevkiyatnakliyeilan(
                                                          item.first["uid"],
                                                          true,
                                                          false);
                                                  Services().sevkiyatimIlan(
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      false,
                                                      true,
                                                      false);
                                                });
                                              },
                                              child: Text(
                                                butonText,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: butonColor,
                                                  shape: StadiumBorder(),
                                                  fixedSize: Size(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.55,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.06)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
                  }))
              : Container(
                  child: Center(
                    child: Text(
                      "Henüz Sevkiyatınız Yok.Lütfen Önce İlan verin",
                      style: TextStyle(
                          color: Color.fromARGB(255, 168, 166, 166),
                          letterSpacing: 1),
                    ),
                  ),
                )),
    );
  }
}
