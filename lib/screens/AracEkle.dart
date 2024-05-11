import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sevkiyat/services/services.dart';

class AracEkle extends StatefulWidget {
  AracEkle({Key? key}) : super(key: key);

  @override
  State<AracEkle> createState() => _AracEkleState();
}

class _AracEkleState extends State<AracEkle> {
  TextEditingController minkapasiteController = TextEditingController();
  TextEditingController maxkapasiteController = TextEditingController();
  TextEditingController dolumtesisiController = TextEditingController();
  TextEditingController kmfiyatController = TextEditingController();
  TextEditingController aracmarkaController = TextEditingController();
  bool getphoto = false;
  File? _image = File("");
  final ImagePicker imagePicker = ImagePicker();
  String imageUrl = "";
  int fiyat = 0;

  uploadProfileImage(File? image) async {
    Reference reference =
        FirebaseStorage.instance.ref("Araclar").child(_image!.path);
    UploadTask uploadTask = reference.putFile(_image!);
    TaskSnapshot snapshot = await uploadTask;
    imageUrl =
        await snapshot.ref.getDownloadURL().then((value) => imageUrl = value);
    print("IMAGEURL${imageUrl}");
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //ARAÇ FOTO
                GestureDetector(
                  onTap: (() {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              getImagefromGallery();
                            },
                            child: Card(
                              color: Color.fromARGB(255, 65, 64, 62),
                              child: Container(
                                width: 120,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.picture_in_picture,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Text(
                                      "Galeri",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              getImagefromCamera();
                            },
                            child: Card(
                              color: Color.fromARGB(255, 65, 64, 62),
                              child: Container(
                                width: 120,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.camera,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Text(
                                      "Kamera",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
                  }),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      alignment: Alignment.center,
                      height: 125,
                      width: 125,
                      color: Color.fromARGB(31, 109, 12, 12),
                      child: Stack(
                        children: [
                          Visibility(
                            visible: !getphoto,
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              size: 40,
                              color: Color.fromARGB(255, 12, 34, 107),
                            ),
                          ),
                          Visibility(
                            visible: getphoto,
                            child: Image.file(
                              _image ?? File(""),
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //Araç Min kapasite
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white38)),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: minkapasiteController,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            cursorColor: Color.fromARGB(255, 12, 34, 107),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 74, 86, 124),
                              ),
                              border: InputBorder.none,
                              hintText: "Araç Min. Kapasite",
                            ),
                          ),
                        ),
                      ),

                      //Araç Max Kapasite
                      Container(
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white38)),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: maxkapasiteController,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            cursorColor: Color.fromARGB(255, 12, 34, 107),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 74, 86, 124),
                              ),
                              border: InputBorder.none,
                              hintText: "Araç Max. Kapasite",
                            ),
                          ),
                        ),
                      ),
                    ],
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
                  border: Border.all(color: Colors.white38)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: aracmarkaController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Araç Marka",
                  ),
                ),
              ),
            ),
            //Dolum Tesisi
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white38)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: dolumtesisiController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Girilebilen Dolum Tesisi",
                  ),
                ),
              ),
            ),
            //KM kapasite
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white38)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: kmfiyatController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Km Fiyatı",
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Services().aracEkle(
                      DateTime.now(),
                      DateTime.now(),
                      aracmarkaController.text,
                      dolumtesisiController.text,
                      int.parse(kmfiyatController.text),
                      maxkapasiteController.text,
                      minkapasiteController.text,
                      _image!.path.toString(),
                      FirebaseAuth.instance.currentUser!.uid);
                });

                Navigator.pop(context);
              },
              child: Text(
                "Aracı Kaydedin",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(237, 25, 9, 94),
                  shape: StadiumBorder(),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.height * 0.08)),
            ),
          ],
        ),
      ),
    );
  }

  //////////FOTO SEÇ EKLE
  Future getImagefromCamera() async {
    var image = await ImagePicker.platform.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
      getphoto = true;
    });
  }

  Future getImagefromGallery() async {
    var image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
      getphoto = true;
    });
  }
}
