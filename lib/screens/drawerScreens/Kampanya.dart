import 'package:flutter/material.dart';

class Kampanya extends StatefulWidget {
  Kampanya({Key? key}) : super(key: key);

  @override
  State<Kampanya> createState() => _KampanyaState();
}

class _KampanyaState extends State<Kampanya> {
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
          "KAMPANYA",
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
      backgroundColor: Colors.grey.shade200,
      body: Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                children: [
                  Text(
                    "Bu Alandan Kampanyalara Ulaşabilirsiniz",
                    style: TextStyle(
                        color: Color.fromARGB(255, 168, 166, 166),
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.25,
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
              child: Text(
                "Kampanya Yok",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
