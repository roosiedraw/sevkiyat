import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/services.dart';

class Isler extends StatefulWidget {
  Isler({Key? key}) : super(key: key);

  @override
  State<Isler> createState() => _IslerState();
}

class _IslerState extends State<Isler> {
  bool sevkdurumu = false;
  bool istasyonOnay = false;
  String butonText = "Teslimatı Onayla";
  Color butonColor = Color.fromARGB(255, 140, 223, 6);
  bool absorb = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("usersnakliye")
                .doc(FirebaseAuth.instance.currentUser?.uid)
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
                    : Container(
                        child: Column(
                          children: [
                            Text(
                              "Sevkiyat Detaylarına Buradan Ulaşabilirsiniz",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 168, 166, 166),
                                  letterSpacing: 1),
                            ),
                            Stack(
                              children: [
                                Visibility(
                                  visible: !item.first["surucuonay"],
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
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
                                          "Sevkiyat Süreci Başladı.",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 140, 223, 6),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: item.first["surucuonay"],
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                            width: 150,
                                            height: 120,
                                            image: AssetImage(
                                                "assets/images/logo.png")),
                                        Text(
                                          "Sevkiyat Tamamlandı.",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 223, 6, 115),
                                              fontWeight: FontWeight.bold,
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
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: RadialGradient(
                                    radius: 2.4,
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
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.26,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("İstasyon:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 23, 31, 34),
                                                  fontWeight: FontWeight.bold)),
                                          Text("İl:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 23, 31, 34),
                                                  fontWeight: FontWeight.bold)),
                                          Text("İlce:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 23, 31, 34),
                                                  fontWeight: FontWeight.bold)),
                                          Text("Ürün Cinsi:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 23, 31, 34),
                                                  fontWeight: FontWeight.bold)),
                                          Text("Ürün Miktarı:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 23, 31, 34),
                                                  fontWeight: FontWeight.bold)),
                                          Text("T.Tarihi:",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 23, 31, 34),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.first["istasyonfirma"],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item.first["il"],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item.first["ilce"],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item.first["uruncinsi"],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item.first["urunmiktar"],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            DateFormat("dd.MM.yyyy-kk:mm")
                                                .format(DateTime.parse(item
                                                    .first["teslimattarih"]
                                                    .toDate()
                                                    .toString()))
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Siparişi Teslim Ettiğinizde Teslimatı Onaylayın",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 168, 166, 166),
                                    letterSpacing: 1),
                              ),
                            ),
                            Visibility(
                              visible: !item.first["surucuonay"],
                              child: Text(
                                item.first["istasyononay"] == true
                                    ? "İstasyon Teslimatınızı Onayladı.İyi Günler"
                                    : "İstasyonun Teslimatı Onaylamasını bekleyin...",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 168, 166, 166),
                                    letterSpacing: 1),
                              ),
                            ),
                            Visibility(
                              visible: !item.first["istasyononay"],
                              child: AbsorbPointer(
                                absorbing: absorb,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      absorb = true;
                                      butonColor = Colors.grey;
                                      butonText = "Teslimat Tamamlandı";

                                      //Nakliye sefer sayısını artır
                                      //Sevkiyatı Sil
                                      Services().Updatesevkiyatilan(
                                          item.first["uidi"], true);
                                      Services().sevkiyatimnakliyeIlan(
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          DateTime.now(),
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          "",
                                          true,
                                          false,
                                          true);
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
                                          MediaQuery.of(context).size.width *
                                              0.55,
                                          MediaQuery.of(context).size.height *
                                              0.06)),
                                ),
                              ),
                            ),
                          ],
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
            })),
      ),
    );
  }

  sevkdurum() {
    Timer(Duration(seconds: 10), (() {
      sevkdurumu = false;
    }));
    return sevkdurumu;
  }
}
