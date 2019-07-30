import 'package:flutter/material.dart';
import 'package:tbs/ui/playlist_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '土拨鼠影音',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlaylistPage(),
    );
  }
}
