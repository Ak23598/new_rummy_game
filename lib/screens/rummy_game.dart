import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/custom_dialog/exit_dialog.dart';
import 'package:rummy_game/constant/image_constants.dart';
import 'package:rummy_game/provider/socket_provider.dart';
import 'package:rummy_game/screens/rummy_palyer_table/two_player_table.dart';
import 'package:rummy_game/utils/Sockets.dart';

class RummyGameScreen extends StatefulWidget {
  String gameId;
  String userId;
  RummyGameScreen({Key? key,required this.userId,required this.gameId}) : super(key: key);

  @override
  _RummyGameScreenState createState() => _RummyGameScreenState();
}

class _RummyGameScreenState extends State<RummyGameScreen> {
  bool sizeChange = false;
  final List<bool> _servedPages = [false, false, false,false,false, false, false,false,false, false,false,false,false,false,false];
  final List<bool> _flipedPages = [false, false, false,false,false, false, false,false,false, false,false,false,false,false,false];
  Timer? servingTimer;
  Timer? flipingTimer;
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {

    print('Socket Game Id :-    ${widget.gameId}');
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
        Provider.of<SocketProvider>(context,listen: false).gameOver(context,widget.gameId);
        Provider.of<SocketProvider>(context,listen: false).disconnectSocket(context);
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
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                     TwoPlayerTableWidget(
                       gameId: widget.gameId,
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



