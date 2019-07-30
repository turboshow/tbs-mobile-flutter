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
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(child: OrientationBuilder(builder: (_, orientation) {
          if (orientation == Orientation.portrait) {
            return Container();
          }

          return AndroidView(
            viewType: "plugins.turboshow.cn/playerview",
            onPlatformViewCreated: (id) {
              final methodChannel = MethodChannel('plugins.turboshow.cn/playerview_$id');
              methodChannel.invokeMethod('play', widget.url);
            },
          );
        })),
      ),
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([]);
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
        return true;
      },
    );
  }
}
