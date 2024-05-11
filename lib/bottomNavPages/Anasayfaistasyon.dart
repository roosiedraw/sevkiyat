import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sevkiyat/bottomNavPages/Ilanver.dart';
import 'package:sevkiyat/screens/TalepGonder.dart';
import 'package:sevkiyat/screens/nakliyefirmalar.dart';
import 'package:sevkiyat/screens/others/ReklamDetay.dart';

class AnasayfaIstasyon extends StatefulWidget {
  AnasayfaIstasyon({Key? key}) : super(key: key);

  @override
  State<AnasayfaIstasyon> createState() => _AnasayfaIstasyonState();
}

class _AnasayfaIstasyonState extends State<AnasayfaIstasyon> {
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
            //REKLAM ALANI
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
                child: ImageSlideshow(
                  indicatorBackgroundColor: Color.fromARGB(255, 228, 228, 228),
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
                                      index: _index,
                                      hangiuye: "Istasyon",
                                    ))));
                      },
                      child: Image.asset(
                        'assets/images/IstasyonReklam0.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ReklamDetay(
                                      index: _index,
                                      hangiuye: "Istasyon",
                                    ))));
                      },
                      child: Image.asset(
                        'assets/images/IstasyonReklam1.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ReklamDetay(
                                      index: _index,
                                      hangiuye: "Istasyon",
                                    ))));
                      },
                      child: Image.asset(
                        'assets/images/IstasyonReklam2.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => NakliyeFirmalar())));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Text(
                        "NAKLİYE FİRMALARINI GÖR",
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
                    "Güncel Nakliyat İlanlarına Bu Alandan Ulaşabilirsiniz",
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Ilanver())));
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Text(
                        "SEVKİYAT İLANI VER",
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
                    "Güncel Veya İleri Tarihli Sevkiyat İlanı Verebilirsiniz",
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
