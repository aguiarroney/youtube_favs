import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yt_favoritos/blocs/videos_bloc.dart';
import 'package:yt_favoritos/delegates/data_search.dart';
import 'package:yt_favoritos/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("assets/yt_logo_rgb_dark.png"),
        ),
        backgroundColor: Colors.black,
        actions: [
          Align(
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String searchResult = await showSearch(context: context, delegate: DataSearch());
              print("!!!! resultado da pesquisa: $searchResult");
              if(searchResult != null){
                BlocProvider.of<VideosBloc>(context).inSearch.add(searchResult);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        initialData: [],
        builder: (context, snapshot){
          if(snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index){
                if(index< snapshot.data.length)
                  return VideoTile(snapshot.data[index]);
                else if(index > 1){
                  BlocProvider.of<VideosBloc>(context).inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                else{
                  return Container(child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Center(child: Text("Faça uma pesquisa", style: TextStyle(fontStyle: FontStyle.italic),),)
                  ));
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          else
            return Container(child: Center(child: Text("Faça uma pesquisa", style: TextStyle(fontStyle: FontStyle.italic),),),);
        },
      ),
    );
  }
}
