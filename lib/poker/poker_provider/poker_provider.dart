import 'dart:async';
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rummy_game/constant/custom_dialog/winner_dialog.dart';
import 'package:rummy_game/model/player_name_model.dart';
import 'package:rummy_game/poker/Sockets/poker_sockets.dart';

class PokerProvider extends ChangeNotifier{
  String _player = '';
  List<String> _playerPosition =[];
  List<String> _playerBet =[];
  List<String> _playerNames =[];
  List<String> _playerBilndname =[];
  List<String> _playerChips =[];
  ConfettiController confettiController = ConfettiController();
  List<PlayerNameModel> _playerNameModel = [];
  final List<Map<String,dynamic>> _oldCardList = [
    {"value":"A","suit":"Spades"},
    {"value":"2","suit":"Spades"},
    {"value":"3","suit":"Spades"},
    {"value":"4","suit":"Spades"},
    {"value":"5","suit":"Spades"},
    {"value":"6","suit":"Spades"},
    {"value":"7","suit":"Spades"},
    {"value":"8","suit":"Spades"},
    {"value":"9","suit":"Spades"},
    {"value":"10","suit":"Spades"},
    {"value":"J","suit":"Spades"},
    {"value":"Q","suit":"Spades"},
    {"value":"K","suit":"Spades"},
    {"value":"A","suit":"Hearts"},
    {"value":"2","suit":"Hearts"},
    {"value":"3","suit":"Hearts"},
    {"value":"4","suit":"Hearts"},
    {"value":"5","suit":"Hearts"},
    {"value":"6","suit":"Hearts"},
    {"value":"7","suit":"Hearts"},
    {"value":"8","suit":"Hearts"},
    {"value":"9","suit":"Hearts"},
    {"value":"10","suit":"Hearts"},
    {"value":"J","suit":"Hearts"},
    {"value":"Q","suit":"Hearts"},
    {"value":"K","suit":"Hearts"},
    {"value":"A","suit":"Clubs"},
    {"value":"2","suit":"Clubs"},
    {"value":"3","suit":"Clubs"},
    {"value":"4","suit":"Clubs"},
    {"value":"5","suit":"Clubs"},
    {"value":"6","suit":"Clubs"},
    {"value":"7","suit":"Clubs"},
    {"value":"8","suit":"Clubs"},
    {"value":"9","suit":"Clubs"},
    {"value":"10","suit":"Clubs"},
    {"value":"J","suit":"Clubs"},
    {"value":"Q","suit":"Clubs"},
    {"value":"K","suit":"Clubs"},
    {"value":"A","suit":"Diamonds"},
    {"value":"2","suit":"Diamonds"},
    {"value":"3","suit":"Diamonds"},
    {"value":"4","suit":"Diamonds"},
    {"value":"5","suit":"Diamonds"},
    {"value":"6","suit":"Diamonds"},
    {"value":"7","suit":"Diamonds"},
    {"value":"8","suit":"Diamonds"},
    {"value":"9","suit":"Diamonds"},
    {"value":"10","suit":"Diamonds"},
    {"value":"J","suit":"Diamonds"},
    {"value":"Q","suit":"Diamonds"},
    {"value":"K","suit":"Diamonds"},
    {"value":"Joker","suit":"Joker"}
  ];
  final List<String> _pokerCardList = [
    'assets/cards/bpa.png',
    'assets/cards/bp2.png',
    'assets/cards/bp3.png',
    'assets/cards/bp4.png',
    'assets/cards/bp5.png',
    'assets/cards/bp6.png',
    'assets/cards/bp7.png',
    'assets/cards/bp8.png',
    'assets/cards/bp9.png',
    'assets/cards/bp10.png',
    'assets/cards/bpj.png',
    'assets/cards/bpq.png',
    'assets/cards/bpk.png',
    'assets/cards/rpa.png',
    'assets/cards/rp2.png',
    'assets/cards/rp3.png',
    'assets/cards/rp4.png',
    'assets/cards/rp5.png',
    'assets/cards/rp6.png',
    'assets/cards/rp7.png',
    'assets/cards/rp8.png',
    'assets/cards/rp9.png',
    'assets/cards/rp10.png',
    'assets/cards/rpj.png',
    'assets/cards/rpq.png',
    'assets/cards/rpk.png',
    'assets/cards/bla.png',
    'assets/cards/bl2.png',
    'assets/cards/bl3.png',
    'assets/cards/bl4.png',
    'assets/cards/bl5.png',
    'assets/cards/bl6.png',
    'assets/cards/bl7.png',
    'assets/cards/bl8.png',
    'assets/cards/bl9.png',
    'assets/cards/bl10.png',
    'assets/cards/blj.png',
    'assets/cards/blq.png',
    'assets/cards/blk.png',
    'assets/cards/rsa.png',
    'assets/cards/rs2.png',
    'assets/cards/rs3.png',
    'assets/cards/rs4.png',
    'assets/cards/rs5.png',
    'assets/cards/rs6.png',
    'assets/cards/rs7.png',
    'assets/cards/rs8.png',
    'assets/cards/rs9.png',
    'assets/cards/rs10.png',
    'assets/cards/rsj.png',
    'assets/cards/rsq.png',
    'assets/cards/rsk.png',
    'assets/cards/jake-02.png'
  ];
  int _countdown = 0;
  String _callBet ="";
  final List<String> _buttonImage = [
   'assets/images/pokerCallButton.png',
   'assets/images/pokerCheckButton.png',
    'assets/images/pokerFoldCheckButton.png',
    'assets/images/pokerFoldSwitchButton.png',
  ];
  int _playerCount = 0;
  bool _chipSliderTrueFalse= false;
  List<int> _newHandCard =[];
  List<int> _flopCard =[];
  List<int> _winnerCard =[];
  String _callChips = "";
  String _totalBetChips = '0.0';
  bool _isNewMyTurn = false;
  String _bindName ="";
  List<String> _callButtonList = [];
  String _gameMessage = '';
  double _potAmount = 0;

  List<String> get pokerCardList => _pokerCardList;
  int get countdown => _countdown;
  List<String> get buttonImage => _buttonImage;
  bool get chipSliderTrueFalse => _chipSliderTrueFalse;
  List<Map<String,dynamic>> get oldCardList => _oldCardList;
  List<int> get newHandCard => _newHandCard;
  List<int> get flopCard => _flopCard;
  List<int> get winnerCard => _winnerCard;
  List<String> get callButtonList => _callButtonList;
  String get callChips => _callChips;
  String get totalBetChips => _totalBetChips;
  String get bindName => _bindName;
  bool get isNewMyTurn => _isNewMyTurn;
  List<PlayerNameModel> get playerNameModel => _playerNameModel;
  String get callBet => _callBet;
  String get gameMessage => _gameMessage;
  int get playerCount => _playerCount;
  double get potAmount => _potAmount;
  List<String> get  playerPosition =>_playerPosition;
  List<String> get playerNames => _playerNames;
  List<String> get playerBet => _playerBet;
  List<String> get playerBilndname => _playerBilndname;
  List<String> get playerChips => _playerChips;
  String get player =>  _player;


  void cardsEvent(BuildContext context) async {
    PokerSockets.socket.on("cards", (data) {
      if (kDebugMode) {
        print('Poker Socket In Cards Event Completed $data');
      }

      List<int> newCardData = [];
      List<Map<String, dynamic>> data2 = [];
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> data3 = data[i];
        data2.add(data3);
      }
      for (int i = 0; i < data2.length; i++) {
        Map<String, dynamic> singleCard = data2[i];
        String singleCardValue = singleCard["value"];
        String singleCardSuit = singleCard["suit"];
        for (int j = 0; j < _oldCardList.length; j++) {
          Map<String, dynamic> sCard = _oldCardList[j];
          String sCardValue = sCard["value"];
          String sCardSuit = sCard["suit"];
          if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
            newCardData.add(j + 1);
          }
        }
      }

      setNewRemoveData();
      notifyListeners();
      List<int> newData = [];
      _newHandCard = newCardData;
      for (int i = 0; i < _newHandCard.length; i++) {
        newData.add(_newHandCard[i]);
      }
      _newHandCard = newData;
      notifyListeners();
    });


  }

  setNewRemoveData() {
    _newHandCard.clear();
    notifyListeners();
  }

  void blindNameEvent(BuildContext context,String playerId) async {
    _playerNameModel.clear();
    PokerSockets.socket.on("blindName", (data) {
      if (kDebugMode) {
        print('Poker Socket In Blind Name Event Completed $data');
        PlayerNameModel playerNameModel = PlayerNameModel.fromJson(data);
        _playerNameModel.add(playerNameModel);

        for(int i = 0;i< _playerNames.length;i++){
          if(data["player"].toString().toLowerCase() == _playerNames[i].toString().toLowerCase()){

            _playerBilndname[i] = data['blindName'];
          }
        }

        print('datadatad  Bilnd Name :-  ${_playerBilndname}');

        notifyListeners();
      }


      for(int i = 0; i< _playerNameModel.length;i++){
        if(_playerNameModel[i].player == playerId){
          _bindName = _playerNameModel[i].blindName.toString().trim().toUpperCase();
        }
      }
      notifyListeners();
    });
  }

  void displayPlayerOptionsEvent(BuildContext context) async {
    PokerSockets.socket.on("displayPlayerOptions", (data) {
      if (kDebugMode) {
        print('Poker Socket In Display Player Options Event Completed $data');
      }
      _callButtonList =[];

      if(data != null){
        setMyTurn(true);

        for(int i = 0;i< data['detail']['action'].length;i++){
          _callButtonList.add( data['detail']['action'][i].toString());
        }

        if(data['detail']['callChips'].toString().toLowerCase() != "nan") {
          _callChips = data['detail']['callChips'].toString();
        } else if(data['detail']['callChips'].toString().toLowerCase() != "null") {
          _callChips = data['detail']['callChips'].toString();
        }else if(data['detail']['betChipsRange'].toString().toLowerCase() != "null" || data['detail']['betChipsRange'].toString().toLowerCase().isNotEmpty){
          _totalBetChips = data['detail']['betChipsRange'].toString();
        }else{
          _callChips = '0.0';
        }


        Future.delayed(Duration(seconds: 2),(){
        });

        notifyListeners();
      }
    });
  }

  void flopCardsEvent(BuildContext context) async {
    PokerSockets.socket.on("flopCards", (data) {
      if (kDebugMode) {
        print('Poker Socket In Flop Cards Event Completed $data');
      }

      List<int> newCardData = [];
      List<Map<String, dynamic>> data2 = [];
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> data3 = data[i];
        data2.add(data3);
      }
      for (int i = 0; i < data2.length; i++) {
        Map<String, dynamic> singleCard = data2[i];
        String singleCardValue = singleCard["value"];
        String singleCardSuit = singleCard["suit"];
        for (int j = 0; j < _oldCardList.length; j++) {
          Map<String, dynamic> sCard = _oldCardList[j];
          String sCardValue = sCard["value"];
          String sCardSuit = sCard["suit"];
          if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
            newCardData.add(j + 1);
          }
        }
      }

      notifyListeners();
      List<int> newData = [];
      _flopCard = newCardData;
      for (int i = 0; i < _flopCard.length; i++) {
        newData.add(_flopCard[i]);
      }
      _flopCard = newData;
      notifyListeners();
    });
  }

  void turnCardsEvent(BuildContext context) async {
    PokerSockets.socket.on("turnCards", (data) {
      if (kDebugMode) {
        print('Poker Socket In Turn Cards Event Completed $data');
      }
      List<Map<String, dynamic>> data2 = [];
      List<int> newCardData = [];
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> data3 = data[i];
        data2.add(data3);
      }
      for (int i = 0; i < data2.length; i++) {
        Map<String, dynamic> singleCard = data2[i];
        String singleCardValue = singleCard["value"];
        String singleCardSuit = singleCard["suit"];
        for (int j = 0; j < _oldCardList.length; j++) {
          Map<String, dynamic> sCard = _oldCardList[j];
          String sCardValue = sCard["value"];
          String sCardSuit = sCard["suit"];
          if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
            newCardData.add(j + 1);
          }
        }
      }
      for(int i = 0; i<newCardData.length;i++){
        _flopCard.add(newCardData[i]);
      }

      List<int> dataList = [];

      for(int i = 0;i< _flopCard.length;i++){
        dataList .add(_flopCard[i]);
      }

      _flopCard.clear();

      _flopCard = dataList.toSet().toList();
      notifyListeners();
    });
  }

  void riverCardsEvent(BuildContext context) async {
    PokerSockets.socket.on("riverCards", (data) {
      if (kDebugMode) {
        print('Poker Socket In River Cards Event Completed $data');
      }
      List<Map<String, dynamic>> data2 = [];
      List<int> newCardData = [];
      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> data3 = data[i];
        data2.add(data3);
      }
      for (int i = 0; i < data2.length; i++) {
        Map<String, dynamic> singleCard = data2[i];
        String singleCardValue = singleCard["value"];
        String singleCardSuit = singleCard["suit"];
        for (int j = 0; j < _oldCardList.length; j++) {
          Map<String, dynamic> sCard = _oldCardList[j];
          String sCardValue = sCard["value"];
          String sCardSuit = sCard["suit"];
          if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
            newCardData.add(j + 1);
          }
        }
      }
      for(int i = 0; i<newCardData.length;i++){
        _flopCard.add(newCardData[i]);
      }

      List<int> dataList = [];

      for(int i = 0;i< _flopCard.length;i++){
        dataList .add(_flopCard[i]);
      }

      _flopCard.clear();

      _flopCard = dataList.toSet().toList();

      notifyListeners();
    });
  }

  void winnerEvent(BuildContext context,String playerName) async  {
    PokerSockets.socket.on("winner", (data) {
      if (kDebugMode) {
        print('Poker Socket In winner Completed $data');
      }
      _winnerCard.clear();
      List<Map<String, dynamic>> data2 = [];
      List<int> newCardData = [];
      for (int i = 0; i < data['winner']['winnerHand'].length; i++) {
        Map<String, dynamic> data3 = data['winner']['winnerHand'][i];
        data2.add(data3);
      }
      for (int i = 0; i < data2.length; i++) {
        Map<String, dynamic> singleCard = data2[i];
        String singleCardValue = singleCard["value"];
        String singleCardSuit = singleCard["suit"];
        for (int j = 0; j < _oldCardList.length; j++) {
          Map<String, dynamic> sCard = _oldCardList[j];
          String sCardValue = sCard["value"];
          String sCardSuit = sCard["suit"];
          if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
            newCardData.add(j + 1);
          }
        }
      }
      for(int i = 0; i<newCardData.length;i++){
        _winnerCard.add(newCardData[i]);
      }

      if(data['winnerName'].toString().toLowerCase() == playerName.toLowerCase()){
        WinnerDialog(title: playerName.toUpperCase(), message: 'You are Winner', rightButton: 'adatatta', onTapRightButton: () {  }, leftButton: '', onTapLeftButton: () {  }, controller: confettiController, gameId: '',isShow:true).show(context);
      }else{
        WinnerDialog(title: playerName.toUpperCase(), message: 'You are Lose', rightButton: 'adatatta', onTapRightButton: () {  }, leftButton: '', onTapLeftButton: () {  }, controller: confettiController, gameId: '',isShow:false).show(context);
      }



      notifyListeners();
    });
  }

  void player_actionEvent(BuildContext context,String playerName) async  {
    PokerSockets.socket.on("player-action", (data) {
      if (kDebugMode) {
        print('Poker Socket In player-action Completed $data');
      }

      if(data != null){
        if(data['player'].toString().toLowerCase() == playerName.toLowerCase()){
          _totalBetChips = data['chips'].toString();
        }

        for(int i = 0;i< _playerNames.length;i++){
          if(data['player'].toString().toLowerCase() == _playerNames[i].toLowerCase().toString()){
            _playerBet[i] = data['action']['chips'].toString();
            _playerChips[i] = data['chips'].toString();
          }
        }
      }


      notifyListeners();
    });
  }

  void playerChipsEvent(BuildContext context,String playerName) async  {
    PokerSockets.socket.on("playerChips", (data) {
      if (kDebugMode) {
        print('Poker Socket In Player Chips Completed $data');
      }

      for(int i = 0;i<_playerNames.length;i++){
        if(_playerNames[i].toLowerCase().toString() == data['playerName'].toString().toLowerCase()){

          _playerChips[i] = data['currentPlayerChips'].toString();
        }
      }

      if(data['playerName'].toString().toLowerCase() == playerName.toLowerCase().toString()){
        _totalBetChips = data['currentPlayerChips'].toString();
      }


      notifyListeners();
    });
  }

  void communityCardEvent(BuildContext context,String playerName) async  {
    PokerSockets.socket.on("gameInfo", (data) {
      if (kDebugMode) {
        print('Poker Socket In Game Info Completed ${data}');
      }

      String player = "";
      String chips = "";



      for(int i = 0;i< data['playersInGame'].length;i++){
        _playerBilndname.add('');
        _playerBet.add('');
        _playerNames.add(data['playersInGame'][i]['playerName'].toString());
        _playerChips.add(data['playersInGame'][i]['playerChips'].toString());
      }

      for(int i = 0;i< data['playersInGame'].length;i++){
        if(data['playersInGame'][i]['playerName'].toString() == playerName){
          player = data['playersInGame'][i]['playerName'];
          chips = data['playersInGame'][i]['playerChips'].toString();
          _playerNames.removeAt(i);
          _playerChips.removeAt(i);
        }
      }

      _playerNames.insert(0, player);
      _playerChips.insert(0, chips);

      // if(_playerNames.length == 2){
        //   _playerPosition.add('bottomCenter');
        //   _playerPosition.add('topCenter');
        // }
        // else if(data['playerCount'] == 3){
        //   _playerPosition.add('bottomCenter');
        //   _playerPosition.add('topLeft');
        //   _playerPosition.add('topRight');
        //
        // }
        // else if(data['playerCount'] == 4){
        //   _playerPosition.add('bottomCenter');
        //   _playerPosition.add('topLeft');
        //   _playerPosition.add('topCenter');
        //   _playerPosition.add('topRight');
        // }
        // else if(data['playerCount'] == 5){
        //   _playerPosition.add('bottomCenter');
        //   _playerPosition.add('topLeft');
        //   _playerPosition.add('topRight');
        //   _playerPosition.add('bottomLeft');
        //   _playerPosition.add('bottomRight');
        // }
        // else if(data['playerCount'] == 6){
        //   _playerPosition.add('bottomCenter');
        //   _playerPosition.add('topLeft');
        //   _playerPosition.add('topRight');
        //   _playerPosition.add('topCenter');
        //   _playerPosition.add('bottomLeft');
        //   _playerPosition.add('bottomRight');
        // }
        // else{
        //   _playerPosition.add('bottomCenter');
        // }

        print('FFFFFFFFFFF  :-  ......  $_playerNames ...... $_playerChips');


      print('datadatadta  :-  ${_playerNames}');

      List<Map<String, dynamic>> data2 = [];
      List<int> newCardData = [];
      for (int i = 0; i < data['communityCard'].length; i++) {
        Map<String, dynamic> data3 = data['communityCard'][i];
        data2.add(data3);
      }
      for (int i = 0; i < data2.length; i++) {
        Map<String, dynamic> singleCard = data2[i];
        String singleCardValue = singleCard["value"];
        String singleCardSuit = singleCard["suit"];
        for (int j = 0; j < _oldCardList.length; j++) {
          Map<String, dynamic> sCard = _oldCardList[j];
          String sCardValue = sCard["value"];
          String sCardSuit = sCard["suit"];
          if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
            newCardData.add(j + 1);
          }
        }
      }
      for(int i = 0; i<newCardData.length;i++){
        _flopCard.add(newCardData[i]);
      }

      List<int> dataList = [];

      for(int i = 0;i< _flopCard.length;i++){
        dataList .add(_flopCard[i]);
      }

      _flopCard.clear();

      _flopCard = dataList.toSet().toList();

      notifyListeners();


      notifyListeners();
    });
  }

  void potAmountEvent(BuildContext context) async {
    PokerSockets.socket.on("pot-amount", (data) {
      if (kDebugMode) {
        print('Poker Socket In Pot Amount Completed $data');
      }

      if(data != null){
        _potAmount = double.parse(double.parse(data['potAmount'].toString()).toStringAsFixed(2).toString());
      }

      notifyListeners();
    });
  }

  void winnerAmountEvent(BuildContext context) async {
    PokerSockets.socket.on("winnerAmount", (data) {
      if (kDebugMode) {
        print('Poker Socket In Winner Amount Completed $data');
      }
    });
  }

  void countDownEvent(BuildContext context) async {
    PokerSockets.socket.on("countdown", (data) {
      // if (kDebugMode) {
      //   print('Poker Socket In Count Down Completed $data');
      // }
      if(data['remainingTime'] == 1){
        setMyTurn(false);
        _player ='';
      }

      _countdown = data['remainingTime'];

      notifyListeners();
    });
  }

  void bigBlindTrnWithOutActionEvent(BuildContext context) async {
    PokerSockets.socket.on("bigblindTrnWithOutAction", (data) {
      if (kDebugMode) {
        print('Poker Socket In big Blind Trn WithOut Action Completed $data');
      }
    });
  }

  void roomMessageActionEvent(BuildContext context) async {
    PokerSockets.socket.on("room message", (data) {
      _playerPosition.clear();
      if (kDebugMode) {
        print('Poker Socket In Room Message Completed $data');
      }



      if(data != null){
        _playerCount = int.parse(data['playerCount'].toString());
        if(data['playerCount'] >= 2){
          _gameMessage = 'Enter The game';
        }
        if(data['chips'] != null){
          _totalBetChips = data['chips'].toString();
        }

        notifyListeners();
      }
    });
  }

  void gameMessageActionEvent(BuildContext context) async {
    PokerSockets.socket.on("game-message", (data) {
      if (kDebugMode) {
        print('Poker Socket In Game Message Completed $data');
      }

      if(data != null){
        _gameMessage = data;
      }
    });
  }

  void turnPlayerEvent(BuildContext context) async {
    PokerSockets.socket.on("turn-player", (data) {
      if (kDebugMode) {
        print('Poker Socket In Turn Player Completed $data');
      }
      _player = data['PlayerName'];

      //Poker Socket In Turn Player Completed {playerId: Ridham, PlayerName: Ridham}

    });
  }

  void disconnectEvent(BuildContext context) async {
    PokerSockets.socket.on("disconnect", (data) {
      if (kDebugMode) {
        print('Poker Socket In Disconnect Completed $data');
      }
    });
  }

  void playerNamesEvent(BuildContext context) async {
    PokerSockets.socket.on("playerNames", (data) {
      if (kDebugMode) {
        print('Poker Socket In playerNames Completed $data');
      }
    });
  }

  void gameJoinCard(BuildContext context,String playerId,String gameId,String chips,String contestId,String smallBind,String bigBind,String playerName) async {

    PokerSockets.socket.emit("gameJoin",[playerId,gameId,chips,contestId,smallBind,bigBind,playerName]);
    PokerSockets.socket.on("gameJoin", (data) {
      if (kDebugMode) {
        print('Poker Socket In Game Join Completed ***** draw *****  $data');
      }
    });
  }

  void playerActionCard(BuildContext context,String action,String chip) async {

    print('Poker Socket In Player Action Completed ***** draw ***** ');
    Map<String,dynamic> map = {
      "action":action,
      "chips" : double.parse(chip)
    };
    PokerSockets.socket.emit("playerAction",map);

    setMyTurn(false);
  }

  void disconnectSocket(BuildContext context){
    PokerSockets.socket.disconnect();
    Navigator.pop(context);
  }

  void setChipSliderTrueFalse(bool value){
    _chipSliderTrueFalse = value;
    notifyListeners();
  }

  setMyTurn(bool value) {
    _isNewMyTurn = value;
    notifyListeners();
  }

  setCallBet(String value) {
    _callBet = value;
    notifyListeners();
  }

  resetVariableMethod(){
     _countdown = 0;
     _callBet ="";
     _newHandCard =[];
     _flopCard =[];
     _winnerCard =[];
     _callChips = "";
     _totalBetChips = '';
     _callButtonList = [];
     _player = '';
      _playerPosition =[];
      _playerBet =[];
      _playerNames =[];
      _playerBilndname =[];
     _playerChips =[];
     _potAmount = 0;
     notifyListeners();
  }

}