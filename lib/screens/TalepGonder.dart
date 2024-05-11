import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:sevkiyat/services/services.dart';

class TalepGonder extends StatefulWidget {
  String minkapasite = "";
  String maxkapasite = "";
  String dolumtesisi = "";
  int kmfiyat = 0;
  String uid = "";
  String firmaad = "";

  TalepGonder(
      {required this.minkapasite,
      required this.maxkapasite,
      required this.dolumtesisi,
      required this.kmfiyat,
      required this.uid,
      required this.firmaad});

  @override
  State<TalepGonder> createState() => _TalepGonderState();
}

class _TalepGonderState extends State<TalepGonder> {
  DatePickerController _datePickerController = DatePickerController();

  late Position position;
  LatLng currentPostion = LatLng(0, 0);
  getlocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
    return currentPostion;
  }

  int selectedindex = 0;
  LatLng getloc = LatLng(0, 0);
  int fiyat = 0;
  String firmaaddata = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*FirebaseFirestore.instance
        .collection("usersistasyon")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots()
        .listen((event) {
      firmaaddata = event["firmaad"];
      getloc = LatLng(event["location"].latittude, event["location"].longitude);
    });*/
    getlocation();
  }

  int fiyathesapla(lat1, lon1, lat2, lon2, birimfiyat) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    fiyat = ((12742 * asin(sqrt(a))) * birimfiyat).toInt();
    print((12742 * asin(sqrt(a))).toString());
    return fiyat;
  }

  List saatler = [
    "00:00",
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
  ];
  String selectedDate = "";
  String selectedTime = "";
  List<String> dolumTesisleri = ["Antalya", "İzmir", "Muğla", "Mersin"];
  String dropSelected = "Dolum Tesisi";
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    DateTime startDate = now.subtract(Duration(days: 14));
    DateTime endDate = now.add(Duration(days: 7));
    fiyathesapla(36.841662, 30.611876, getloc.latitude, getloc.longitude,
        widget.kmfiyat);
    return Scaffold(
      appBar: AppBar(
        title: Text("Talep Gönder"),
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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.23,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Sevkiyat İçin Bilgilerinizi Girip Talep Gönderiniz",
                      style: TextStyle(
                          color: Color.fromARGB(255, 168, 166, 166),
                          letterSpacing: 1),
                    ),
                    Text(
                      "Onaylandığı Takdirde Size Bildirim Göndereceğiz",
                      style: TextStyle(
                          color: Color.fromARGB(255, 168, 166, 166),
                          letterSpacing: 1),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.24,
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/IstasyonReklam1.jpg")),
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade100,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.firmaad,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Min Kapasite : ",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.minkapasite} lt",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Max Kapasite :",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.maxkapasite} lt",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Km Fiyatı :        ",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.kmfiyat} tl",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Girebildiği Dolum Tesisleri : ",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.dolumtesisi,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "TARİH",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 74, 86, 124)),
                    ),
                    Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 20,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200,
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: HorizontalDatePickerWidget(
                                locale: 'tr_TR',
                                startDate: startDate,
                                endDate: endDate,
                                selectedDate: now,
                                widgetWidth: MediaQuery.of(context).size.width,
                                datePickerController: _datePickerController,
                                onValueSelected: (date) {
                                  setState(() {
                                    selectedDate =
                                        DateFormat("dd").format(date);
                                  });
                                  print(selectedDate);
                                },
                              ),
                            ),
                          ),
                        )),
                    Text(
                      "SAAT",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 74, 86, 124)),
                    ),
                    Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 20,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200,
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                alignment: Alignment.center,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: saatler.length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedindex = index;
                                              selectedTime = saatler[index];
                                              print(selectedTime);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: selectedindex == index
                                                    ? Colors.green
                                                    : Colors.white),
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: Text(
                                              saatler[index],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      );
                                    }))),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Color.fromARGB(255, 12, 34, 107))),
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
                                          color:
                                              Color.fromARGB(255, 74, 86, 124)),
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
/*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            onPressed: (() {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2018, 3, 5),
                                  maxTime: DateTime(2050, 6, 7),
                                  onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                                setState(() {
                                  selectedDateTime = date;
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.tr);
                            }),
                            child: Text("Teslimat Tarihi")),
                        Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Text(DateFormat("dd.MM.yyyy-kk:mm")
                              .format(selectedDateTime)
                              .toString()),
                        )
                      ],
                    ),
                   
                   */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Toplam Tutar :",
                          style: TextStyle(
                              color: Color.fromARGB(255, 168, 166, 166),
                              letterSpacing: 1),
                        ),
                        Text(
                          fiyat.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              letterSpacing: 1),
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
                          Services().NakliyeciTeklifGonder(
                              dropSelected,
                              selectedDate,
                              selectedTime,
                              fiyat.toString(),
                              widget.uid,
                              FirebaseAuth.instance.currentUser!.uid,
                              firmaaddata,
                              GeoPoint(currentPostion.latitude,
                                  currentPostion.longitude));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Talebiniz Firmaya İletildi"),
                          ));
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Talep Gönder",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shape: StadiumBorder(),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.7,
                                MediaQuery.of(context).size.height * 0.06)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
