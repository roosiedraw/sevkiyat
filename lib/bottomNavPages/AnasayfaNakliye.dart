import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sevkiyat/bottomNavPages/Araclar.dart';
import 'package:sevkiyat/screens/IlanTalepGonder.dart';
import 'package:sevkiyat/screens/Sevkiyatilanlar.dart';

import '../screens/others/ReklamDetay.dart';

class AnasayfaNakliye extends StatefulWidget {
  AnasayfaNakliye({Key? key}) : super(key: key);

  @override
  State<AnasayfaNakliye> createState() => _AnasayfaNakliyeIstasyonState();
}

class _AnasayfaNakliyeIstasyonState extends State<AnasayfaNakliye> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///REKLAM ALANI
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
                child: ImageSlideshow(
                  indicatorBackgroundColor: Colors.white,
                  indicatorRadius: 5,
                  indicatorColor: Colors.blue,
                  onPageChanged: (value) {
                    //debugPrint('Page changed: $value');
                    setState(() {
                      _index = value;
                    });
                  },
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ReklamDetay(
                                      index: _index + 3,
                                      hangiuye: "Nakliye",
                                    ))));
                      },
                      child: Image.asset(
                        'assets/images/NakliyeReklam3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ReklamDetay(
                                      index: _index + 3,
                                      hangiuye: "Nakliye",
                                    ))));
                      },
                      child: Image.asset(
                        'assets/images/NakliyeReklam4.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ReklamDetay(
                                      index: _index + 3,
                                      hangiuye: "Nakliye",
                                    ))));
                      },
                      child: Image.asset(
                        'assets/images/NakliyeReklam5.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //İLAN BAŞLIK

            /////İLANLAR LİSTESİ
            Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Araclar())));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Text(
                        "ARAÇLARIM",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Text(
                    "Araçlarınızı Bu Alandan Kaydedebilirsiniz",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SevkiyatIlan())));
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Text(
                        "SEVKİYAT İLANLARI",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Güncel Veya İleri Tarihli Sevkiyat İlanlarına Ulaşabilirsiniz",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
