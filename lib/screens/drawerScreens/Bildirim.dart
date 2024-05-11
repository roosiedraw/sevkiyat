import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Bildirim extends StatefulWidget {
  Bildirim({Key? key}) : super(key: key);

  @override
  State<Bildirim> createState() => _BildirimState();
}

class _BildirimState extends State<Bildirim> {
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
          "BİLDİRİMLER",
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                children: [
                  Text(
                    "Bildirimlerinize Bu Alandan Ulaşabilirsiniz",
                    style: TextStyle(
                        color: Color.fromARGB(255, 168, 166, 166),
                        letterSpacing: 1),
                  ),
                  Text(
                    "24 Saat Sonra Bildirimleriniz  Silinecektir.",
                    style: TextStyle(
                        color: Color.fromARGB(255, 168, 166, 166),
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("usersnakliye")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("bildirimler")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var item = snapshot.data!.docs;
                    return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: ((context, index) {
                          int daysBetween(DateTime from, DateTime to) {
                            from = DateTime(from.year, from.month, from.day);
                            to = DateTime(to.year, to.month, to.day);
                            return (to.difference(from).inHours / 24).round();
                          }

                          Future.delayed(const Duration(days: 1), () {
                            otomatsil(item[index]);
                          });

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(237, 25, 9, 94)),
                              child: Text(
                                item[index]["bildirim"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  otomatsil(var a) async {
    await FirebaseFirestore.instance
        .runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(a.reference);
    });
  }
}
