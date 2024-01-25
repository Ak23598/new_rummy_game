import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/custom_dialog/exit_dialog.dart';
import 'package:rummy_game/constant/image_constants.dart';
import 'package:rummy_game/provider/rummy_provider.dart';
import 'package:rummy_game/screens/rummy_palyer_table/five_player_table.dart';
import 'package:rummy_game/screens/rummy_palyer_table/four_player_table.dart';
import 'package:rummy_game/screens/rummy_palyer_table/six_player_table.dart';
import 'package:rummy_game/screens/rummy_palyer_table/three_player_table.dart';
import 'package:rummy_game/screens/rummy_palyer_table/two_player_table.dart';
import 'package:rummy_game/utils/Sockets.dart';

import 'rummy_palyer_table/one_player_table.dart';

class RummyGameScreen extends StatefulWidget {
  String gameId;
  String userId;
  RummyGameScreen({Key? key,required this.userId,required this.gameId}) : super(key: key);

  @override
  _RummyGameScreenState createState() => _RummyGameScreenState();
}

class _RummyGameScreenState extends State<RummyGameScreen> {
  bool sizeChange = false;
  List<bool> _servedPages = [false, false, false,false,false, false, false,false,false, false,false,false];
  List<bool> _jokerServedPages = [false];
  List<bool> _jokerFlipedPages = [false];
  List<bool> _flipedPages = [false, false, false,false,false, false, false,false,false, false,false,false];
  Timer? servingTimer;
  Timer? flipingTimer;
  Timer? jokerServingTimer;
  Timer? jokerFlipingTimer;
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    Sockets.connectAndListen(context,widget.gameId,widget.userId,controller);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    sizeChangeAnimation();
  }
  @override
  void dispose() {
    servingTimer?.cancel();
    flipingTimer?.cancel();
    jokerServingTimer?.cancel();
    jokerFlipingTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  sizeChangeAnimation() {
    int serveCounter = 0;
    int jokerServeCounter = 0;
    int flipCounter = 0;
    int jokerFlipCounter = 0;
    servingTimer = Timer.periodic(Duration(milliseconds: 200), (serveTimer) {
      if (!mounted) return;
      setState(() {
        _servedPages[serveCounter] = true;
      });
      serveCounter++;
      if (serveCounter == 11) {
        serveTimer.cancel();
        servingTimer?.cancel();
        Future.delayed(Duration(seconds: 1),(){
          Provider.of<RummyProvider>(context,listen: false).setFilpCard(false);
          flipingTimer = Timer.periodic(Duration(milliseconds: 200), (flipTimer) {
            if (!mounted) return;
            setState(() {
              _flipedPages[flipCounter] = true;
            });
            flipCounter++;
            if (flipCounter == 11) {
              flipTimer.cancel();
              flipingTimer?.cancel();
            }
          });
        });

      }
    });
    Future.delayed(Duration(seconds: 6),(){
      jokerServingTimer = Timer.periodic(Duration(milliseconds: 500), (jokerServeTimer) {
        if (!mounted) return;
        setState(() {
          _jokerServedPages[jokerServeCounter] = true;
        });
        jokerServeCounter++;
        if (jokerServeCounter == 1) {
          jokerServeTimer.cancel();
          jokerServingTimer?.cancel();
          Future.delayed(Duration(seconds: 1),(){
            jokerFlipingTimer = Timer.periodic(Duration(milliseconds: 200), (jokerFlipTimer) {
              if (!mounted) return;
              setState(() {
                _jokerFlipedPages[jokerFlipCounter] = true;
              });
              jokerFlipCounter++;
              if (jokerFlipCounter == 1) {
                jokerFlipTimer.cancel();
                jokerFlipingTimer?.cancel();
              }
            });
          });
        }
      });
    });
  }

  Future<bool> _willPopCallback() async {
    ExitDialog(
      title: 'Quit Game',
      message: "Quiting On Going Game In The Middle Results",
      leftButton: 'Cancel',
      rightButton: 'Exit',
      onTapLeftButton: () {
        Navigator.pop(context);
      },
      onTapRightButton: () {

      },
    ).show(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child:  WillPopScope(
          onWillPop: _willPopCallback,
          child: Consumer<RummyProvider>(
            builder: (context,rummyProvider,_){
              return Container(
                decoration:  const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageConst.bgHome),
                    fit: BoxFit.fill,
                  ),
                ),
                child: rummyProvider.playerCount == 1
                    ? Stack(
                  alignment: Alignment.center,
                  children: [

                    rummyProvider.newIndexData.isNotEmpty
                        ? OnePlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: rummyProvider.newIndexData,
                      jokerFlipedPages: _jokerFlipedPages,
                      jokerServedPages: _jokerServedPages,
                    )
                        : const OnePlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                      jokerFlipedPages: [],
                      jokerServedPages: [],
                    ),
                    rummyProvider.stopCountDown != 1?Container():rummyProvider.isMyTurn?Container():Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: rummyProvider.secondsRemaining/30,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 3,
                            backgroundColor: rummyProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                          ),
                          Text('${rummyProvider.secondsRemaining.toString()}',style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),

                  ],
                )
                    : rummyProvider.playerCount == 2
                    ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    rummyProvider.newIndexData.isNotEmpty
                        ? TwoPlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: rummyProvider.newIndexData,
                      jokerFlipedPages: _jokerFlipedPages,
                      jokerServedPages: _jokerServedPages,
                    )
                        : const TwoPlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                      jokerFlipedPages: [],
                      jokerServedPages: [],
                    ),
                    rummyProvider.stopCountDown != 1?Container():rummyProvider.isMyTurn?Container():Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: rummyProvider.secondsRemaining/30,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 3,
                            backgroundColor: rummyProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                          ),
                          Text('${rummyProvider.secondsRemaining.toString()}',style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ],
                )
                    : rummyProvider.playerCount == 3
                    ? Stack(
                  alignment: Alignment.center,
                  children: [

                    rummyProvider.newIndexData.isNotEmpty
                        ? ThreePlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: rummyProvider.newIndexData,
                      jokerFlipedPages: _jokerFlipedPages,
                      jokerServedPages: _jokerServedPages,
                    )
                        : const ThreePlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                      jokerFlipedPages: [],
                      jokerServedPages: [],
                    ),
                    rummyProvider.stopCountDown != 1?Container():rummyProvider.isMyTurn?Container():Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: rummyProvider.secondsRemaining/30,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 3,
                            backgroundColor: rummyProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                          ),
                          Text('${rummyProvider.secondsRemaining.toString()}',style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),

                  ],
                )
                    : rummyProvider.playerCount == 4
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    rummyProvider.newIndexData.isNotEmpty
                        ? FourPlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: rummyProvider.newIndexData,
                      jokerFlipedPages: _jokerFlipedPages,
                      jokerServedPages: _jokerServedPages,
                    )
                        : const FourPlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                      jokerFlipedPages: [],
                      jokerServedPages: [],
                    ),
                    rummyProvider.stopCountDown != 1?Container():rummyProvider.isMyTurn?Container():Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: rummyProvider.secondsRemaining/30,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 3,
                            backgroundColor: rummyProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                          ),
                          Text('${rummyProvider.secondsRemaining.toString()}',style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),

                  ],
                )
                    : rummyProvider.playerCount == 5
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    rummyProvider.newIndexData.isNotEmpty
                        ? FivePlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: rummyProvider.newIndexData,
                      jokerFlipedPages: _jokerFlipedPages,
                      jokerServedPages: _jokerServedPages,
                    )
                        : const FivePlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                      jokerFlipedPages: [],
                      jokerServedPages: [],
                    ),
                    rummyProvider.stopCountDown != 1?Container():rummyProvider.isMyTurn?Container():Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: rummyProvider.secondsRemaining/30,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 3,
                            backgroundColor: rummyProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                          ),
                          Text('${rummyProvider.secondsRemaining.toString()}',style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),

                  ],
                )
                    : rummyProvider.playerCount == 6
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    rummyProvider.newIndexData.isNotEmpty
                        ? SixPlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: rummyProvider.newIndexData,
                      jokerFlipedPages: _jokerFlipedPages,
                      jokerServedPages: _jokerServedPages,
                    )
                        : const SixPlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                      jokerFlipedPages: [],
                      jokerServedPages: [],
                    ),
                    rummyProvider.stopCountDown != 1?Container():rummyProvider.isMyTurn?Container():Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: rummyProvider.secondsRemaining/30,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 3,
                            backgroundColor: rummyProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                          ),
                          Text('${rummyProvider.secondsRemaining.toString()}',style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),

                  ],
                )
                    : Stack(
                  alignment: Alignment.center,
                  children: [

                    rummyProvider.newIndexData.isNotEmpty
                        ? OnePlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: rummyProvider.newIndexData,
                      jokerFlipedPages: _jokerFlipedPages,
                      jokerServedPages: _jokerServedPages,
                    )
                        : const OnePlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                      jokerFlipedPages: [],
                      jokerServedPages: [],
                    ),
                    rummyProvider.stopCountDown == 1?Container():rummyProvider.isMyTurn?Container():Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: rummyProvider.secondsRemaining/30,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 3,
                            backgroundColor: rummyProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                          ),
                          Text('${rummyProvider.secondsRemaining.toString()}',style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),

                  ],
                ),
              );
            },
          ),
        ),
      )
    );
  }
}



