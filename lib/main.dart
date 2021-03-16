import 'package:flutter/material.dart';
import 'package:medium_stories_test/il-ilce-secimi/il_ilce_secimi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/ililcesicimi': (context) => IlIlceSecimi(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medium Stories"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo)),
              onPressed: () {
                Navigator.pushNamed(context, '/ililcesicimi');
              },
              child: Text("Il Ilçe Seçimi"),
            ),
          ],
        ),
      ),
    );
  }
}
