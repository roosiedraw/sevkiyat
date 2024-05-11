import 'package:flutter/material.dart';

class ReklamDetay extends StatefulWidget {
  int index = 0;
  String hangiuye = "";
  ReklamDetay({required this.index, required this.hangiuye});

  @override
  State<ReklamDetay> createState() => _ReklamDetayState();
}

class _ReklamDetayState extends State<ReklamDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image.asset(
                  'assets/images/${widget.hangiuye}Reklam${widget.index}.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 238, 237, 235),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
