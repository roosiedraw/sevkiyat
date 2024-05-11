import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sevkiyat/services/services.dart';

class Ilanver extends StatefulWidget {
  Ilanver({Key? key}) : super(key: key);

  @override
  State<Ilanver> createState() => _IlanverState();
}

class _IlanverState extends State<Ilanver> {
  String firmaad = "";
  String a = "";
  double mesafe = 0;
  LatLng getloc = LatLng(0, 0);
  List<String> dolumTesisleri = ["Antalya", "İzmir", "Muğla", "Mersin"];
  String dropSelected = "Dolum Tesisi";
  DateTime selectedDateTime = DateTime.now();
  TextEditingController uruncinsiController = TextEditingController();
  TextEditingController urunmiktarController = TextEditingController();
  TextEditingController extraucretController = TextEditingController();
  TextEditingController ilController = TextEditingController();
  TextEditingController ilceController = TextEditingController();
  TextEditingController ucretController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  getloca() {
    FirebaseFirestore.instance
        .collection("usersistasyon")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((event) {
      getloc = LatLng(event["location"].latitude, event["location"].longitude);
    });
    return getloc;
  }

  double mesafehesapla(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    mesafe = 12742 * asin(sqrt(a));
    print((12742 * asin(sqrt(a))).toString());
    return mesafe;
  }

  @override
  Widget build(BuildContext context) {
    geturl();
    getfirmaad();
    getloca();
    mesafehesapla(36.841662, 30.611876, getloc.latitude, getloc.longitude);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("İlan Ver"),
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
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: Color.fromARGB(255, 12, 34, 107))),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: ilController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        cursorColor: Color.fromARGB(255, 12, 34, 107),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 74, 86, 124),
                          ),
                          border: InputBorder.none,
                          hintText: "İl",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: Color.fromARGB(255, 12, 34, 107))),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: ilceController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        cursorColor: Color.fromARGB(255, 12, 34, 107),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 74, 86, 124),
                          ),
                          border: InputBorder.none,
                          hintText: "İlçe",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(color: Color.fromARGB(255, 12, 34, 107))),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: uruncinsiController,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    cursorColor: Color.fromARGB(255, 12, 34, 107),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 74, 86, 124),
                      ),
                      border: InputBorder.none,
                      hintText: "Ürün Cinsi",
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
                    border:
                        Border.all(color: Color.fromARGB(255, 12, 34, 107))),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: urunmiktarController,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    cursorColor: Color.fromARGB(255, 12, 34, 107),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 74, 86, 124),
                      ),
                      border: InputBorder.none,
                      hintText: "Ürün Miktarı",
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
                    border:
                        Border.all(color: Color.fromARGB(255, 12, 34, 107))),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Text(
                          dropSelected,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 74, 86, 124)),
                        ),
                        DropdownButton<String>(
                          items: dolumTesisleri.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 74, 86, 124)),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? val) {
                            setState(() {
                              dropSelected = val!;
                            });
                          },
                        ),
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Ücret Bilgisi           ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 34, 107),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 60,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: ucretController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        cursorColor: Color.fromARGB(255, 12, 34, 107),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 74, 86, 124),
                          ),
                        ),
                        maxLength: 5,
                      ),
                    ),
                  ),
                  Text(
                    "TL",
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 34, 107),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Ekstra Ücret Bilgisi",
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 34, 107),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 60,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: extraucretController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        cursorColor: Color.fromARGB(255, 12, 34, 107),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 74, 86, 124),
                          ),
                        ),
                        maxLength: 5,
                      ),
                    ),
                  ),
                  Text(
                    "TL",
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 34, 107),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black, elevation: 10),
                      onPressed: (() {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                          setState(() {
                            selectedDateTime = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.tr);
                      }),
                      child: Text("Teslimat Tarihi")),
                  Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Text(DateFormat("dd.MM.yyyy-kk:mm")
                        .format(selectedDateTime)
                        .toString()),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: RadialGradient(
                    radius: 4.3,
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
                    Services().ilanEkle(
                        mesafe.round(),
                        firmaad,
                        ilController.text,
                        ilceController.text,
                        uruncinsiController.text,
                        urunmiktarController.text,
                        dropSelected,
                        ucretController.text,
                        int.parse(extraucretController.text),
                        FirebaseAuth.instance.currentUser!.uid,
                        selectedDateTime,
                        a);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Tebrikler ilanınız Oluşturuldu"),
                    ));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "İlan Ver ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shape: StadiumBorder(),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.height * 0.06)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  geturl() async {
    await FirebaseFirestore.instance
        .collection("usersistasyon")
        .doc(
          FirebaseAuth.instance.currentUser!.uid,
        )
        .snapshots()
        .listen((data) {
      a = data["url"];
      print(a);
    });
    return a.toString();
  }

  getfirmaad() async {
    await FirebaseFirestore.instance
        .collection("usersistasyon")
        .doc(
          FirebaseAuth.instance.currentUser!.uid,
        )
        .snapshots()
        .listen((data) {
      firmaad = data["firmaad"];
      print(firmaad);
    });
    return firmaad.toString();
  }
}
