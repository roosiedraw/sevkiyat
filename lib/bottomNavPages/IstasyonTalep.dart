import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sevkiyat/screens/Home.dart';
import 'package:sevkiyat/services/services.dart';

class IstasyonTalep extends StatefulWidget {
  IstasyonTalep({Key? key}) : super(key: key);

  @override
  State<IstasyonTalep> createState() => _IstasyonTalepState();
}

class _IstasyonTalepState extends State<IstasyonTalep> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getdatas();
  }

  var datas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("ilanlar")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection("ilanteklifler")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  getdatas();
                  if (snapshot.hasData) {
                    var item = snapshot.data!.docs;
                    return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            elevation: 10,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
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
                                          color: Color.fromARGB(237, 25, 9, 94),
                                          thickness: 2,
                                          endIndent: 110,
                                          indent: 105,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Araç Tipi : ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            218, 151, 147, 147),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Çekici Plaka : ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            218, 151, 147, 147),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Dorse Plaka: ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            218, 151, 147, 147),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Sürücü Adı : ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            218, 151, 147, 147),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
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
                                                    item[index]["aractur"],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    item[index]["cplaka"],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    item[index]["dplaka"],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    item[index]
                                                        ["surucuadsoyad"],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          /*
                                          Row(
                                            children: [

                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Ürün Cinsi : ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            218, 151, 147, 147),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Ürün Miktarı : ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            218, 151, 147, 147),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Ücret: ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            218, 151, 147, 147),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
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
                                                    datas["uruncinsi"] ?? "",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${datas["urunmiktar"] ?? ""} lt",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${datas["ucret"] ?? ""} TL",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                          
                                            ],
                                          ),*/
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            //////SEVKİYATI YAPACAK BİLGİLERİ SEVKİYAT SAYFASINA GÖNDER
                                            Services().sevkiyatimIlan(
                                                "nakliyefirma",
                                                datas["uruncinsi"] ?? "",
                                                datas["urunmiktar"] ?? "",
                                                item[index]["cplaka"],
                                                item[index]["surucuadsoyad"],
                                                item[index]["uid"],
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                false,
                                                false,
                                                true);
                                            Services().sevkiyatimnakliyeIlan(
                                                "firmaistasyon",
                                                datas["uruncinsi"] ?? "",
                                                datas["urunmiktar"] ?? "",
                                                datas["il"] ?? "",
                                                datas["ilce"] ?? "",
                                                datas["teslimattarih"]
                                                        .toDate() ??
                                                    "",
                                                item[index]["uid"] ?? "",
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                false,
                                                false,
                                                true);

                                            //DİĞER TEKLİFLERİ SİL
                                          },
                                          child: Text(
                                            "Kabul Et",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  237, 25, 9, 94),
                                              shape: StadiumBorder(),
                                              fixedSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
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
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  235, 239, 238, 240),
                                              shape: StadiumBorder(),
                                              fixedSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04)),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
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
          ],
        ),
      ),
    );
  }

  getdatas() async {
    await FirebaseFirestore.instance
        .collection("ilanlar")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((data) {
      print(' length : ${data["uruncinsi"]}');
      datas = data;
    });
  }
}
