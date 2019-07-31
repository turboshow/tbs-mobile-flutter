import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<SettingsPage> {
  String udpxyAddr;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) =>
        this.setState(() => udpxyAddr = prefs.getString('udpxyAddr')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('udpxy'),
            trailing: udpxyAddr == null || udpxyAddr.isEmpty
                ? Icon(Icons.keyboard_arrow_right)
                : Text(udpxyAddr),
            onTap: _showUdpxyEditor,
          ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }

  _showUdpxyEditor() {
    showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return _UdpxyEditor(udpxyAddr ?? '');
        }).then((result) {
      if (result != null) {
        setState(() => udpxyAddr = result);

        SharedPreferences.getInstance()
            .then((prefs) => prefs.setString('udpxyAddr', udpxyAddr));
      }
    });
  }
}

class _UdpxyEditor extends StatefulWidget {
  final String _initValue;

  _UdpxyEditor(this._initValue);

  @override
  State<StatefulWidget> createState() {
    return _UdpxyEditorState();
  }
}

class _UdpxyEditorState extends State<_UdpxyEditor> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.text = widget._initValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('udpxy地址'),
      content: TextField(
        controller: _controller,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          textColor: Theme.of(context).textTheme.subtitle.color,
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('保存'),
          textColor: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(_controller.text),
        )
      ],
    );
  }
}
