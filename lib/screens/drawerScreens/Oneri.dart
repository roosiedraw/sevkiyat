import 'package:flutter/material.dart';
import 'package:sevkiyat/services/services.dart';

class Oneri extends StatefulWidget {
  Oneri({Key? key}) : super(key: key);

  @override
  State<Oneri> createState() => _OneriState();
}

class _OneriState extends State<Oneri> {
  TextEditingController adsoyadController = TextEditingController();
  TextEditingController konuController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mesajController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
        title: Text(
          "Öneri Ve Şikayetiniz",
          style: TextStyle(fontSize: 18),
        ),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
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
                            color: Color.fromARGB(255, 18, 91, 150))),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: adsoyadController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        cursorColor: Color.fromARGB(255, 18, 91, 150),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 74, 86, 124),
                          ),
                          border: InputBorder.none,
                          hintText: "Ad Soyad",
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
                        border: Border.all(
                            color: Color.fromARGB(255, 18, 91, 150))),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: konuController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        cursorColor: Color.fromARGB(255, 18, 91, 150),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 74, 86, 124),
                          ),
                          border: InputBorder.none,
                          hintText: "Konu",
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
                        border: Border.all(
                            color: Color.fromARGB(255, 18, 91, 150))),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: emailController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        cursorColor: Color.fromARGB(255, 18, 91, 150),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 74, 86, 124),
                          ),
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.26,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color.fromARGB(255, 18, 91, 150))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  maxLines: 6,
                  minLines: 5,
                  controller: mesajController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 18, 91, 150),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Metni Giriniz...",
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  radius: 2.3,
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
                  Services().OneriEkle(
                      adsoyadController.text,
                      emailController.text,
                      konuController.text,
                      mesajController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  "Gönder",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: StadiumBorder(side: BorderSide()),
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.3,
                        MediaQuery.of(context).size.height * 0.07)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
