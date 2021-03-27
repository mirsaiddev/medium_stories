import 'package:flutter/material.dart';
import 'package:medium_stories_test/il-ilce-secimi/il_ilce_secimi.dart';
import 'package:medium_stories_test/screenshot-of-widget/screenshot_of_widget.dart';

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
        '/screenshotofwidget': (context) => ScreenshotOfWidget(),
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
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
              onPressed: () {
                Navigator.pushNamed(context, '/screenshotofwidget');
              },
              child: Text("Screenshot of Widget"),
            ),
          ],
        ),
      ),
    );
  }
}
