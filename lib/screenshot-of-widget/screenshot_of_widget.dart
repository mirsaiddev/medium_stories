import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenshotOfWidget extends StatefulWidget {
  @override
  _ScreenshotOfWidgetState createState() => _ScreenshotOfWidgetState();
}

class _ScreenshotOfWidgetState extends State<ScreenshotOfWidget> {
  GlobalKey _globalKey = GlobalKey();

  _takeScreenshot() async {
    RenderRepaintBoundary _boundary = _globalKey.currentContext.findRenderObject();
    var _image = await _boundary.toImage();
    var _byteData = await _image.toByteData(format: ImageByteFormat.png);
    await Share.file('image', 'image.png', _byteData.buffer.asUint8List(), 'image/png', text: 'Your text');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    color: Colors.red,
                    child: Center(
                      child: FlutterLogo(
                        size: 100,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Icon(Icons.repeat_sharp),
                    bottom: 15,
                    left: 15,
                  ),
                  Positioned(
                    child: Icon(Icons.thumb_up),
                    bottom: 15,
                    right: 15,
                  ),
                  Positioned(
                    child: Icon(Icons.nfc),
                    top: 15,
                    left: 15,
                  ),
                  Positioned(
                    child: Icon(Icons.speaker_phone_sharp),
                    top: 15,
                    right: 15,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                await _takeScreenshot();
              },
              child: Text("Take screenshot"),
            ),
          ],
        ),
      ),
    );
  }
}
