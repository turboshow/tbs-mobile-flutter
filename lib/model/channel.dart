class Channel {
  final String title;
  final String url;

  Channel({this.title, this.url});

  Channel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        url = json['url'];
}
