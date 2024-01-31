
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  WinnerDialog({
    required this.title,
    required this.message,
    required this.rightButton,
    required this.onTapRightButton,
    required this.leftButton,
    required this.onTapLeftButton,
    required this.controller,
    required this.gameId,
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

      })
      : super(key: key);
  @override
  _PopupCallState createState() => _PopupCallState();
}

class _PopupCallState extends State<_PopupCall> {
  @override
  Widget build(BuildContext context) {
    widget.controller.play();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      backgroundColor: Colors.black87,
      titlePadding: EdgeInsets.all(0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Align(
              alignment: Alignment.topRight,
              child:Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/r_image/cancelBack.png',height: 30,width: 30,),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ConfettiWidget(confettiController: widget.controller,shouldLoop: true,),
                ],
              )

          ),
          Center(
            child: Text(widget.title,
                style: const TextStyle(
                  fontFamily: 'TTNorms',
                  fontWeight: FontWeight.bold,
                  wordSpacing: 0,
                  letterSpacing: 0,
                  fontSize: 25,
                  color: Colors.yellow,
                )),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'TTNorms',
              fontWeight: FontWeight.w400,
              wordSpacing: 0,
              letterSpacing: 0,
              fontSize: 15,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
      actions: [
        if (widget.leftButton != null)
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<SocketProvider>(context,listen: false).disconnectSocket(context);
                      Provider.of<SocketProvider>(context,listen: false).gameOver(context,widget.gameId);
                      Navigator.pop(context);
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          'Try Now'.toUpperCase(),
                          style: TextStyle(
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