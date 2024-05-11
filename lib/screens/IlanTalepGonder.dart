import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:sevkiyat/services/services.dart';

class IlanTalepGonder extends StatefulWidget {
  String uidi = "";
  String url = "";
  String firmaad = "";
  String adres = "";
  String urunmiktar = "";
  String mesafe = "";
  String dolumtesisi = "";
  String ucret = "";
  IlanTalepGonder({
    required this.uidi,
    required this.url,
    required this.firmaad,
    required this.adres,
    required this.urunmiktar,
    required this.mesafe,
    required this.dolumtesisi,
    required this.ucret,
  });

  @override
  State<IlanTalepGonder> createState() => _IlanTalepGonderState();
}

class _IlanTalepGonderState extends State<IlanTalepGonder> {
  Color selectedColor1 = Colors.black;
  Color selectedColor2 = Colors.white;
  String selected = "";
  TextEditingController firmaadController = TextEditingController();
  TextEditingController cekiciplakaController = TextEditingController();
  TextEditingController dorseplakaController = TextEditingController();
  TextEditingController surucuadsoyadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("İlana Talep Gönder"),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.22,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Firma: ",
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.firmaad,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Adres: ",
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.adres,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Miktar: ",
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.urunmiktar,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Mesafe: ",
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.mesafe,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Dolum Tesisi: ",
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            widget.dolumtesisi,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "Ücret: ",
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            widget.ucret,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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
                  controller: firmaadController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Firma Adı",
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Araç Tipi :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey)),
                InkWell(
                  onTap: () {
                    setState(() {
                      selected = "kamyon";
                      selectedColor1 = Color.fromARGB(237, 25, 9, 94);
                      selectedColor2 = Colors.grey.shade200;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        color: selectedColor1,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Color.fromARGB(237, 25, 9, 94))),
                    child: Text(
                      "Kamyon",
                      style: TextStyle(
                          color: selectedColor2,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selected = "tır";
                      selectedColor1 = Colors.grey.shade200;
                      selectedColor2 = Color.fromARGB(237, 25, 9, 94);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        color: selectedColor2,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Color.fromARGB(237, 25, 9, 94))),
                    child: Text(
                      "Tır",
                      style: TextStyle(
                          color: selectedColor1,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                )
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  radius: 4,
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
                  Services().ilanTeklifGonder(
                      selected,
                      cekiciplakaController.text,
                      dorseplakaController.text,
                      surucuadsoyadController.text,
                      FirebaseAuth.instance.currentUser!.uid,
                      widget.uidi,
                      firmaadController.text);
                  Navigator.pop(
                    context,
                  );
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
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                        MediaQuery.of(context).size.height * 0.06)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
