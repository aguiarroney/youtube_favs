import 'package:flutter/material.dart';
import 'package:yt_favoritos/models/video_model.dart';

class VideoTile extends StatelessWidget {

  final VideoModel video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: Image.network(video.thumb, fit: BoxFit.cover,),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(video.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 2,),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8,1,8,8),
                      child: Text(video.channel),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.star_border),
                color: Colors.black,
                onPressed: (){

                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
