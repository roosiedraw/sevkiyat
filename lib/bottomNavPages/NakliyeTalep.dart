import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sevkiyat/services/services.dart';
import 'package:url_launcher/url_launcher.dart';

class NakliyeTalep extends StatefulWidget {
  NakliyeTalep({Key? key}) : super(key: key);

  @override
  State<NakliyeTalep> createState() => _NakliyeTalepState();
}

class _NakliyeTalepState extends State<NakliyeTalep> {
  TextEditingController cekiciplakaController = TextEditingController();
  TextEditingController dorseplakaController = TextEditingController();
  TextEditingController surucuadsoyadController = TextEditingController();
  List<String> araclistesi = [];
  String dropAracSelected = "Araç Seç";
  bool nakliyeOnay = false;
  String sonuctext = "Teslimat Başladı";
  Color teslimatColor = Colors.green;
  int sayac = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getnakli() async {
    await FirebaseFirestore.instance
        .collection("usersnakliye")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("nakliyedirekt")
        .doc("teslimat")
        .snapshots()
        .listen((event) {
      nakliyeOnay = event["nakliyecionay"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("usersnakliye")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection("nakliyeteklif")
                .snapshots(),
            builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var item = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: item.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: Visibility(
                          visible: sayac == index ? true : false,
                          child: Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: Column(
                                      children: [
                                        Text(
                                          item[index]["firmaad"],
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  237, 25, 9, 94),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Dolum Tesisi: ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          218, 151, 147, 147),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  item[index]["dolumtesisi"],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Teslim Tarihi : ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          218, 151, 147, 147),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  item[index]["selecteddate"],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "-${item[index]["selectedtime"]}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Tutar : ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Color.fromARGB(
                                                                    218,
                                                                    151,
                                                                    147,
                                                                    147),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${item[index]["tutar"]} TL",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    var loc = LatLng(
                                                        item[index]["location"]
                                                            .latitude,
                                                        item[index]["location"]
                                                            .longitude);
                                                    navigateTo(loc.latitude,
                                                        loc.longitude);
                                                  },
                                                  child: Card(
                                                    elevation: 10,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "Konum",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .assistant_direction_rounded,
                                                              color:
                                                                  Colors.blue,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.grey.shade300,
                                    thickness: 2,
                                  ),
                                  Stack(
                                    children: [
                                      Visibility(
                                        visible:
                                            nakliyeOnay == true ? false : true,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    sayac = index;
                                                  });
                                                  showAlertDialog(
                                                      context,
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      item[index]["uidi"],
                                                      true);
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          "usersnakliye")
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser?.uid)
                                                      .collection(
                                                          "nakliyedirekt")
                                                      .doc("teslimat")
                                                      .snapshots()
                                                      .listen((event) {
                                                    nakliyeOnay =
                                                        event["nakliyecionay"];
                                                  });

                                                  //Alert dialog çıksın araç seçilsin
                                                },
                                                child: Text(
                                                  "Kabul Et",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color.fromARGB(
                                                        237, 25, 9, 94),
                                                    shape: StadiumBorder(),
                                                    fixedSize: Size(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.04)),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .runTransaction((Transaction
                                                          myTransaction) async {
                                                    await myTransaction.delete(
                                                        item[index].reference);
                                                  });
                                                },
                                                child: Text(
                                                  "Reddet",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          237, 25, 9, 94),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color.fromARGB(
                                                        235, 239, 238, 240),
                                                    shape: StadiumBorder(),
                                                    fixedSize: Size(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.04)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            nakliyeOnay == true ? true : false,
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: teslimatColor,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                sonuctext,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    letterSpacing: 1,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.black),
                                                  onPressed: (() {
                                                    setState(() {
                                                      Services()
                                                          .Updatenakliyedirekt(
                                                              item[index]
                                                                  ["uidi"],
                                                              false);
                                                      FirebaseFirestore.instance
                                                          .runTransaction(
                                                              (Transaction
                                                                  myTransaction) async {
                                                        await myTransaction
                                                            .delete(item[index]
                                                                .reference);
                                                      });
                                                      sonuctext =
                                                          "İş Tamamlandı";
                                                      teslimatColor =
                                                          Colors.grey;
                                                    });
                                                  }),
                                                  child: Text(
                                                    "İşi Sonlandır",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
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
            })),
      ),
    );
  }

  showAlertDialog(
      BuildContext context, String uid, String uidi, bool nakliyecionay) {
    // set up the button
    String cplaka = cekiciplakaController.text;

    Widget okButton = TextButton(
      child: Text("Tamam"),
      onPressed: () {
        setState(() {
          Services().Updatedirektnakliyeistasyon(
              uid,
              uidi,
              true,
              cekiciplakaController.text,
              dorseplakaController.text,
              surucuadsoyadController.text,
              dropAracSelected);
        });

        Navigator.pop(
          context,
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bilgileri Gönder"),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(color: Color.fromARGB(255, 12, 34, 107))),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("usersnakliye")
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection("arabalar")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var item = snapshot.data!.docs;
                      for (int i = 0; i < item.length; i++) {
                        araclistesi.insert(i, item[i]["aracmarka"]);
                      }
                      return Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              Text(
                                dropAracSelected,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 74, 86, 124)),
                              ),
                              new DropdownButton<String>(
                                items: araclistesi.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 74, 86, 124)),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  setState(() {
                                    dropAracSelected = val!;
                                  });
                                },
                              ),
                            ],
                          ));
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
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color.fromARGB(255, 12, 34, 107))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: cekiciplakaController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Çekici Plaka",
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color.fromARGB(255, 12, 34, 107))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: dorseplakaController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Dorse Plaka",
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color.fromARGB(255, 12, 34, 107))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: surucuadsoyadController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Sürücü Ad Soyad",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
