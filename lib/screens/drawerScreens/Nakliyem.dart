import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Nakliyem extends StatefulWidget {
  Nakliyem({Key? key}) : super(key: key);

  @override
  State<Nakliyem> createState() => _NakliyemState();
}

class _NakliyemState extends State<Nakliyem> {
  bool siparisonayistasyon = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Sevkiyat Detaylarına Buradan Ulaşabilirsiniz",
              style: TextStyle(
                  color: Color.fromARGB(255, 168, 166, 166), letterSpacing: 1),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("nakliyedirekt")
                    .doc(FirebaseAuth.instance.currentUser?.uid ?? "uidi")
                    .snapshots(),
                builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var item = snapshot.data!;
                    return Center(
                      child: Card(
                        shadowColor: Colors.black,
                        elevation: 25,
                        color: Color.fromARGB(237, 25, 9, 94),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Text(
                                  "Nakliye Durumu",
                                  style: TextStyle(
                                      color: Color.fromARGB(237, 25, 9, 94),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Araç Markası: ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  218, 151, 147, 147),
                                            ),
                                          ),
                                          Text(
                                            item.get("aracmarka") ?? "",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Çekici Plakası: ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  218, 151, 147, 147),
                                            ),
                                          ),
                                          Text(
                                            item.get("cplaka") ?? "",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Dorse Plakası: ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  218, 151, 147, 147),
                                            ),
                                          ),
                                          Text(
                                            item.get("dplaka") ?? "",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sürücü Adı: ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  218, 151, 147, 147),
                                            ),
                                          ),
                                          Text(
                                            item.get("surucuadsoyad") ?? "",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      strokeAlign: StrokeAlign.inside,
                                      width: 2,
                                      color: item.get("nakliyecionay") == true
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Text(
                                  item.get("nakliyecionay") == true
                                      ? "Siparişiniz Yola Çıkmıştır"
                                      : "Siparişiniz Tamamlandı",
                                  style: TextStyle(
                                      color: item.get("nakliyecionay") ??
                                              true == true
                                          ? Colors.green
                                          : Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
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
                })),
          ],
        ),
      ),
    );
  }
}
