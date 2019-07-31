import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs/model/channel.dart';
import 'package:tbs/ui/player_page.dart';
import 'package:tbs/ui/settings_page.dart';

class PlaylistPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<PlaylistPage> {
  List<Channel> _channels = [];

  void initState() {
    super.initState();

    _loadChannels();
  }

  _loadChannels() {
    DefaultAssetBundle.of(context)
        .loadString('assets/channels.json')
        .then(json.decode)
        .then((channelsJson) => (channelsJson as List)
            .map((channelJson) => Channel.fromJson(channelJson))
            .toList())
        .then((channels) => setState(() => _channels = channels));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('土拨鼠影音'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: _openSettingsPage,
            )
          ],
        ),
        body: ListView.separated(
            itemBuilder: (_, index) {
              final channel = _channels[index];
              return InkWell(
                onTap: () => _openPlayerPage(channel.url),
                child: ListTile(
                  dense: false,
                  title: Text(channel.title),
                ),
              );
            },
            separatorBuilder: (_, __) => Divider(
                  height: 0,
                ),
            itemCount: _channels.length));
  }

  _openPlayerPage(String url) {
    SharedPreferences.getInstance().then((prefs) {
      final udpxyAddr = prefs.getString('udpxyAddr');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PlayerPage(udpxyAddr == null
              ? url
              : 'http://$udpxyAddr/${url.replaceAll('://', '/')}'),
        ),
      );
    });
  }

  _openSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SettingsPage()),
    );
  }
}
