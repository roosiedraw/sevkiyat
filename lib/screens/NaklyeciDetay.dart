import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sevkiyat/screens/TalepGonder.dart';

class NakliyeciDetay extends StatefulWidget {
  String uid = "";
  String firmaad = "";
  NakliyeciDetay({required this.firmaad, required this.uid});

  @override
  State<NakliyeciDetay> createState() => _NakliyeciDetayState();
}

class _NakliyeciDetayState extends State<NakliyeciDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Araçlar"),
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
                height: MediaQuery.of(context).size.height * 0.08,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Güncel Nakliye Firmalarına ve Araçlarına Burdan Ulaşabilirsiniz.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 168, 166, 166),
                      ),
                    ),
                    Text(
                      "Km Başı En Ucuzdan En Pahalıya Sıralanmıştır.",
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("usersnakliye")
                      .doc(widget.uid)
                      .collection("arabalar")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var item = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: item.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const RadialGradient(
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.22,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.20,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.14,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  item[index]["aracmarka"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      " Min kapasite: ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      "${item[index]["minkapasite"]} lt",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      " Max kapasite: ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      "${item[index]["maxkapasite"]} lt",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      " Girilen Tesisler: ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      item[index]
                                                          ["dolumtesisi"],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      " Km Fiyat: ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      "${item[index]["kmfiyat"].toString()} tl",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) => TalepGonder(
                                                          minkapasite: item[
                                                                  index]
                                                              ["minkapasite"],
                                                          maxkapasite: item[
                                                                  index]
                                                              ["maxkapasite"],
                                                          dolumtesisi: item[
                                                                  index]
                                                              ["dolumtesisi"],
                                                          kmfiyat: item[index]
                                                              ["kmfiyat"],
                                                          uid: widget.uid,
                                                          firmaad: widget
                                                              .firmaad))));
                                            },
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              elevation: 10,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.14,
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
                                                child: Text(
                                                  "DETAY",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
              )
            ],
          ),
        ));
  }
}
