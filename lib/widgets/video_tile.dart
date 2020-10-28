import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:yt_favoritos/blocs/favourite_bloc.dart';
import 'package:yt_favoritos/models/video_model.dart';

import '../api.dart';

class VideoTile extends StatelessWidget {

  final VideoModel video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FavouriteBloc>(context);

    return GestureDetector(
      onTap: () {
          FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id);

      },
      child: Container(
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
                StreamBuilder<Map<String, VideoModel>>(
                  stream: bloc.outFav,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return IconButton(
                        icon: Icon(snapshot.data.containsKey(video.id) ?  Icons.star : Icons.star_border),
                        color: Colors.black,
                        onPressed: (){
                          bloc.toggleFavourite(video);
                        },
                      );
                    }
                    else
                      return Center(child: CircularProgressIndicator());
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
