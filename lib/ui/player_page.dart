import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerPage extends StatefulWidget {
  final String url;

  PlayerPage(this.url);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AndroidView(
          viewType: "plugins.turboshow.cn/playerview",
          onPlatformViewCreated: (id) {
            final methodChannel = MethodChannel('plugins.turboshow.cn/playerview_$id');
            methodChannel.invokeMethod('play', widget.url);
          },
        ),
      ),
    );
  }
}
