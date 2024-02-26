import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rummy_game/constant/custom_dialog/card_player_winner.dart';
import 'package:rummy_game/model/player_winner_model.dart';
import 'package:rummy_game/utils/Sockets.dart';

class SocketProvider extends ChangeNotifier {
  List<int> _cardNumberList = [];
  bool isTrueData = false;
  int _secondsRemaining = 30;
  int _countDown = 20;
  int _stopCountDown = 1;
  int _playerCount = 0;
  bool _isMyTurn = false;
  List<int> _newSort = [];
  List _data2List =[];
  Timer? _timer;
  final List<Map<String, dynamic>> _cardList = [
    {"value": "A", "suit": "Spades"},
    {"value": "2", "suit": "Spades"},
    {"value": "3", "suit": "Spades"},
    {"value": "4", "suit": "Spades"},
    {"value": "5", "suit": "Spades"},
    {"value": "6", "suit": "Spades"},
    {"value": "7", "suit": "Spades"},
    {"value": "8", "suit": "Spades"},
    {"value": "9", "suit": "Spades"},
    {"value": "10", "suit": "Spades"},
    {"value": "J", "suit": "Spades"},
    {"value": "Q", "suit": "Spades"},
    {"value": "K", "suit": "Spades"},
    {"value": "A", "suit": "Hearts"},
    {"value": "2", "suit": "Hearts"},
    {"value": "3", "suit": "Hearts"},
    {"value": "4", "suit": "Hearts"},
    {"value": "5", "suit": "Hearts"},
    {"value": "6", "suit": "Hearts"},
    {"value": "7", "suit": "Hearts"},
    {"value": "8", "suit": "Hearts"},
    {"value": "9", "suit": "Hearts"},
    {"value": "10", "suit": "Hearts"},
    {"value": "J", "suit": "Hearts"},
    {"value": "Q", "suit": "Hearts"},
    {"value": "K", "suit": "Hearts"},
    {"value": "A", "suit": "Clubs"},
    {"value": "2", "suit": "Clubs"},
    {"value": "3", "suit": "Clubs"},
    {"value": "4", "suit": "Clubs"},
    {"value": "5", "suit": "Clubs"},
    {"value": "6", "suit": "Clubs"},
    {"value": "7", "suit": "Clubs"},
    {"value": "8", "suit": "Clubs"},
    {"value": "9", "suit": "Clubs"},
    {"value": "10", "suit": "Clubs"},
    {"value": "J", "suit": "Clubs"},
    {"value": "Q", "suit": "Clubs"},
    {"value": "K", "suit": "Clubs"},
    {"value": "A", "suit": "Diamonds"},
    {"value": "2", "suit": "Diamonds"},
    {"value": "3", "suit": "Diamonds"},
    {"value": "4", "suit": "Diamonds"},
    {"value": "5", "suit": "Diamonds"},
    {"value": "6", "suit": "Diamonds"},
    {"value": "7", "suit": "Diamonds"},
    {"value": "8", "suit": "Diamonds"},
    {"value": "9", "suit": "Diamonds"},
    {"value": "10", "suit": "Diamonds"},
    {"value": "J", "suit": "Diamonds"},
    {"value": "Q", "suit": "Diamonds"},
    {"value": "K", "suit": "Diamonds"},
    {"value": "Joker", "suit": "Joker"}
  ];
  List _cardListIndex = [];
  int? _finishCardIndex;
  List<int> _newIndexData = [];
  List<int> _newIndexSortData = [];
  int _isDropOneCard = 0;
  int _isDropTwoCard = 0;
  int _isDropThreeCard = 0;
  bool _isNoDropCard = false;
  List<Map<String, dynamic>> _listOfMap = [];
  int _isDropFourCard = 0;
  int _isDropFiveCard = 0;
  int _isDropSixCard = 0;
  int _isDropSevenCard = 0;
  int _isDropEightCard = 0;
  int _isDropNineCard = 0;
  int _isDropTenCard = 0;
  int _isDropElevenCard = 0;
  int _isDropTwelveCard = 0;
  int? _dropCardIndex;
  int _isDropThirteenCard = 0;
  List _acceptCardListIndex = [];
  int _setCardUpIndex = -1;
  List<bool> _cardUp = [];
  bool _isSortCard = false;
  bool _isOneAcceptCard = false;
  List _sortList = [];
  List _isAcceptCardList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0];
  final List _isAcceptSortCardList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<List> _isSortData = [];
  bool _isFilpCard = true;
  bool _isSortTrueFalse = false;
  List _newHandData = [];
  List _setSequencesResponse = [];
  PlayerWinnerModel _playerWinnerModel = PlayerWinnerModel();
  List<List<int>> _playerWinnerCardList = [];
  dynamic _dataResponse;
  bool _isCheckSqu = false;
  final List<String> _rummyCardList = [
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
  int _totalDownCard = 0;
  List<dynamic> _checkSetSequence = [];
  List<dynamic> _reArrangeData = [];


  // New Sort


  bool _isNewSortTrueFalseNew = false;

  List<List<Map<String,dynamic>>> _newSortListData =[];

  bool get isNewSortTrueFalseNew => _isNewSortTrueFalseNew;

  List<List<Map<String,dynamic>>> get newSortListData => _newSortListData;
  List get data2List => _data2List;


  // Sort & Group Data Event


  List<int> _newSortListGroupData = [];
  bool _noSortGroupFalse = false;

  List<int> _noSortListGroupData = [];
  List<int> _noNewSortListGroupData = [];
  List<int> _GroupData = [];

  List<int> get newSortListGroupData => _newSortListGroupData;
  List<int> get GroupData => _GroupData;

  List<List<int>>  _newListGroupData = [];

  List<List<int>> get newListGroupData => _newListGroupData;



  bool get isSortTrueFalse => _isSortTrueFalse;

  bool get noSortGroupFalse => _noSortGroupFalse;

  int get isDropOneCard => _isDropOneCard;

  int get isDropTwoCard => _isDropTwoCard;

  int get isDropThreeCard => _isDropThreeCard;

  int get isDropFourCard => _isDropFourCard;

  List get sortList => _sortList;

  dynamic get dataResponse => _dataResponse;

  PlayerWinnerModel get playerWinnerModel => _playerWinnerModel;

  List<List> get isSortData => _isSortData;

  List<int> get newSort => _newSort;

  int get isDropFiveCard => _isDropFiveCard;

  int get isDropSixCard => _isDropSixCard;

  int get isDropSevenCard => _isDropSevenCard;

  int get isDropEightCard => _isDropEightCard;

  int get isDropNineCard => _isDropNineCard;

  int get isDropTenCard => _isDropTenCard;

  int get setCardUpIndex => _setCardUpIndex;

  int get isDropElevenCard => _isDropElevenCard;

  int get isDropTwelveCard => _isDropTwelveCard;

  int get isDropThirteenCard => _isDropThirteenCard;

  List get acceptCardListIndex => _acceptCardListIndex;

  int? get dropCardIndex => _dropCardIndex;

  List<Map<String, dynamic>> get listOfMap => _listOfMap;

  List get newHandData => _newHandData;

  List get cardUp => _cardUp;

  bool get isSortCard => _isSortCard;

  bool get isFilpCard => _isFilpCard;

  bool get isCheckSqu => _isCheckSqu;

  List<List> get playerWinnerCardList => _playerWinnerCardList;

  bool get isNoDropCard => _isNoDropCard;

  bool get isMyTurn => _isMyTurn;

  bool get isOneAcceptCard => _isOneAcceptCard;

  List get isAcceptCardList => _isAcceptCardList;

  List get isAcceptSortCardList => _isAcceptSortCardList;

  List<Map<String, dynamic>> get cardList => _cardList;

  int get totalDownCard => _totalDownCard;

  List<dynamic> get checkSetSequence => _checkSetSequence;

  List<String> get rummyCardList => _rummyCardList;

  List get reArrangeData => _reArrangeData;

  List get setSequencesResponse => _setSequencesResponse;

  List<int> get cardNumberList => _cardNumberList;

  List<int> get newIndexData => _newIndexData;

  List<int> get newIndexSortData => _newIndexSortData;

  int? get finishCardIndex => _finishCardIndex;

  int get stopCountDown => _stopCountDown;

  int get playerCount => _playerCount;

  int get countDown => _countDown;

  int get secondsRemaining => _secondsRemaining;

  List get cardListIndex => _cardListIndex;
  List<int> get noSortListGroupData => _noSortListGroupData;
  List<int> get noNewSortListGroupData => _noNewSortListGroupData;

  void createGame(String gameID, BuildContext context) async {
    Sockets.socket.emit("game", gameID);
    Sockets.socket.on("game", (data) {
      print('Socket In Game Event Completed ***** game *****  $data');
    });
  }

  void drawCard(BuildContext context) async {
    Sockets.socket.emit("draw", "up");
    Sockets.socket.on("draw", (data) {
      print('Socket In Draw Event Completed ***** draw *****  $data');
    });
  }

  void upCard(BuildContext context) async {
    Sockets.socket.on("up", (data) {
      print('Socket In Up Event Completed ***** up *****  $data');
      print('Socket In Up Event Completed ***** up   ${_newSortListGroupData}');

    if(data != null){
      String value = data['value'];
      String suit = data['suit'];

      print('gtagatga  ;-  ${value} ... $suit');
      for (int i = 0; i < _cardList.length; i++) {
        if (_cardList[i]['value'] == value) {
          if (_cardList[i]['suit'] == suit) {
            Future.delayed(const Duration(seconds: 6), () {
              setCardListIndex(i + 1);
            });
          }
        }

        if (_cardList[_finishCardIndex ?? 0]['value'] == value) {
          setFinishCardNull();
        }
      }
    }
    });
  }

  void downCard(BuildContext context) async {
    Sockets.socket.on("down", (data) {
      print('Socket In Down Event Completed ***** down *****  $data');
      setTotalDownCard(data);
    });
  }

  void handCard(BuildContext context) async {
    Sockets.socket.on("hand", (data) {
      print('Socket In Hand Event Completed ***** hand *****  $data');
      _newSortListGroupData =[];
      _data2List = data;
      _newIndexData =[];
      if(data.length == 1){
        for(int i = 0;i< data.length;i++){
          for(int j = 0;j<data[i].length;j++){
            Map<String, dynamic> singleCard = data[i][j];
            String singleCardValue = singleCard["value"];
            String singleCardSuit = singleCard["suit"];
            for (int k = 0; k < _cardList.length; k++) {
              Map<String, dynamic> sCard = _cardList[k];
              String sCardValue = sCard["value"];
              String sCardSuit = sCard["suit"];
              if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
                _newSortListGroupData.add(k+1);
                _noSortListGroupData.add(k+1);
                setNewData(k+1);
                // print('New Hand Data aa :-  ${data2List[i][j]} ..... ${k+1}');
              }
            }
          }

          if(_data2List.length == 1){
            _newSortListGroupData.insert(3, 100);
            _newSortListGroupData.insert(7, 100);
            _newSortListGroupData.insert(11, 100);
          }


        }
      }
      else{

        for(int i = 0;i<data.length ;i++){

          for(int j = 0;j < _data2List[i].length;j++){
            Map<String, dynamic> singleCard = _data2List[i][j];
            String singleCardValue = singleCard["value"];
            String singleCardSuit = singleCard["suit"];
            for (int k = 0; k < _cardList.length; k++) {
              Map<String, dynamic> sCard = _cardList[k];
              String sCardValue = sCard["value"];
              String sCardSuit = sCard["suit"];
              if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
                setNewData(k+1);
                _newSortListGroupData.add(k+1);
                _noSortListGroupData.add(k+1);
                // print('New Hand Data aa :-  ${data2List[i][j]} ..... ${k+1}');
              }
            }

          }
          _newSortListGroupData.add(100);


        }

        _newSortListGroupData.removeLast();

      }
      _noNewSortListGroupData.clear();
      for(int i = 0;i< _newSortListGroupData.length;i++){
        _noNewSortListGroupData.add(_newSortListGroupData[i]);
      }

      notifyListeners();


    });
  }

  void turnTime(BuildContext context) async {
    Sockets.socket.on("turn", (data) {
      print('Socket In Turn Event Completed ***** turn *****  $data');

      if (data['timeOut'] != null) {
        if (data['timeOut'] == 0) {
          closeTimer();
          initTimer();
          setMyTurn(false);
        } else {
          setMyTurn(true);
          closeTimer();
          initTimer();
          startTimer(context);
        }
      }
    });
  }

  void countDownEvent(BuildContext context) async {
    Sockets.socket.on("count down", (data) {
      print("**** COUNT DOWN **** $data");
      setCountDown(data);

      if (data == 0) {
        if (_playerCount == 1) {
          Sockets.socket.disconnect();
          Navigator.pop(context);
        }
      }
    });
  }

  void setNoSortGroupFalse(bool value) async {
    _noSortGroupFalse = value;
    notifyListeners();
  }

  void gameOver(BuildContext context, String gameID,) async {
    Sockets.socket.on("game over", (data) {
      print("**** Game Over **** $data");
      /*WinnerDialog(
        title: 'You are Winner',
        message: data['message'],
        leftButton: 'Cancel',
        rightButton: 'Exit',
        controller: controller,
        onTapLeftButton: () {
          Navigator.pop(context);
        },
        onTapRightButton: () {

        },
      ).show(context);*/
      setPlayerWinnerCard(gameID).whenComplete(() {
        CardPlayerWinner(
                title: 'Quit Game',
                message: "Quiting On Going Game In The Middle Results",
                leftButton: 'Cancel',
                rightButton: 'Exit',
                onTapLeftButton: () {
                  Navigator.pop(context);
                },
                onTapRightButton: () {},
                gameId: gameID)
            .show(context);
      });
    });
  }

  void roomMessage(BuildContext context) async {
    Sockets.socket.on("room message", (data) {
      print("**** ROOM MESSAGE **** $data");

      // var rummyProvider = Provider.of<RummyProvider>(context,listen: false);
      // rummyProvider.setPlayerCount(data['playerCount']);

      setPlayerCount(data['playerCount']);
    });
  }

  void turnMessage(BuildContext context, String userId) async {
    Sockets.socket.on("turn message", (data) {
      print("**** TURN MESSAGE **** $data");
      // var rummyProvider = Provider.of<RummyProvider>(context,listen: false);

      if (data['userId'] == userId) {
      } else {
        setMyTurn(false);
      }
    });
  }

  void onlyMessage(BuildContext context) async {
    Sockets.socket.on("message", (data) {
      print("**** MESSAGE **** $data");
    });
  }

  setRemoveIndex(int index) {
    _cardNumberList.removeAt(index);
    notifyListeners();
  }

  setNewIndex(int index, int value) {
    _cardNumberList.insert(index, value);
    notifyListeners();
  }

  disconnectSocket(BuildContext context) {
    Sockets.socket.disconnect();
    Navigator.pop(context);
  }

  setCountDown(int count) {
    _countDown = count;
    notifyListeners();

    if (count == 0) {
      _stopCountDown = 0;
      notifyListeners();
    }
  }

  setStopCountDown(int value) {
    _stopCountDown = value;
  }

  setPlayerCount(int value) {
    _playerCount = value;
    print('Rummy Provider Count Data :-   ${_playerCount}');
    notifyListeners();
  }

  setMyTurn(bool value) {
    _isMyTurn = value;
    notifyListeners();
  }

  closeTimer() {
    _timer?.cancel();
    notifyListeners();
  }

  void initTimer() {
    _secondsRemaining = 30;
    notifyListeners();
  }

  startTimer(BuildContext context, {int secondsRemaining = 30}) {
    _secondsRemaining = secondsRemaining;
    notifyListeners();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_secondsRemaining != 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        initTimer();
        setMyTurn(false);
        closeTimer();
        notifyListeners();
      }
    });
  }

  setCardListIndex(int value) {
    _cardListIndex.add(value);
    notifyListeners();
  }

  setFinishCardNull() {
    int? data;
    _finishCardIndex = data;
    notifyListeners();
  }

  void setFinishCardIndex(int value) {
    _finishCardIndex = value;
    notifyListeners();
  }

  setNewRemoveData() {
    _newIndexData.clear();
    notifyListeners();
  }

  setNewRemoveHandData() {
    _newSort.clear();
    notifyListeners();
  }

  void setOldCardRemove(int index) {
    _newIndexData.removeAt(index);
    notifyListeners();
  }

  void setOldCardSortRemove(int index) {
    print('New Sort Remore   :-  $_newSortListGroupData');
    _newSortListGroupData.removeAt(index);
    print('New Sort Remore   :-  $_newSortListGroupData');
    notifyListeners();
  }

  void setOldSortCardRemove(int index) {
    print('datadatad   "-n     ${_newSortListGroupData}');
    _newSortListGroupData.removeAt(index);
    notifyListeners();
  }

  void setNewDataSortCardRemove(int index) {
    print('datadatad   "-n     $_noNewSortListGroupData');
    _noNewSortListGroupData.removeAt(index);
    notifyListeners();
  }

  void setSortData(){
    _GroupData.clear();
    _GroupData = _newSortListGroupData;
    notifyListeners();
  }

  void setOldCardHandRemove(int index) {
    _newSort.removeAt(index);
    notifyListeners();
  }

  setNewData(int value) {
    _newIndexData.add(value);
    notifyListeners();
  }

  setNewSortData(int value) {
    _newIndexSortData.add(value);
    notifyListeners();
  }

  setNewHandData(int value) {
    _newSort.add(value);
    notifyListeners();
  }

  setNewRemoveIndex(int index) {
    _newIndexData.removeAt(index);
    print('Rummy Provider Data :-   ${_newIndexData.length}');
    notifyListeners();
  }

  void sortTrueFalse() {
    _isSortTrueFalse = !_isSortTrueFalse;
    notifyListeners();
  }

  void isCheckSquFalse(bool value) {
    _isCheckSqu = value;
    notifyListeners();
  }

  void isSortGroup(List data) {
    int chunkSize = 3;
    _isSortData.clear();
    for (var i = 0; i < data.length; i += chunkSize) {
      _isSortData.add(data.sublist(
          i, i + chunkSize > data.length ? data.length : i + chunkSize));
    }

    print('New Sort Grop Data :-  ${_isSortData}');
  }

  void dropCard(int data) async {
    Sockets.socket.emit("drop", data);
    print("*** DROP EMIT ***  $data");
  }

  void finishCard(int data) async {
    print('Finish Card :-   ${data} ');
    Sockets.socket.emit("finish", data);
    print("*** Finish EMIT ***");
  }

  setNoDropCard(bool value) {
    _isNoDropCard = value;
    notifyListeners();
  }

  Future setPlayerWinnerCard(String id) async {
    print('id ;-      $id');
    Uri url = Uri.parse('http://3.111.148.154:3000/rakesh/games/$id');
    _playerWinnerCardList.clear();
    var response = await http.get(url);
    final dataFinalResponse = jsonDecode(response.body);
    _dataResponse = dataFinalResponse;
    notifyListeners();
    // _playerWinnerModel = PlayerWinnerModel.fromJson(dataResponse);

    for (int i = 0; i < _dataResponse['game']['game']['players'].length; i++) {
      List<int> newCardData = [];
      for (int j = 0;
          j < _dataResponse['game']['game']['players'][i]['hand'].length;
          j++) {
        Map<String, dynamic> singleCard =
            _dataResponse['game']['game']['players'][i]['hand'][j];

        String singleCardValue = singleCard["value"];
        String singleCardSuit = singleCard["suit"];
        for (int k = 0; k < _cardList.length; k++) {
          Map<String, dynamic> sCard = cardList[k];
          String sCardValue = sCard["value"];
          String sCardSuit = sCard["suit"];
          if (singleCardValue == sCardValue && singleCardSuit == sCardSuit) {
            newCardData.add(k + 1);
          }
        }
      }
      _playerWinnerCardList.add(newCardData);
    }
    print('response ${_playerWinnerCardList}');
  }

  setRomoveAndIndexData(int newIndex, int oldIndex) {
    final itemCard = _newIndexData.removeAt(oldIndex);
    if (oldIndex < newIndex) {
      _newIndexData.insert(newIndex - 1, itemCard);
    } else {
      _newIndexData.insert(newIndex, itemCard);
    }

    _reArrangeData.clear();
    _listOfMap.clear();

    for (int i = 0; i < _newIndexData.length; i++) {
      for (int j = 0; j < _cardList.length; j++) {
        if (_newIndexData[i] == j) {
          Map<String, dynamic> singleData = _cardList[j - 1];
          _reArrangeData.add(_cardList[j - 1]);
          _listOfMap.add(singleData);
        }
      }
    }

    //checkSetSequenceData(_reArrangeData);
    rearrangeData(_listOfMap);
    // sortDataEvent(_listOfMap);
    notifyListeners();
  }

  newSetData() {
    _listOfMap.clear();

    for (int i = 0; i < _newIndexData.length; i++) {
      for (int j = 0; j < _cardList.length; j++) {
        if (_newIndexData[i] == j) {
          Map<String, dynamic> singleData = _cardList[j - 1];
          _reArrangeData.add(_cardList[j - 1]);
          _listOfMap.add(singleData);
        }
      }
    }

    notifyListeners();
    print('New Sort Data :-    $_listOfMap');
  }

  // newSetSortGroupData() {
  //   _newSort.insert(3, 100);
  //   _newSort.insert(7, 100);
  //   _newSort.insert(11, 100);
  //
  //   notifyListeners();
  // }

  checkSetSequenceData(List<dynamic> checkData) async {
    _setSequencesResponse.clear();

    print("^^^^ check set sequences ^^^^ $checkData");
    Sockets.socket.emit("check set sequences", {checkData});
    Sockets.socket.on("check set sequences", (data) {
      print("^^^^ check set sequences Data ^^^^ $data");
      _setSequencesResponse = data;
      notifyListeners();
    });
  }

  void rearrangeData(List<dynamic> rearrange) async {
    Sockets.socket.emit("re arrange", {rearrange});
    print("*** RE-ARRANGE ***");
  }

  void sortDataEvent(List<dynamic> sortData) async {
    Sockets.socket.emit("sort", {sortData});
    //newSetData();
    print("*** SortData ***  £££££££  emit");
  }

  setFilpCard(bool value) {
    _isFilpCard = value;
    notifyListeners();
  }

  setOneAcceptCardList(int value, int index) {

   if(_isNewSortTrueFalseNew == true){
     _isAcceptSortCardList[index] = value;
   }else if(_noSortGroupFalse == true){
     _isAcceptSortCardList[index] = value;
   }else{
     _isAcceptCardList[index] = value;
   }

   print(
       'Accet     dataa    :-   $value ....  $index ....  $_isAcceptCardList .... ${_isAcceptCardList.length}');
    notifyListeners();
  }



  setOneAcceptHandCardList(int value, int index) {
    print(
        'Accet     dataa    :-   $value ....  $index ....  $_isAcceptCardList .... ${_isAcceptCardList.length}');
    _isAcceptSortCardList[index] = value;
    notifyListeners();
  }

  setCardUpFalse() {
    for (int i = 0; i < 18; i++) {
      _cardUp.add(false);
    }
  }

  setCardUpTrue(int index, BuildContext context) {
    /* for(int i =0;i<_cardUp.length;i++){
      if(i != index){
        if(_cardUp[i] == true){
          _cardUp[i] = !_cardUp[i];
        }
      }
    }*/
    _cardUp[index] = !_cardUp[index];
    if (_cardUp[index] == true) {
      _sortList.add(index);
    } else {
      if (_sortList.isNotEmpty) {
        for (int i = 0; i < _sortList.length; i++) {
          if (_sortList[i] == index) {
            _sortList.removeAt(i);
          }
        }
      }
    }

    print('isMy True Data :- ${_newSortListGroupData.length} .... ${_newSortListGroupData} .... $_cardUp ..... $index');

    _setCardUpIndex = index;

    notifyListeners();
    /*if(_isMyTurn){
      if(_newIndexData.length == 11){

      }
      else{
        showToast("Pick Up a Card".toUpperCase(),
          context: context,
          animation: StyledToastAnimation.slideFromTop,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.top,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
          backgroundColor: Colors.red.withOpacity(0.8),
          reverseCurve: Curves.linear,
        );
      }
    }
    else{
      showToast("It's not your turn,please wait for your Turn".toUpperCase(),
        context: context,
        animation: StyledToastAnimation.slideFromTop,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.top,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
        backgroundColor: Colors.red.withOpacity(0.8),
        reverseCurve: Curves.linear,
      );
    }*/
  }


  setTotalDownCard(int value) {
    _totalDownCard = value;
    notifyListeners();
  }

  void resetAllData() {
    _isDropOneCard = 0;
    _isDropTwoCard = 0;
    _isDropThreeCard = 0;
    _isNoDropCard = false;
    _listOfMap = [];
    _isDropFourCard = 0;
    _isDropFiveCard = 0;
    _isDropSixCard = 0;
    _isDropSevenCard = 0;
    _isDropEightCard = 0;
    _isDropNineCard = 0;
    _isDropTenCard = 0;
    _isDropElevenCard = 0;
    _isDropTwelveCard = 0;
    _dropCardIndex;
    _isDropThirteenCard = 0;
    _acceptCardListIndex = [];
    _setCardUpIndex = -1;
    _cardUp = [];
    _isSortCard = false;
    _isOneAcceptCard = false;
    _sortList = [];
    _isAcceptCardList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    _isSortData = [];
    _newIndexData = [];
    _isFilpCard = true;
    _isMyTurn = false;
    _isSortTrueFalse = false;
    _newHandData = [];
    _setSequencesResponse = [];
    _playerWinnerModel = PlayerWinnerModel();
    _playerWinnerCardList = [];
    _dataResponse;
    _totalDownCard = 0;
    _checkSetSequence = [];
    _reArrangeData = [];
  }

  // New Sort Data ....

  void setNewSortTrueFalse(bool value) {
     _isNewSortTrueFalseNew = value;
     Future.delayed(Duration(seconds: 2),(){
       checkSortData();
     });
    notifyListeners();
  }

  setRemoveAndIndexNewSortData(int newIndex, int oldIndex) {
    final itemCard = _newSortListGroupData.removeAt(oldIndex);
    if (oldIndex < newIndex) {
      _newSortListGroupData.insert(newIndex - 1, itemCard);
    } else {
      _newSortListGroupData.insert(newIndex, itemCard);
    }
    print('data a a a a New List  L:- ${_newSortListGroupData}');

    /*for(int i = 0;i< _newSortListGroupData.length;i++){

      if(_newSortListGroupData[i] == 100){
        if(_newSortListGroupData[i +1] == 100){
          print('gataagagg  :-  ${_newSortListGroupData[i]} ---- $i');
          _newSortListGroupData.removeAt(i +1);
          notifyListeners();
        }
      }
    }*/

    print('data a a a a New List  L:- 2${_newSortListGroupData}');

    notifyListeners();
    checkSortData();
    arrangeSortData();

    // _reArrangeData.clear();
    // _listOfMap.clear();
    //
    // for (int i = 0; i < _newIndexData.length; i++) {
    //   for (int j = 0; j < _cardList.length; j++) {
    //     if (_newIndexData[i] == j) {
    //       Map<String, dynamic> singleData = _cardList[j - 1];
    //       _reArrangeData.add(_cardList[j - 1]);
    //       _listOfMap.add(singleData);
    //     }
    //   }
    // }
    //
    // //checkSetSequenceData(_reArrangeData);
    // rearrangeData(_listOfMap);
    // // sortDataEvent(_listOfMap);
    // notifyListeners();
  }

  setNewGroupData() {
    print(' dadadadadadadadd  kkkkkk  :-  ${_noSortGroupFalse}');
   if(_noSortGroupFalse == true){


     List<int> dataValue = [];
     List<int> dataIndex = [];
     List<int> finalListData = [];

     if(isTrueData == false){
       for(int i = 0;i< _noSortListGroupData.length;i++){
         finalListData.add(_noSortListGroupData[i]);
       }

       _noSortListGroupData.clear();

       _noSortListGroupData = finalListData.toSet().toList();

       isTrueData = true;
     }




     print('datadatad  final  :-  ${finalListData} ..... $_noSortListGroupData');

     int loopValue = 0;
     for (int i = 0; i < _cardUp.length; i++) {
       if (_cardUp[i] == true) {
         dataIndex.add(i);
       }
     }

     for (int i = 0; i < dataIndex.length; i++) {
       dataValue.add(_noSortListGroupData[dataIndex[i]]);
       notifyListeners();
     }

     _sortList.clear();

     for (int i = 0; i < _cardUp.length; i++) {
       _cardUp[i] = false;
       notifyListeners();
     }




     for (int i = 0; i < dataValue.length; i++) {
       _noSortListGroupData.remove(dataValue[i]);
     }


     _noSortListGroupData.add(100);



     for (int i = 0; i < dataValue.length; i++) {
       _noSortListGroupData.add(dataValue[i]);
     }

     _noNewSortListGroupData = _noSortListGroupData;

     notifyListeners();


     for (int i = 0; i < _noSortListGroupData.length; i++) {
       if (_noSortListGroupData[i] == 100) {
         if (_noSortListGroupData[i + 1] == 100) {

           _noSortListGroupData.removeAt(i + 1);
           notifyListeners();
         }
       }
     }
     List<int> data = [0];

     for (int i = loopValue; i < _noSortListGroupData.length; i++) {
       if (_noSortListGroupData[i] == 100) {
         data.add(i);
         notifyListeners();
       }
     }

     List<int> dataGroup = [];
     _newListGroupData =[];


     notifyListeners();


     for(int i = 0;i< data.length;i++){

       for(int j = data[i];j<_noSortListGroupData.length;j++){
         dataGroup.add(_noSortListGroupData[j]);
         if(_noSortListGroupData[j] == 100){
           _newListGroupData.add(dataGroup);
           dataGroup = [];
         }
       }
     }

     print('datadatad  final  :-  ${_newListGroupData}');

     for(int i = 0;i<_newListGroupData.length;i++){

       _newListGroupData[i].remove(100);
     }



     List<List<int>>  dataListGroup =[];

     for(int i = 0;i< data.length;i++){
       dataListGroup.add(_newListGroupData[i]);
     }
     List<List<Map<String,dynamic>>> finalData=[];

     for(int i = 0;i< dataListGroup.length;i++){
       List<Map<String,dynamic>> dddd = [];
       for(int j = 0;j < dataListGroup[i].length;j++){

         for (int k = 0; k <= _cardList.length; k++) {
           if (dataListGroup[i][j] == k) {
             Map<String, dynamic> singleData = _cardList[k - 1];
             dddd.add(singleData);
           }
         }
         finalData.add(dddd);
       }
     }



     Set<List<Map<String,dynamic>>>   finalddd = finalData.cast<List<Map<String, dynamic>>>().toSet();

     List<List<Map<String,dynamic>>> finalkk = [];

     finalddd.forEach((element) {
       finalkk.add(element);
     });

     print('datadatad  final kk :-  ${finalkk}');

     rearrangeData(finalkk);
     checkSetSequenceData(finalkk);

     _data2List = finalkk;
     _newSortListData= finalkk;


     notifyListeners();


   }
   else{
     List<int> dataValue = [];
     List<int> dataIndex = [];
     int loopValue = 0;
     print('New Group Data :-   List  ${_newSortListGroupData} }');
     for (int i = 0; i < _cardUp.length; i++) {
       if (_cardUp[i] == true) {
         dataIndex.add(i);
       }
     }

     for (int i = 0; i < dataIndex.length; i++) {
       print(
           'itttttttt   ${_newSortListGroupData[dataIndex[i]]}.... ${dataIndex[i]}');
       dataValue.add(_newSortListGroupData[dataIndex[i]]);
       notifyListeners();
     }

     _sortList.clear();

     for (int i = 0; i < _cardUp.length; i++) {
       _cardUp[i] = false;
       notifyListeners();
     }


     print(
         'New Group Data :-   ${dataValue}   ....  ${dataIndex}   ..... ${_newSortListGroupData}');
     for (int i = 0; i < dataValue.length; i++) {
       _newSortListGroupData.remove(dataValue[i]);
     }

     _newSortListGroupData.add(100);

     for (int i = 0; i < dataValue.length; i++) {
       _newSortListGroupData.add(dataValue[i]);
     }

     for (int i = 0; i < _newSortListGroupData.length; i++) {
       if (_newSortListGroupData[i] == 100) {
         if (_newSortListGroupData[i + 1] == 100) {
           print('gataagagg  :-  ${_newSortListGroupData[i]} ---- $i');
           _newSortListGroupData.removeAt(i + 1);
           notifyListeners();
         }
       }
     }
     List<int> data = [0];

     for (int i = loopValue; i < _newSortListGroupData.length; i++) {
       if (_newSortListGroupData[i] == 100) {
         data.add(i);
         notifyListeners();
       }
     }

     List<int> dataGroup = [];
     _newListGroupData =[];


     notifyListeners();


     for(int i = 0;i< data.length;i++){

       for(int j = data[i];j<_newSortListGroupData.length;j++){
         dataGroup.add(_newSortListGroupData[j]);
         if(_newSortListGroupData[j] == 100){
           _newListGroupData.add(dataGroup);
           dataGroup = [];
         }
       }
     }


     for(int i = 0;i<_newListGroupData.length;i++){

       _newListGroupData[i].remove(100);
     }

     List<List<int>>  dataListGroup =[];

     for(int i = 0;i< data.length;i++){
       dataListGroup.add(_newListGroupData[i]);
     }
     List<List<Map<String,dynamic>>> finalData=[];

     for(int i = 0;i< dataListGroup.length;i++){
       List<Map<String,dynamic>> dddd = [];
       for(int j = 0;j < dataListGroup[i].length;j++){
         for (int k = 0; k <= _cardList.length; k++) {
           if (dataListGroup[i][j] == k) {
             Map<String, dynamic> singleData = _cardList[k - 1];
             dddd.add(singleData);
           }
         }
         finalData.add(dddd);
       }
     }



     Set<List<Map<String,dynamic>>>   finalddd = finalData.cast<List<Map<String, dynamic>>>().toSet();

     List<List<Map<String,dynamic>>> finalkk = [];

     finalddd.forEach((element) {
       finalkk.add(element);
     });

     print('Check Data a a kkkk:-  ${finalkk}');


     rearrangeData(finalkk);
     checkSetSequenceData(finalkk);
     checkSortData();




     _data2List = finalkk;
     _newSortListData= finalkk;

   }



  }

  checkSortData(){
    int loopValue = 0;
    List<int> data = [0];

    for (int i = loopValue; i < _newSortListGroupData.length; i++) {
      if (_newSortListGroupData[i] == 100) {
        data.add(i);
        notifyListeners();
      }
    }

    List<int> dataGroup = [];
    _newListGroupData =[];


    notifyListeners();


    for(int i = 0;i< data.length;i++){

      for(int j = data[i];j<_newSortListGroupData.length;j++){
        dataGroup.add(_newSortListGroupData[j]);
        if(_newSortListGroupData[j] == 100){
          _newListGroupData.add(dataGroup);
          dataGroup = [];
        }
      }
    }


    for(int i = 0;i<_newListGroupData.length;i++){

      _newListGroupData[i].remove(100);
    }

    List<List<int>>  dataListGroup =[];

    for(int i = 0;i< data.length;i++){
      dataListGroup.add(_newListGroupData[i]);
    }
    List<List<Map<String,dynamic>>> finalData=[];

    for(int i = 0;i< dataListGroup.length;i++){
      List<Map<String,dynamic>> dddd = [];
      for(int j = 0;j < dataListGroup[i].length;j++){

        for (int k = 0; k <= _cardList.length; k++) {
          if (dataListGroup[i][j] == k) {
            Map<String, dynamic> singleData = _cardList[k - 1];
            dddd.add(singleData);
          }
        }
        finalData.add(dddd);
      }
    }

    Set<List<Map<String,dynamic>>>   finalddd = finalData.cast<List<Map<String, dynamic>>>().toSet();

    List<List<Map<String,dynamic>>> finalkk = [];

    finalddd.forEach((element) {
      finalkk.add(element);
    });

    print('dadadadadadaaddadadadad  :- $finalkk');

    checkSetSequenceData(finalkk);
    _newSortListData= finalkk;

  }

  arrangeSortData(){
    int loopValue = 0;
    List<int> data = [0];

    for (int i = loopValue; i < _newSortListGroupData.length; i++) {
      if (_newSortListGroupData[i] == 100) {
        data.add(i);
        notifyListeners();
      }
    }

    List<int> dataGroup = [];
    _newListGroupData =[];


    notifyListeners();


    for(int i = 0;i< data.length;i++){

      for(int j = data[i];j<_newSortListGroupData.length;j++){
        dataGroup.add(_newSortListGroupData[j]);
        if(_newSortListGroupData[j] == 100){
          _newListGroupData.add(dataGroup);
          dataGroup = [];
        }
      }
    }


    for(int i = 0;i<_newListGroupData.length;i++){

      _newListGroupData[i].remove(100);
    }


    List<List<int>>  dataListGroup =[];

    for(int i = 0;i< data.length;i++){
      dataListGroup.add(_newListGroupData[i]);
    }
    List<List<Map<String,dynamic>>> finalData=[];

    for(int i = 0;i< dataListGroup.length;i++){
      List<Map<String,dynamic>> dddd = [];
      for(int j = 0;j < dataListGroup[i].length;j++){
        // print('nvbvgvb  :-  ${dataListGroup[i][j]}');

        for (int k = 0; k <= _cardList.length; k++) {
          if (dataListGroup[i][j] == k) {
            Map<String, dynamic> singleData = _cardList[k - 1];
            dddd.add(singleData);
          }
        }
        finalData.add(dddd);
      }
    }

    Set<List<Map<String,dynamic>>>   finalddd = finalData.cast<List<Map<String, dynamic>>>().toSet();

    List<List<Map<String,dynamic>>> finalkk = [];

    finalddd.forEach((element) {
      finalkk.add(element);
    });

    rearrangeData(finalkk);
    _newSortListData= finalkk;

    print('lllllllllllllł1lllļlll  :-  ${finalkk}');
  }
}
