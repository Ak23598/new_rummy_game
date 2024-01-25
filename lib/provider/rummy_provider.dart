import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rummy_game/model/player_winner_model.dart';
import '../utils/Sockets.dart';

class RummyProvider extends ChangeNotifier{
  int _isDropOneCard = 0;
  int _stopCountDown = 1;
  int _isDropTwoCard = 0;
  int _isDropThreeCard = 0;
  int _playerCount = 0;
  bool _isNoDropCard = false;
  List<Map<String,dynamic>> _listOfMap =[];
  int _isDropFourCard = 0;
  int _isDropFiveCard = 0;
  int _isDropSixCard = 0;
  int _countDown  = 20;
  int _isDropSevenCard = 0;
  int _isDropEightCard = 0;
  int _isDropNineCard = 0;
  int _isDropTenCard = 0;
  int _isDropElevenCard = 0;
  int _isDropTwelveCard = 0;
  int? _dropCardIndex;
  int _isDropThirteenCard = 0;
  List _cardListIndex = [];
  List _acceptCardListIndex = [];
  int _setCardUpIndex = -1;
  List<bool> _cardUp = [];
  bool _isSortCard = false;
  bool _isOneAcceptCard = false;
  List _sortList =[];
  List _isAcceptCardList = [0,0,0,0,0,0,0,0,0,0,0,0,0];
  List<List> _isSortData =[];
  List<int> _newIndexData = [];
  bool _isFilpCard= true;
  bool _isMyTurn= false;
  bool _isSortTrueFalse = false;
  final List<Map<String,dynamic>> _cardList = [
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
  List _newHandData = [];
  List _setSequencesResponse = [];
  PlayerWinnerModel _playerWinnerModel = PlayerWinnerModel();
  List<List<int>> _playerWinnerCardList =[];
  dynamic _dataResponse;
  int? _finishCardIndex;

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
  int _secondsRemaining = 30;
  Timer? _timer;
  Timer? _timerDown;
  int _totalDownCard = 0;
  int get playerCount => _playerCount;
  List<dynamic> _checkSetSequence = [];
  List<dynamic> _reArrangeData = [];
  bool get isSortTrueFalse => _isSortTrueFalse;
  int get countDown => _countDown;
  int get stopCountDown => _stopCountDown;
  int get isDropOneCard => _isDropOneCard;
  int get isDropTwoCard => _isDropTwoCard;
  int get isDropThreeCard => _isDropThreeCard;
  int get isDropFourCard => _isDropFourCard;
  int? get finishCardIndex => _finishCardIndex;
  List get sortList => _sortList;
  dynamic get dataResponse => _dataResponse;
  PlayerWinnerModel get playerWinnerModel => _playerWinnerModel;
  List<List> get isSortData => _isSortData;
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
  List get cardListIndex => _cardListIndex;
  List get acceptCardListIndex => _acceptCardListIndex;
  int? get dropCardIndex => _dropCardIndex;
  List<Map<String,dynamic>> get listOfMap => _listOfMap;
  List get newHandData => _newHandData;
  List get cardUp => _cardUp;
  bool get isSortCard => _isSortCard;
  bool get isFilpCard => _isFilpCard;
  List<List> get playerWinnerCardList => _playerWinnerCardList;
  bool get isNoDropCard => _isNoDropCard;
  bool get isMyTurn => _isMyTurn;
  bool get isOneAcceptCard => _isOneAcceptCard;
  List get isAcceptCardList => _isAcceptCardList;
  List<Map<String,dynamic>> get cardList => _cardList;
  int get secondsRemaining => _secondsRemaining;
  int get totalDownCard => _totalDownCard;
  List<dynamic> get checkSetSequence => _checkSetSequence;
  List<int> get newIndexData => _newIndexData;
  List<String> get rummyCardList => _rummyCardList;
  List get reArrangeData => _reArrangeData;
  List get setSequencesResponse => _setSequencesResponse;

  void sortTrueFalse(){
    _isSortTrueFalse = !_isSortTrueFalse;
    notifyListeners();
  }

  void setFinishCardIndex(int value){
    _finishCardIndex = value;
    notifyListeners();
  }

  void isSortGroup(List data){
    int chunkSize = 3;
    _isSortData.clear();
    for (var i = 0; i < data.length; i += chunkSize) {
      _isSortData.add(data.sublist(i,
          i + chunkSize > data.length ? data.length : i + chunkSize));
    }

    print('New Sort Grop Data :-  ${_isSortData}');
  }

  void setOldCardRemove(int index){
    _newIndexData.removeAt(index);
    notifyListeners();
  }

  void dropCard(int data) async {
    print('Drop Card :-   ${data} ');
    Sockets.socket.emit("drop",data);
    print("*** DROP EMIT ***");
  }

  void finishCard(int data) async {
    print('Finish Card :-   ${data} ');
    Sockets.socket.emit("finish",data);
    print("*** Finish EMIT ***");
  }

  setNewData(int value){
    _newIndexData.add(value);

  }

  setFinishCardNull(){
    int? data;
    _finishCardIndex = data;
    notifyListeners();

  }

  setNewRemoveData(){
    _newIndexData.clear();
    notifyListeners();
  }

  setPlayerCount(int value){
    _playerCount  = value;
    notifyListeners();
  }

  setNewRemoveIndex(int index){
    _newIndexData.removeAt(index);
    print('Rummy Provider Data :-   ${_newIndexData.length}');
    notifyListeners();
  }

  setNoDropCard(bool value){
    _isNoDropCard = value;
    notifyListeners();
  }

  Future setPlayerWinnerCard (String id) async {
    Uri url = Uri.parse('http://3.111.148.154:3000/rakesh/games/$id');
    _playerWinnerCardList.clear();
    var response = await http.get(url);
    final dataFinalResponse = jsonDecode(response.body);
    _dataResponse = dataFinalResponse;
    notifyListeners();
    // _playerWinnerModel = PlayerWinnerModel.fromJson(dataResponse);

    for(int i =0;i< _dataResponse['game']['game']['players'].length;i++){
      List<int> newCardData =[];
      for(int j = 0;j< _dataResponse['game']['game']['players'][i]['hand'].length;j++){
        Map<String,dynamic> singleCard = _dataResponse['game']['game']['players'][i]['hand'][j];

        String singleCardValue = singleCard["value"];
        String singleCardSuit = singleCard["suit"];
        for(int k = 0; k < _cardList.length; k++){
          Map<String,dynamic> sCard = cardList[k];
          String sCardValue = sCard["value"];
          String sCardSuit = sCard["suit"];
          if(singleCardValue == sCardValue && singleCardSuit == sCardSuit){
            newCardData.add(k + 1);
          }
        }
      }
      _playerWinnerCardList.add(newCardData);
    }
    print('response ${_playerWinnerCardList}');

  }

  setRomoveAndIndexData(int newIndex,int oldIndex){
    final itemCard = _newIndexData.removeAt(oldIndex);
    if(oldIndex<newIndex){
      _newIndexData.insert(newIndex-1, itemCard);
    }else{
      _newIndexData.insert(newIndex, itemCard);
    }

    _reArrangeData.clear();
    _listOfMap.clear();

    for(int i=0;i<_newIndexData.length;i++){

      for(int j=0;j < _cardList.length;j++){
        if(_newIndexData[i] == j){
          Map<String,dynamic> singleData = _cardList[j -1];
          _reArrangeData.add(_cardList[j -1]);
          _listOfMap.add(singleData);
        }
      }
    }

    //checkSetSequenceData(_reArrangeData);
    rearrangeData(_listOfMap);
    // sortDataEvent(_listOfMap);
    notifyListeners();
  }

  newSetData(){
    _listOfMap.clear();

    for(int i=0;i<_newIndexData.length;i++){

      for(int j=0;j < _cardList.length;j++){
        if(_newIndexData[i] == j){
          Map<String,dynamic> singleData = _cardList[j -1];
          _reArrangeData.add(_cardList[j -1]);
          _listOfMap.add(singleData);
        }
      }
    }
  }

  checkSetSequenceData(List<Map<String,dynamic>> checkData) async {
    _setSequencesResponse.clear();
    print("^^^^ check set sequences ^^^^ $checkData");
    Sockets.socket.emit("check set sequences",{checkData});
    Sockets.socket.on("check set sequences", (data) {
      print("^^^^ check set sequences Data ^^^^ $data");
      _setSequencesResponse = data;

        _setSequencesResponse.add("d");
      notifyListeners();

    });
  }

  void rearrangeData(List<dynamic> rearrange)async{
    Sockets.socket.emit("re arrange",{rearrange});
    print("*** RE-ARRANGE ***");
  }

  void sortDataEvent(List<dynamic> sortData)async{
    Sockets.socket.emit("sort",{sortData});
    newSetData();
    print("*** RE-ARRANGE ***");
  }

  void setSequenceData(List<dynamic> data){
    _checkSetSequence = data;
    print('New Data   :_   ${_checkSetSequence}');
    notifyListeners();
  }
  

  setFilpCard(bool value){
    _isFilpCard = value;
    notifyListeners();
  }
  

  setMyTurn(bool value){
    _isMyTurn = value;
    notifyListeners();
  }

  setOneAcceptCardList(int value,int index){
    _isAcceptCardList[index] = value;
    notifyListeners();
  }
  

  setCardListIndex(int value){
    _cardListIndex.add(value);
    notifyListeners();
  }

  setCardUpFalse(){
    for(int i = 0; i< 14;i++){
      _cardUp.add(false);
    }
  }

  setCardUpTrue(int index,BuildContext context){



   /* for(int i =0;i<_cardUp.length;i++){
      if(i != index){
        if(_cardUp[i] == true){
          _cardUp[i] = !_cardUp[i];
        }
      }
    }*/
    _cardUp[index] = !_cardUp[index];
    if(_cardUp[index] == true){
      _sortList.add(index);
    }else{
      if(_sortList.isNotEmpty){
        for(int i = 0;i<_sortList.length;i++){
          if(_sortList[i] == index){
            _sortList.removeAt(i);
          }
        }
      }
    }

    print('isMy True Data :- ${_sortList}');
    _dropCardIndex = newIndexData[index];
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

  setSortAllCard(){
    _isSortCard = !_isSortCard;
    notifyListeners();
  }

  setCountDown(int count){
    _countDown = count;
    notifyListeners();

    if(count == 0){
      _stopCountDown = 0;
      notifyListeners();
    }
  }

  startTimer(BuildContext context,{int secondsRemaining=30}) {
    _secondsRemaining=secondsRemaining;
    notifyListeners();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_secondsRemaining != 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        initTimer();
        Provider.of<RummyProvider>(context,listen: false).setMyTurn(false);
        closeTimer();
        notifyListeners();
      }
    });
  }

  setTotalDownCard(int value){
    _totalDownCard=value;
    notifyListeners();
  }

  closeTimer(){
    _timer?.cancel();
  }

  void initTimer(){
    _secondsRemaining = 30;
    notifyListeners();
  }


}