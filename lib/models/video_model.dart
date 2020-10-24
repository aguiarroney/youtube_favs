class VideoModel {
  final String id;
  final String title;
  final String channel;
  final String thumb;

  VideoModel({this.id, this.title, this.channel, this.thumb});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json["id"]["videoId"],
      title: json["snippet"]["title"],
      channel: json["snippet"]["channelTitle"],
      thumb: json["snippet"]["thumbnails"]["high"]["url"]
    );
  }
}