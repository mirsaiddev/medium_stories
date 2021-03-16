import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medium_stories_test/il-ilce-secimi/il_secme_sayfasi.dart';
import 'package:medium_stories_test/il-ilce-secimi/ilce_secme_sayfasi.dart';
import 'package:medium_stories_test/il-ilce-secimi/il_model.dart';

class IlIlceSecimi extends StatefulWidget {
  @override
  _IlIlceSecimiState createState() => _IlIlceSecimiState();
}

class _IlIlceSecimiState extends State<IlIlceSecimi> {
  /// JSON yüklenmesinin tamamlanıp tamamlanmadığı kontrolu için
  bool _yuklemeTamamlandiMi = false;

  /// Sonuç il ve ilçe
  String _secilenIl;
  String _secilenIlce;

  /// Butonların rengini seçilip seçilmediğine göre değiştirmek için (zorunlu değil)
  bool _ilSecilmisMi = false;
  bool _ilceSecilmisMi = false;

  /// JSON'dan okuyacağımız "Il" nesnelerinin toplanacağı liste
  List<dynamic> _illerListesi = [];

  /// Il ve Ilce Secme Sayfalarına gönderirken tanımlayacağımız listeler
  List<String> _ilIsimleriListesi = [];
  List<String> _ilceIsimleriListesi = [];

  /// Il ve Ilce Secme Sayfalarından gelecek olan index değerleri, bunlar ile listelerden gereken Il ve Ilce adını alabileceğiz
  int _secilenIlIndexi;
  int _secilenIlceIndexi;

  /// JSON'u okuyup içinden Il nesnelerini listede toplama
  Future<void> _illeriGetir() async {
    String jsonString = await rootBundle.loadString('json/il-ilce.json');

    final jsonResponse = json.decode(jsonString);

    _illerListesi = jsonResponse.map((x) => Il.fromJson(x)).toList();
  }

  /// Il nesnelerinden sadece il_adi değişkenlerini ayrı bir listede toplama
  void _ilIsimleriniGetir() {
    _ilIsimleriListesi = [];

    _illerListesi.forEach((element) {
      _ilIsimleriListesi.add(element.ilAdi);
    });

    setState(() {
      _yuklemeTamamlandiMi = true;
    });
  }

  /// Ilce seçimi için seçilen ile göre ilçeleri getirme
  void _secilenIlinIlceleriniGetir(String _secilenIl) {
    _ilceIsimleriListesi = [];
    _illerListesi.forEach((element) {
      if (element.ilAdi == _secilenIl) {
        element.ilceler.forEach((element) {
          _ilceIsimleriListesi.add(element.ilceAdi);
        });
      }
    });
  }

  Future<void> _ilSecmeSayfasinaGit() async {
    if (_yuklemeTamamlandiMi) {
      _secilenIlIndexi = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IlSecimiSayfasi(ilIsimleri: _ilIsimleriListesi),
        ),
      );
      _secilenIlceIndexi = null;
      _ilSecilmisMi = true;
      _secilenIl = _ilIsimleriListesi[_secilenIlIndexi];
      _secilenIlinIlceleriniGetir(_illerListesi[_secilenIlIndexi].toString());
      setState(() {});
    }
  }

  Future<void> _ilceSecmeSayfasinaGit() async {
    if (_ilSecilmisMi) {
      _secilenIlinIlceleriniGetir(_ilIsimleriListesi[_secilenIlIndexi]);
      _secilenIlceIndexi = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IlceSecmeSayfasi(ilceIsimleri: _ilceIsimleriListesi),
        ),
      );
      _ilceSecilmisMi = true;
      _secilenIlce = _ilceIsimleriListesi[_secilenIlceIndexi];
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _illeriGetir().then((value) => _ilIsimleriniGetir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İl İlçe Seçimi"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                  child: RaisedButton(
                    color: _ilSecilmisMi ? Colors.indigo[300] : Colors.grey,
                    child: Center(
                      child: Text(
                        "İl Seçiniz",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () async {
                      await _ilSecmeSayfasinaGit();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                  child: RaisedButton(
                    color: _ilceSecilmisMi ? Colors.indigo[300] : Colors.grey,
                    child: Center(
                      child: Text(
                        "İlçe Seçiniz",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () async {
                      await _ilceSecmeSayfasinaGit();
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Seçilen İl : $_secilenIl",
                  style: TextStyle(fontSize: 26),
                ),
                Text(
                  "Seçilen İlçe : $_secilenIlce",
                  style: TextStyle(fontSize: 26),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
