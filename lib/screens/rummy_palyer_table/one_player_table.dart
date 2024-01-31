import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rummy_game/constant/image_constants.dart';

import 'package:rummy_game/provider/socket_provider.dart';
import 'package:rummy_game/utils/Sockets.dart';
import 'package:rummy_game/widgets/main_player/new_main_set_widget.dart';

class OnePlayerTableWidget extends StatefulWidget {
  final List<bool> servedPages;

  final List<bool> flipedPages;
  final List<int> cardPage;

  const OnePlayerTableWidget({
    super.key,
    required this.servedPages,
    required this.flipedPages,
    required this.cardPage,
  });

  @override
  State<OnePlayerTableWidget> createState() => _OnePlayerTableWidgetState();
}

class _OnePlayerTableWidgetState extends State<OnePlayerTableWidget> {

  @override
  void initState() {
    super.initState();
    var socketProvider = Provider.of<SocketProvider>(context,listen: false);
    socketProvider.setCardUpFalse();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(builder: (context,socketProvider,_){
      return Positioned(
        left: 0.0,
        right: 0.0,
        top: MediaQuery.of(context).size.height * 0.12,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width -50,
              height: MediaQuery.of(context).size.height - 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConst.ic3PattiTable),
                  fit: BoxFit.fill,
                ),
              ),
              child: socketProvider.stopCountDown == 1
                  ? Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
                    child: Center(child: Text('Start Game in ${socketProvider.countDown} Seconds...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
                  ),
                ],
              )
                  : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
                    child: const Center(child: Text('Not Joining Another Player...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
