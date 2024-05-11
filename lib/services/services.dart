import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sevkiyat/screens/AracEkle.dart';

class Services {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late UserCredential cred;

  getUID({
    required String email,
    required String password,
  }) async {
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    String uid = cred.user!.uid;
    return uid;
  }

//İSTASYON KULLANICI KAYIT
  Future<String> signUpIstasyon({
    required String firmaad,
    required String yetkiliadsoyad,
    required String email,
    required String telefon,
    required String password,
    required String adres,
    required String url,
    required GeoPoint location,
  }) async {
    String res = "Some error Occurred";
    try {
      if (firmaad.isNotEmpty ||
          yetkiliadsoyad.isNotEmpty ||
          telefon.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          adres.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        var ref =
            await _firestore.collection("usersistasyon").doc(cred.user!.uid);

        await _firestore
            .collection("ilanlar")
            .doc(cred.user!.uid)
            .collection("ilansevkiyat")
            .doc("sevkiyat")
            .set({
          "uidi": cred.user!.uid,
          "uid": "",
          "aracplaka": "",
          "istasyononay": false,
          "nakliyefirma": "",
          "surucuadsoyad": "",
          "uruncinsi": "",
          "urunmiktar": ""
        });
        await _firestore
            .collection("ilanlar")
            .doc(cred.user!.uid)
            .collection("ilanteklif");
        // adding user in our database
        await ref.set({
          "firmaad": firmaad,
          "yetkiliadsoyad": yetkiliadsoyad,
          "email": email,
          "telefon": telefon,
          "password": password,
          "adres": adres,
          "url": url,
          "uidi": cred.user!.uid,
          "üyeliktipi": "i",
          "location": location
        });
        await _firestore.collection("nakliyedirekt").doc(cred.user!.uid).set({
          "uid": "",
          "uidi": "",
          "nakliyecionay": false,
          "cplaka": "",
          "dplaka": "",
          "surucuadsoyad": "",
          "aracmarka": ""
        });

        await _firestore
            .collection("uyeler")
            .doc(cred.user!.email)
            .set({"uyemail": email});

        res = "Başarılı";
      } else {
        res = "Lütfen tüm alanları doldurunuz";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

//NAKLİYE KULLANICI KAYIT
  Future<String> signUpNakliye({
    required String firmaad,
    required String yetkiliadsoyad,
    required String email,
    required String telefon,
    required String password,
    required String adres,
    required String url,
  }) async {
    String res = "Some error Occurred";
    try {
      if (firmaad.isNotEmpty ||
          yetkiliadsoyad.isNotEmpty ||
          telefon.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          adres.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // adding user in our database
        await _firestore.collection("usersnakliye").doc(cred.user!.uid).set({
          "firmaad": firmaad,
          "yetkiliadsoyad": yetkiliadsoyad,
          "email": email,
          "telefon": telefon,
          "password": password,
          "adres": adres,
          "url": url,
          "uid": cred.user!.uid,
          "üyeliktipi": "n",
        });
        await _firestore
            .collection("usersnakliye")
            .doc(cred.user!.uid)
            .collection("ilansevkiyat")
            .doc("sevkiyat")
            .set({
          "istasyonfirma": "",
          "uruncinsi": "",
          "urunmiktar": "",
          "il": "",
          "ilce": "",
          "teslimattarih": DateTime.now(),
          "uid": cred.user!.uid,
          "uidi": "",
          "surucuonay": false,
          "istasyononay": false,
          "sevkiyatdurum": false
        });

        res = "Başarılı";
      } else {
        res = "Lütfen tüm alanları doldurunuz";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  //Giriş Yap fonksiyonu
  Future signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  ///İSTASYON ÜYE UPDATE
  istasyonUyeUpdate(
      String yetkiliadsoyad, String email, String adres, String uidi) async {
    await _firestore.collection("usersistasyon").doc(uidi).update({
      "yetkiliadsoyad": yetkiliadsoyad,
      "email": email,
      "adres": adres,
    });
  }

  ///NAKLİYE ÜYE UPDATE
  NakliyeUyeUpdate(
      String yetkiliadsoyad, String email, String adres, String uid) async {
    await _firestore.collection("usersnakliye").doc(uid).update({
      "yetkiliadsoyad": yetkiliadsoyad,
      "email": email,
      "adres": adres,
    });
  }

  ///ÖNERİLER
  OneriEkle(String adsoyad, String email, String konu, String mesaj) async {
    await _firestore.collection("oneriler").add({
      "adsoyad": adsoyad,
      "email": email,
      "konu": konu,
      "mesaj": mesaj,
    });
  }

  //ARAÇ EKLE

  aracEkle(
      DateTime dolubasla,
      DateTime dolubit,
      String aracmarka,
      String dolumtesisi,
      int kmfiyat,
      String maxkapasite,
      String minkapasite,
      String url,
      String uid) async {
    await _firestore
        .collection("usersnakliye")
        .doc(uid)
        .collection("arabalar")
        .doc()
        .set({
      "dolubasla": dolubasla,
      "dolubit": dolubit,
      "aracmarka": aracmarka,
      "dolumtesisi": dolumtesisi,
      "kmfiyat": kmfiyat,
      "maxkapasite": maxkapasite,
      "minkapasite": minkapasite,
      "url": url,
    });
  }

  //ARAÇ UPDATE
  aracUpdate(DateTime selectedTimeFirst, DateTime selectedTimeLast, String uid,
      String index) async {
    await _firestore
        .collection("usersnakliye")
        .doc(uid)
        .collection("arabalar")
        .doc(index)
        .update({
      "dolubasla": selectedTimeFirst,
      "dolubit": selectedTimeLast,
    });
  }

  ///İlan Ver
  ilanEkle(
      int mesafe,
      String firmaad,
      String il,
      String ilce,
      String uruncinsi,
      String urunmiktar,
      String dolumtesis,
      String ucret,
      int extraucret,
      String uidi,
      DateTime teslimattarih,
      String url) async {
    await _firestore.collection("ilanlar").doc(uidi).set({
      "mesafe": mesafe,
      "firmaad": firmaad,
      "il": il,
      "ilce": ilce,
      "uruncinsi": uruncinsi,
      "urunmiktar": urunmiktar,
      "dolumtesis": dolumtesis,
      "ucret": ucret,
      "extraucret": extraucret,
      "uidi": uidi,
      "teslimattarih": teslimattarih,
      "url": url
    });
  }

  //////İLANLARA TEKLİF GÖNDER

  ilanTeklifGonder(String aractur, String cplaka, String dplaka,
      String surucuadsoyad, String uid, String uidi, String firmaad) async {
    await _firestore
        .collection("ilanlar")
        .doc(uidi)
        .collection("ilanteklifler")
        .doc(uid)
        .set({
      "aractur": aractur,
      "cplaka": cplaka,
      "dplaka": dplaka,
      "surucuadsoyad": surucuadsoyad,
      "uid": uid,
      "firmaad": firmaad
    });
  }

  //////SEVKİYATIM İŞ ALINDIĞINDA İSTASYON TARAFI

  sevkiyatimIlan(
      String nakliyefirma,
      String uruncinsi,
      String urunmiktar,
      String aracplaka,
      String surucuadsoyad,
      String uid,
      String uidi,
      bool surucuonay,
      bool istasyononay,
      bool sevkiyatdurum) async {
    await _firestore
        .collection("ilanlar")
        .doc(uidi)
        .collection("ilansevkiyat")
        .doc("sevkiyat")
        .set({
      "nakliyefirma": nakliyefirma,
      "uruncinsi": uruncinsi,
      "urunmiktar": urunmiktar,
      "aracplaka": aracplaka,
      "surucuadsoyad": surucuadsoyad,
      "uid": uid,
      "uidi": uidi,
      "surucuonay": surucuonay,
      "istasyononay": istasyononay,
      "sevkiyatdurum": sevkiyatdurum
    });
  }

  //////SEVKİYATIM İŞ ALINDIĞINDA Nakliye TARAFI

  sevkiyatimnakliyeIlan(
      String istasyonfirma,
      String uruncinsi,
      String urunmiktar,
      String il,
      String ilce,
      DateTime teslimattarih,
      String uid,
      String uidi,
      bool surucuonay,
      bool istasyononay,
      bool sevkiyatdurum) async {
    await _firestore
        .collection("usersnakliye")
        .doc(uid)
        .collection("ilansevkiyat")
        .doc("sevkiyat")
        .set({
      "istasyonfirma": istasyonfirma,
      "uruncinsi": uruncinsi,
      "urunmiktar": urunmiktar,
      "il": il,
      "ilce": ilce,
      "teslimattarih": teslimattarih,
      "uid": uid,
      "uidi": uidi,
      "surucuonay": surucuonay,
      "istasyononay": istasyononay,
      "sevkiyatdurum": sevkiyatdurum
    });
  }

  /////SEVKİYATIM ONAY VE UPDATE
  Updatesevkiyatilan(
    String uidi,
    bool surucuonay,
  ) async {
    await _firestore
        .collection("ilanlar")
        .doc(uidi)
        .collection("ilansevkiyat")
        .doc("sevkiyat")
        .update({
      "uidi": uidi,
      "surucuonay": surucuonay,
    });
  }

  Updatesevkiyatnakliyeilan(
      String uid, bool istasyononay, bool sevkiyatdurum) async {
    await _firestore
        .collection("usersnakliye")
        .doc(uid)
        .collection("ilansevkiyat")
        .doc("sevkiyat")
        .update({
      "uidi": uid,
      "istasyononay": istasyononay,
      "sevkiyatdurum": sevkiyatdurum
    });
  }

  //////NAKLİYECİLERE TEKLİF GÖNDER

  NakliyeciTeklifGonder(
      String dolumtesisi,
      String selectedDate,
      String selectedTime,
      String tutar,
      String uid,
      String uidi,
      String firmaad,
      GeoPoint location) async {
    await _firestore
        .collection("usersnakliye")
        .doc(uid)
        .collection("nakliyeteklif")
        .doc(uidi)
        .set({
      "dolumtesisi": dolumtesisi,
      "selecteddate": selectedDate,
      "selectedtime": selectedTime,
      "tutar": tutar,
      "uid": uid,
      "uidi": uidi,
      "firmaad": firmaad,
      "location": location
    });
  }

  Updatedirektnakliyeistasyon(
      String uid,
      String uidi,
      bool nakliyecionay,
      String cplaka,
      String dplaka,
      String surucuadsoyad,
      String aracmarka) async {
    await _firestore
        .collection("usersnakliye")
        .doc(uid)
        .collection("nakliyedirekt")
        .doc("teslimat")
        .set({
      "uid": uid,
      "uidi": uidi,
      "nakliyecionay": nakliyecionay,
      "cplaka": cplaka,
      "dplaka": dplaka,
      "surucuadsoyad": surucuadsoyad,
      "aracmarka": aracmarka
    });
    await _firestore.collection("nakliyedirekt").doc(uidi).set({
      "uid": uid,
      "uidi": uidi,
      "nakliyecionay": nakliyecionay,
      "cplaka": cplaka,
      "dplaka": dplaka,
      "surucuadsoyad": surucuadsoyad,
      "aracmarka": aracmarka
    });
  }

  Updatenakliyedirekt(
    String uidi,
    bool nakliyecionay,
  ) async {
    await _firestore.collection("nakliyedirekt").doc(uidi).update({
      "uidi": uidi,
      "nakliyecionay": nakliyecionay,
    });
  }

  bildirimEkleIstasyon(String bildirim, String uidi) async {
    await _firestore
        .collection("usersistasyon")
        .doc(uidi)
        .collection("bildirimler")
        .doc()
        .set({
      "bildirim": bildirim,
      "uidi": uidi,
    });
  }

  bildirimEklenakliye(String bildirim, String uid) async {
    await _firestore
        .collection("usersnakliye")
        .doc(uid)
        .collection("bildirimler")
        .doc()
        .set({
      "bildirim": bildirim,
      "uid": uid,
    });
  }
}
