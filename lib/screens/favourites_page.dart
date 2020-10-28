import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:yt_favoritos/api.dart';
import 'package:yt_favoritos/blocs/favourite_bloc.dart';
import 'package:yt_favoritos/models/video_model.dart';

class FavouritesPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FavouriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, VideoModel>>(
        stream: bloc.outFav,
        initialData: {},
        builder: (context, snapshot){
          return ListView(
            children: snapshot.data.values.map((v) {
              return InkWell(
                onTap: (){
                  FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: v.id);
                },
                onLongPress: (){},
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(
                      child: Text("${v.title}", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

}