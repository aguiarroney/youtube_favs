import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:yt_favoritos/models/video_model.dart';

const API_KEY = "AIzaSyBeg0HKblJusEqxpUmVT7CuNKlJASZcaOI";

/**
 *  "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
 *  "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
 *  "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
 * */

class Api {

  String _search;
  String _nextToken;

  List<VideoModel> decode(http.Response response){

    if(response.statusCode == 200){
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];
      List<VideoModel> videos = decoded["items"].map<VideoModel>((map){
        return VideoModel.fromJson(map);
      }).toList();

      print("!!!! videos");
      return videos;
    } else if(response.statusCode == 403) {
     throw("Limite de recurso da API excedido");
    }
    else  throw Exception("Failed to load videos");
  }

  Future<List<VideoModel>> search(String search) async {
    _search = search;
      http.Response response = await http.get(
          "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
      );

      return decode(response);
  }

  Future<List<VideoModel>> nextPage() async {
    http.Response response =  await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
    );

    return decode(response);
  }
}
