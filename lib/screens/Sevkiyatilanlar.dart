import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sevkiyat/screens/IlanTalepGonder.dart';

class SevkiyatIlan extends StatefulWidget {
  SevkiyatIlan({Key? key}) : super(key: key);

  @override
  State<SevkiyatIlan> createState() => _SevkiyatIlanState();
}

class _SevkiyatIlanState extends State<SevkiyatIlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sevkiyat İlanları"),
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
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Sevkiyat İlanlarına Burdan Ulaşabilirsiniz.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 168, 166, 166),
                    ),
                  ),
                  Text(
                    "Talep Gönder Butonuyla İstediğiniz Firmaya Talep Gönderebilirsiniz.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 168, 166, 166),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("ilanlar")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var item = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: item.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: RadialGradient(
                                      radius: 1.4,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.height * 0.23,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.14,
                                              child: Image.file(
                                                  File(item[index]["url"])),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  item[index]["firmaad"],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "Adres: ${item[index]["il"]}/${item[index]["ilce"]}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "Ürün Miktar : ${item[index]["urunmiktar"]} lt",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "Mesafe: ${item[index]["mesafe"]}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "Fiyat: ${item[index]["ucret"]} tl",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) => IlanTalepGonder(
                                                          uidi: item[index]
                                                              ["uidi"],
                                                          url: item[index]
                                                              ["url"],
                                                          firmaad: item[index]
                                                              ["firmaad"],
                                                          adres: item[index]
                                                              ["il"],
                                                          urunmiktar: item[
                                                                  index]
                                                              ["urunmiktar"],
                                                          mesafe: item[index]
                                                                  ["mesafe"]
                                                              .toString(),
                                                          dolumtesisi: item[
                                                                  index]
                                                              ["dolumtesis"],
                                                          ucret: item[index]
                                                              ["ucret"]))));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: RadialGradient(
                                                  radius: 1.4,
                                                  stops: [
                                                    0.0,
                                                    0.57,
                                                    50,
                                                  ],
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 150, 206, 223),
                                                    Color.fromARGB(
                                                        255, 18, 91, 150),
                                                    Color.fromARGB(
                                                        255, 4, 19, 32),
                                                  ],
                                                ),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                "Talep Gönder",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
