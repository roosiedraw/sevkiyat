import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sevkiyat/screens/AracEkle.dart';
import 'package:sevkiyat/screens/Daterange.dart';
import 'package:sevkiyat/services/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Araclar extends StatefulWidget {
  Araclar({Key? key}) : super(key: key);

  @override
  State<Araclar> createState() => _AraclarState();
}

class _AraclarState extends State<Araclar> {
  String ind = "";
  DateTime _selectedDatefirst = DateTime.now();
  DateTime _selectedDatelast = DateTime.now();
  bool getphoto = false;
  File? _image = File("/assets/images/login.gif");
  late var item;
  final ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Araçlarım"),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                " Aracınızı '+' Simgesine Basarak Kayıt Edebilirsiniz",
                style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(
                      255,
                      119,
                      118,
                      118,
                    ),
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("usersnakliye")
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection("arabalar")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      item = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: item.length,
                          itemBuilder: ((context, index) {
                            return Card(
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
                                width: MediaQuery.of(context).size.width * 0.6,
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
                                                item[index]["aracmarka"],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Min Kapasite: ${item[index]["minkapasite"]}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Max Kapasite : ${item[index]["maxkapasite"]} lt",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Girilen Tesisler: ${item[index]["dolumtesisi"]}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Birim Fiyat: ${item[index]["kmfiyat"]} tl",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
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
                                                Color.fromARGB(255, 4, 19, 32),
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
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .runTransaction((Transaction
                                                          myTransaction) async {
                                                    await myTransaction.delete(
                                                        item[index].reference);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    ind = item[index].id;
                                                  });
                                                  print(item[index].id);
                                                  showAlertDialog(context, ind);
                                                },
                                                child: Icon(
                                                  Icons.edit_calendar_outlined,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
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
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        isExtended: true,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => AracEkle())));
        },
        child: Center(
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, index) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("TAMAM"),
      onPressed: () {
        Services().aracUpdate(_selectedDatefirst, _selectedDatelast,
            FirebaseAuth.instance.currentUser!.uid.toString(), index);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Tarih Seç"),
      content: Container(
        width: 200,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: (() {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      _selectedDatefirst = date;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.tr);
                }),
                child: Text("Başlama Tarihi")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: (() {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      _selectedDatelast = date;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.tr);
                }),
                child: Text("Bitiş Tarihi")),
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
}
