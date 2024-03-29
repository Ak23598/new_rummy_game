
import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/poker/poker_provider/poker_provider.dart';
import 'package:rummy_game/provider/socket_provider.dart';

class WinnerDialog {
  final String title;
  final String message;
  final String rightButton;
  final VoidCallback onTapRightButton;
  final String leftButton;
  final VoidCallback onTapLeftButton;
  final ConfettiController controller;
  final String gameId;
  final bool isShow;

  WinnerDialog({
    required this.title,
    required this.message,
    required this.rightButton,
    required this.onTapRightButton,
    required this.leftButton,
    required this.onTapLeftButton,
    required this.controller,
    required this.gameId,
    required this.isShow,
  });

  show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return _PopupCall(
            title: title,
            message: message,
            leftButton: leftButton,
            rightButton: rightButton,
            onTapLeftButton: onTapLeftButton,
            onTapRightButton: onTapRightButton,
          controller: controller,
          gameId: gameId,
          isShow: isShow,
        );
      },
    );
  }
}

class _PopupCall extends StatefulWidget {
  final String title;
  final String message;
  final String rightButton;
  final VoidCallback onTapRightButton;
  final String leftButton;
  final VoidCallback onTapLeftButton;
  final ConfettiController controller;
  final String gameId;
  final bool isShow;

  const _PopupCall(
      {Key? key,
        required this.title,
        required this.message,
        required this.rightButton,
        required this.onTapRightButton,
        required this.leftButton,
        required this.controller,
        required this.onTapLeftButton,
        required this.gameId,
        required this.isShow,

      })
      : super(key: key);
  @override
  _PopupCallState createState() => _PopupCallState();
}

class _PopupCallState extends State<_PopupCall> {

  int value = 8;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(value !=0){
        widget.controller.play();
        setState(() {
          value -= 1;
        });
      }else{

        Provider.of<PokerProvider>(context,listen: false).resetVariableMethod();
        // widget.controller.dispose();
        Navigator.pop(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      backgroundColor: Colors.black87,
      titlePadding: const EdgeInsets.all(0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child:Stack(
                alignment: Alignment.center,
                children: [
                  if(widget.isShow == true)
                  ConfettiWidget(confettiController: widget.controller,shouldLoop: true,),
                ],
              )

          ),
          const SizedBox(height: 10,),
          Image.asset('assets/images/ic_profile_pic_1.png',height: MediaQuery.of(context).size.height * 0.15,),
          const SizedBox(height: 10,),
           Center(
            child: Text(widget.title,
                style: const TextStyle(
                  fontFamily: 'TTNorms',
                  fontWeight: FontWeight.bold,
                  wordSpacing: 0,
                  letterSpacing: 0,
                  fontSize: 16,
                  color: Colors.yellow,
                )),
          ),
           Center(
            child: Text(widget.message,
                style: const TextStyle(
                  fontFamily: 'TTNorms',
                  fontWeight: FontWeight.bold,
                  wordSpacing: 0,
                  letterSpacing: 0,
                  fontSize: 14,
                  color: Colors.yellow,
                )),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 50,
            width: 100,
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: Provider.of<PokerProvider>(context,listen: false).winnerCard.length,
                  itemBuilder: (context,index){
                    return SizedBox(
                      width: 38,
                      child: Image.asset(Provider.of<PokerProvider>(context,listen: false).pokerCardList[Provider.of<PokerProvider>(context,listen: false).winnerCard[index] - 1]),
                    );
                  }),
            ),
          ),
        ],
      ),
      // content: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Text(
      //       widget.message,
      //       textAlign: TextAlign.center,
      //       style: const TextStyle(
      //         fontFamily: 'TTNorms',
      //         fontWeight: FontWeight.w400,
      //         wordSpacing: 0,
      //         letterSpacing: 0,
      //         fontSize: 15,
      //         color: Colors.yellow,
      //       ),
      //     ),
      //   ],
      // ),
      actions: [
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Provider.of<PokerProvider>(context,listen: false).exitEvent(context);
                    // Provider.of<PokerProvider>(context,listen: false).leaveEvent(context);
                    Provider.of<PokerProvider>(context,listen: false).disconnectSocket(context);
                    Provider.of<PokerProvider>(context,listen: false).resetVariableMethod();
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2.0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Quit Game'.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'TTNorms',
                          fontWeight: FontWeight.bold,
                          wordSpacing: 0,
                          letterSpacing: 0,
                          fontSize: 15,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2.0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Next Game (${value.toString()})'.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'TTNorms',
                          fontWeight: FontWeight.bold,
                          wordSpacing: 0,
                          letterSpacing: 0,
                          fontSize: 15,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],)
      ],
    );
  }


}