import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rummy_game/constant/api_constant.dart';
import 'package:rummy_game/model/create_game_model.dart';

class CreateGameProvider extends ChangeNotifier {
  List<Game> _createGameDataList = [];
  bool _isLoading = false;


  List<Game> get createGameDataList => _createGameDataList;
  bool get isLoading => _isLoading;

  void clearLoadingValue(){
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCreateGameList(List<bool> data) async {
    int number = 0;
    for(int i = 0; i < data.length; i++){
      if(data[i] == true){
        number = i + 2;
      }
    }
    _isLoading = true;
    notifyListeners();
    Uri uri = Uri.parse('${ApiConstant().baseUrl}${ApiConstant().createGameApi}');
    var response = await http.post(uri,body: {
      "selectedPlayerCount":'2'
    });
    if(response.body.isEmpty){
      _isLoading = false;
      notifyListeners();
      return;
    }
    List<Game> gameData = [];
    Map<String,dynamic> responseData = jsonDecode(response.body);
    for(int i = 0; i < responseData["games"].length; i++){
      Game game = Game.fromJson(responseData["games"][i]);
      gameData.add(game);
    }
    _createGameDataList = gameData;
    notifyListeners();
  }

  Future<void> playerJoinGame(String gameId) async {
    Uri uri = Uri.parse("${ApiConstant().baseUrl}${ApiConstant().joinGameApi}");
    var response = await http.post(uri,body: {
      "gameId": gameId,
      "playerName": "Rajesh Tripathy"
    });
    if(response.body.isEmpty){
      return;
    }
    Map<String,dynamic> responseData = jsonDecode(response.body);
    // Fluttertoast.showToast(
    //     msg: responseData["message"],
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.grey,
    //     textColor: Colors.white,
    //     fontSize: 12);
  }


}