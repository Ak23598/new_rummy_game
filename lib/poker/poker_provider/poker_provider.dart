import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rummy_game/poker/Sockets/poker_sockets.dart';

class PokerProvider extends ChangeNotifier{

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
  bool _chipSliderTrueFalse= false;
  List<int> _newHandCard =[];
  double _callBet = 0;
  String _totalBetChips = '';

  List<String> get pokerCardList => _pokerCardList;
  bool get chipSliderTrueFalse => _chipSliderTrueFalse;
  List<Map<String,dynamic>> get oldCardList => _oldCardList;
  List<int> get newHandCard => _newHandCard;
  double get callBet => _callBet;
  String get totalBetChips => _totalBetChips;


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
      print('New Data a a a  a a a ;-  $_newHandCard :_    $newCardData');
    });


  }

  setNewRemoveData() {
    _newHandCard.clear();
    notifyListeners();
  }

  void blindNameEvent(BuildContext context) async {
    PokerSockets.socket.on("blindName", (data) {
      if (kDebugMode) {
        print('Poker Socket In Blind Name Event Completed $data');
      }
    });
  }



  void displayPlayerOptionsEvent(BuildContext context) async {
    PokerSockets.socket.on("displayPlayerOptions", (data) {
      if (kDebugMode) {
        print('Poker Socket In Display Player Options Event Completed $data');
        print('Poker Socket In Display Player Options Event Completed ${data['betChips']}');
      }

      if(data != null){
        if(data['callChips'] != null) {
          _callBet = data['callChips'];
        }
        if(data['betChips'] != null) {
          _totalBetChips = data['betChips'].toString();
        }

        print('Game Data a a a a a :-  ${_callBet}    .....  ${_totalBetChips}');

        notifyListeners();
      }
    });
  }

  void flopCardsEvent(BuildContext context) async {
    PokerSockets.socket.on("flopCards", (data) {
      if (kDebugMode) {
        print('Poker Socket In Flop Cards Event Completed $data');
      }
    });
  }

  void turnCardsEvent(BuildContext context) async {
    PokerSockets.socket.on("turnCards", (data) {
      if (kDebugMode) {
        print('Poker Socket In Turn Cards Event Completed $data');
      }
    });
  }

  void riverCardsEvent(BuildContext context) async {
    PokerSockets.socket.on("riverCards", (data) {
      if (kDebugMode) {
        print('Poker Socket In River Cards Event Completed $data');
      }
    });
  }

  void winnerEvent(BuildContext context) async {
    PokerSockets.socket.on("winner", (data) {
      if (kDebugMode) {
        print('Poker Socket In winner Completed $data');
      }
    });
  }

  void winnerAmountEvent(BuildContext context) async {
    PokerSockets.socket.on("winnerAmount", (data) {
      if (kDebugMode) {
        print('Poker Socket In Winner Amount Completed $data');
      }
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
      if (kDebugMode) {
        print('Poker Socket In Room Message Completed $data');
      }
    });
  }

  void disconnectEvent(BuildContext context) async {
    PokerSockets.socket.on("disconnect", (data) {
      if (kDebugMode) {
        print('Poker Socket In Disconnect Completed $data');
      }
    });
  }

  void gameJoinCard(BuildContext context,String playerId,String gameId,String chips) async {

    PokerSockets.socket.emit("gameJoin",[playerId,gameId,chips]);
    PokerSockets.socket.on("gameJoin", (data) {
      if (kDebugMode) {
        print('Poker Socket In Game Join Completed ***** draw *****  $data');
      }
    });
  }

  void playerActionCard(BuildContext context,String data) async {
    PokerSockets.socket.emit("playerAction",jsonEncode(data));
    PokerSockets.socket.on("playerAction", (data) {
      if (kDebugMode) {
        print('Poker Socket In Player Action Completed ***** draw *****  $data');
      }
    });
  }

  void disconnectSocket(BuildContext context){
    PokerSockets.socket.disconnect();
    Navigator.pop(context);
  }

  void setChipSliderTrueFalse(bool value){
    _chipSliderTrueFalse = value;
    notifyListeners();
  }

}