import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '土拨鼠影音',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Channel> _channels = [];

  void initState() {
    super.initState();

    _loadChannels();
  }

  _loadChannels() {
    DefaultAssetBundle.of(context)
        .loadString('assets/channels.json')
        .then(json.decode)
        .then((channelsJson) => (channelsJson as List).map((channelJson) => Channel.fromJson(channelJson)).toList())
        .then((channels) => setState(() => _channels = channels));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('土拨鼠影音'),
        ),
        body: ListView.separated(
            itemBuilder: (_, index) => ListTile(
                  title: Text(_channels[index].title),
                ),
            separatorBuilder: (_, __) => Divider(),
            itemCount: _channels.length));
  }
}
