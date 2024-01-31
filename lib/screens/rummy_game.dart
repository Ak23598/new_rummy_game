import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/custom_dialog/exit_dialog.dart';
import 'package:rummy_game/constant/image_constants.dart';

import 'package:rummy_game/provider/socket_provider.dart';
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
  List<bool> _flipedPages = [false, false, false,false,false, false, false,false,false, false,false,false];
  Timer? servingTimer;
  Timer? flipingTimer;
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    Provider.of<SocketProvider>(context, listen: false).resetAllData();
    Provider.of<SocketProvider>(context, listen: false).setStopCountDown(1);
    Sockets.connectAndListen(context,widget.gameId,widget.userId,controller);
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
    controller.dispose();
    Provider.of<SocketProvider>(context, listen: false).closeTimer();
    super.dispose();
  }

  sizeChangeAnimation() {
    int serveCounter = 0;
    int flipCounter = 0;

    servingTimer = Timer.periodic(const Duration(milliseconds: 200), (serveTimer) {
      if (!mounted) return;
      setState(() {
        _servedPages[serveCounter] = true;
      });
      serveCounter++;
      if (serveCounter == 11) {
        serveTimer.cancel();
        servingTimer?.cancel();
        Future.delayed(const Duration(seconds: 1),(){
          Provider.of<SocketProvider>(context,listen: false).setFilpCard(false);
          flipingTimer = Timer.periodic(const Duration(milliseconds: 200), (flipTimer) {
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
      gameId: widget.gameId
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
          child: Consumer<SocketProvider>(
            builder: (context,socketProvider,_){
              return Container(
                decoration:  const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageConst.bgHome),
                    fit: BoxFit.fill,
                  ),
                ),
                child: socketProvider.playerCount == 1
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    socketProvider.newIndexData.isNotEmpty
                        ? OnePlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: socketProvider.newIndexData,
                    )
                        : const OnePlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                    ),
                  ],
                )
                    : socketProvider.playerCount == 2
                    ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    socketProvider.newIndexData.isNotEmpty
                        ? TwoPlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: socketProvider.newIndexData,
                    )
                        : const TwoPlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                    ),
                  ],
                )
                    : socketProvider.playerCount == 3
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    socketProvider.newIndexData.isNotEmpty
                        ? ThreePlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: socketProvider.newIndexData,
                    )
                        : const ThreePlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                    ),

                  ],
                )
                    : socketProvider.playerCount == 4
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    socketProvider.newIndexData.isNotEmpty
                        ? FourPlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: socketProvider.newIndexData,
                    )
                        : const FourPlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                    ),

                  ],
                )
                    : socketProvider.playerCount == 5
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    socketProvider.newIndexData.isNotEmpty
                        ? FivePlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: socketProvider.newIndexData,
                    )
                        : const FivePlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                    ),
                  ],
                )
                    : socketProvider.playerCount == 6
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    socketProvider.newIndexData.isNotEmpty
                        ? SixPlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: socketProvider.newIndexData,
                    )
                        : const SixPlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
                    ),
                  ],
                )
                    : Stack(
                  alignment: Alignment.center,
                  children: [
                    socketProvider.newIndexData.isNotEmpty
                        ? OnePlayerTableWidget(
                      servedPages: _servedPages,
                      flipedPages: _flipedPages,
                      cardPage: socketProvider.newIndexData,
                    )
                        : const OnePlayerTableWidget(
                      servedPages: [],
                      flipedPages: [],
                      cardPage: [],
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



