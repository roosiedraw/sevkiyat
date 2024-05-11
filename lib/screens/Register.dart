import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sevkiyat/screens/Home.dart';
import 'package:sevkiyat/screens/detay/kvkk.dart';
import 'package:sevkiyat/screens/detay/sozlesme.dart';
import 'package:sevkiyat/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  String kod = "";
  Register({required this.kod});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseStorage storage = FirebaseStorage.instance;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocation();
  }

  bool isLoggedIn = false;
  String name = '';
  String userTypes = '';
  TextEditingController firmaadController = TextEditingController();
  TextEditingController yetkiliadsoyadController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  String a = "";
  bool sozlesmeonay = false;
  bool kvkkonay = false;
  bool getphoto = false;
  File? _image = File("");
  final ImagePicker imagePicker = ImagePicker();
  String kod = "";
  String imageUrl = "";

  /* uploadProfileImage(File? image) async {
    Reference reference =
        FirebaseStorage.instance.ref("Profile").child(_image!.path);
    UploadTask uploadTask = reference.putFile(_image!);
    TaskSnapshot snapshot = await uploadTask;
    setState(() async {
      imageUrl =
          await snapshot.ref.getDownloadURL().then((value) => imageUrl = value);
    });

    print(imageUrl);
    return imageUrl;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
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
        title: Text("ÜYE OL"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                  border: Border.all(color: Colors.white38)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
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
            //Yetkili ad soyad
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
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  controller: yetkiliadsoyadController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Yetkili Ad Soyad",
                  ),
                ),
              ),
            ),

            //Email
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
                  controller: emailController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
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
            //Telefon
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
                  controller: telefonController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Telefon",
                  ),
                ),
              ),
            ),
            //Şifre
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
                  controller: passwordController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Şifre",
                  ),
                ),
              ),
            ),

            //adres
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
                  controller: adresController,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Color.fromARGB(255, 12, 34, 107),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 86, 124),
                    ),
                    border: InputBorder.none,
                    hintText: "Adres",
                  ),
                ),
              ),
            ),
            //Sözleşme
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterSwitch(
                    height: 20,
                    width: 50,
                    value: sozlesmeonay,
                    onToggle: ((value) {
                      setState(() {
                        sozlesmeonay = value;
                      });
                    })),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Sozlesme())));
                    },
                    child: Text(
                      "Sözleşme Metni",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterSwitch(
                    height: 20,
                    width: 50,
                    value: kvkkonay,
                    onToggle: ((value) {
                      setState(() {
                        kvkkonay = value;
                      });
                    })),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Kvkk())));
                    },
                    child: Text(
                      "KVKK Metni       ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),

            //Kayıt ol buton
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  radius: 3,
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
                  if (EmailValidator.validate(emailController.text) == true &&
                      passwordController.text.length >= 6 &&
                      sozlesmeonay == true &&
                      kvkkonay == true) {
                    Services().signUpIstasyon(
                        firmaad: firmaadController.text,
                        yetkiliadsoyad: yetkiliadsoyadController.text,
                        email: emailController.text,
                        telefon: telefonController.text,
                        password: passwordController.text,
                        adres: adresController.text,
                        url: _image!.path.toString(),
                        location: GeoPoint(
                            currentPostion.latitude, currentPostion.longitude));

                    isLoggedIn ? logout() : loginUser();

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Home(kod: widget.kod))),
                        (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Lütfen Bilgilerinizi Girin"),
                    ));
                  }
                },
                child: Text(
                  "Kayıt Ol",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: StadiumBorder(),
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                        MediaQuery.of(context).size.height * 0.08)),
              ),
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

  //OTO Kullanıcı giriş kaydet
  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', "");

    setState(() {
      name = '';
      isLoggedIn = false;
    });
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', emailController.text);
    prefs.setString('kod', widget.kod);
    setState(() {
      kod = widget.kod;
      name = emailController.text;
      isLoggedIn = true;
    });

    emailController.clear();
  }
}
