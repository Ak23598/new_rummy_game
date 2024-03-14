import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/custom_dialog/winner_dialog.dart';
import 'package:rummy_game/constant/image_constants.dart';
import 'package:rummy_game/poker/Sockets/poker_sockets.dart';
import 'package:rummy_game/poker/poker_provider/poker_provider.dart';
import 'package:rummy_game/poker/screen/player/main_player.dart';

class PokerGameScreen extends StatefulWidget {
  const PokerGameScreen({super.key});

  @override
  State<PokerGameScreen> createState() => _PokerGameScreenState();
}

class _PokerGameScreenState extends State<PokerGameScreen> {

  final List<bool> _servedPages = [false, false, false,false,false];
  final List<bool> _filpPages = [false, false, false,false,false];
  Timer? servingTimer;
  Timer? flipingTimer;
  bool isPlaying = false;



  // Player Game Create

  String playerId = 'Ridham';
  String gameId = '6r5252string45689tr';
  String chip = '200';
  String constantId = '6e5252int4568579uy';
  String smallBind = '10';
  String bigBind = '30';
  String playerName = 'Ridham';

  @override
  void initState() {
    sizeChangeAnimation();
    PokerSockets.connectAndListen(context,playerId,gameId,chip,'controller',constantId,smallBind,bigBind,playerName);
  }

  @override
  void dispose() {
    servingTimer?.cancel();
    flipingTimer?.cancel();
    super.dispose();
  }

  sizeChangeAnimation() {
    int serveCounter = 0;
    int flipCounter = 0;

    Future.delayed(const Duration(seconds: 3),(){
  servingTimer =
      Timer.periodic(const Duration(milliseconds: 200), (serveTimer) {
        if (!mounted) return;
        setState(() {
          _servedPages[serveCounter] = true;
        });
        serveCounter++;
        if (serveCounter == 5) {
          serveTimer.cancel();
          servingTimer?.cancel();
          Future.delayed(const Duration(seconds: 1), () {
            flipingTimer =
                Timer.periodic(const Duration(milliseconds: 200), (flipTimer) {
                  if (!mounted) return;
                  setState(() {
                    _filpPages[flipCounter] = true;
                  });
                  flipCounter++;
                  if (flipCounter == 5
                  ) {
                    flipTimer.cancel();
                    flipingTimer?.cancel();
                  }
                });
          });
        }
      });
});
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isPlaying = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokerProvider>(builder: (context,pokerProvider,_){
      return pokerProvider.gameMessage.isEmpty
          ? Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/poker/new_pocker_table.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      )
          : pokerProvider.gameMessage.toLowerCase() == "wait for a new player to join the game"
          ?Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/poker/new_pocker_table.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
            child: Center(child: Text(pokerProvider.gameMessage,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
          ),
        ],
      )
          :Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,

            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/poker/new_pocker_table.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.22,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/poker/poker_total_coin.png',height: MediaQuery.of(context).size.height * 0.10,width: MediaQuery.of(context).size.width * 0.06,),
                            Row(
                              children: [
                                const Text('Total Bet : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                Text('₹ ${pokerProvider.potAmount}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 14),),

                              ],
                            )

                          ],
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.40,
                    
                  ),
                  height: 50,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                        itemCount: pokerProvider.flopCard.length,
                        itemBuilder: (context,index){
                      return SizedBox(
                        width: 40,
                        child: Image.asset(pokerProvider.pokerCardList[pokerProvider.flopCard[index] - 1]),
                      );
                    }),
                  ),
                ),

              ],
            ),
          ),
          Positioned(
              left: 0.0,
              right: 0.0,
              top: MediaQuery.of(context).size.height * 0.07,
              child: const MainPlayer()),

          if(pokerProvider.playerNames.length == 2)
          Stack(
            children: [
              // Main Player

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.14,
                left: MediaQuery.of(context).size.width * 0.40,
                child: Stack(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [

                        Row(
                          children: [

                            Container(
                              height: 44,
                              width: 150,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [

                                      pokerProvider.playerNames[0].toString().contains(pokerProvider.player)
                                          ?SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.14,
                                        width:  MediaQuery.of(context).size.width * 0.051,
                                        child: CircularProgressIndicator(
                                          value: pokerProvider.countdown/50,
                                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                                          strokeWidth: 3,
                                          backgroundColor: pokerProvider.countdown <= 10 ?Colors.red:Colors.green,
                                        ),
                                      )
                                          :Container(),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(1),
                                              child: Image.asset(
                                                ImageConst.icProfilePic1,
                                                height: MediaQuery.of(context).size.height * 0.109,
                                                width:  MediaQuery.of(context).size.width * 0.048,
                                              ),
                                            ),
                                            pokerProvider.playerNames[0].toString().contains(pokerProvider.player)
                                                ?Container(
                                                decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Text(pokerProvider.countdown.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                                )):const Text('',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                                  Column(
                                    children: [
                                      Text(pokerProvider.playerNames[0].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                      pokerProvider.totalBetChips.toString().isNotEmpty
                                          ? Text('₹ ${double.parse(pokerProvider.totalBetChips.toString()).toStringAsFixed(2)}',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),)
                                          : Container()

                                    ],
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                        pokerProvider.playerBilndname[0].isNotEmpty?Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                          child: Center(
                            child: Text(
                              pokerProvider.playerBilndname[0],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ):Container(),
                      ],
                    ),
                    pokerProvider.playerBet[0].isNotEmpty && pokerProvider.playerBet[0].toString() !='0'?Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.40),
                      child: Container(height: 35,width: 100,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[0]}',style: const TextStyle(color: Colors.yellow
                      ,fontWeight: FontWeight.bold,fontSize: 16),)),),
                    ):Container()
                  ],
                ),
              ),

              // Top Player
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                right: pokerProvider.playerBet[1].isNotEmpty && pokerProvider.playerBet[1].toString() !='0'?MediaQuery.of(context).size.width * 0.30:MediaQuery.of(context).size.width * 0.42,
                child: Stack(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Row(
                          children: [

                            Container(
                              height: 44,
                              width: 150,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                              child: Row(
                                children: [

                                  Stack(
                                    children: [

                                      pokerProvider.playerNames[1].toString().contains(pokerProvider.player)
                                          ?SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.14,
                                        width:  MediaQuery.of(context).size.width * 0.051,
                                        child: CircularProgressIndicator(
                                          value: pokerProvider.countdown/50,
                                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                                          strokeWidth: 3,
                                          backgroundColor: pokerProvider.countdown <= 10 ?Colors.red:Colors.green,
                                        ),
                                      )
                                          :Container(),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(1),
                                              child: Image.asset(
                                                ImageConst.icProfilePic1,
                                                height: MediaQuery.of(context).size.height * 0.109,
                                                width:  MediaQuery.of(context).size.width * 0.048,
                                              ),
                                            ),
                                            pokerProvider.playerNames[1].toString().contains(pokerProvider.player)
                                                ?Container(
                                                decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Text(pokerProvider.countdown.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                                )):Container(),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                                  Column(
                                    children: [
                                      Text(pokerProvider.playerNames[1].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                      Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                    ],
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                        pokerProvider.playerBilndname[1].isNotEmpty?Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                          child: Center(
                            child: Text(
                              pokerProvider.playerBilndname[1],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ):Container()
                      ],
                    ),
                    pokerProvider.playerBet[1].isNotEmpty && pokerProvider.playerBet[1].toString() !='0'?Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.40),
                      child: Container(height: 35,width: 100,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[1]}',style: const TextStyle(color: Colors.yellow
                          ,fontWeight: FontWeight.bold,fontSize: 16),)),),
                    ):Container()
                  ],
                ),
              ),
            ],
          ),

          if(pokerProvider.playerCount == 3)
            Stack(
              children: [
                // Main Player
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.13,
                  left: MediaQuery.of(context).size.width * 0.40,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Row(
                        children: [

                          Container(
                            height: 44,
                            width: 150,
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                            child: Stack(
                              children: [
                                Stack(
                                  children: [

                                    pokerProvider.isNewMyTurn ?SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.14,
                                      width:  MediaQuery.of(context).size.width * 0.051,
                                      child: CircularProgressIndicator(
                                        value: pokerProvider.countdown/50,
                                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                                        strokeWidth: 3,
                                        backgroundColor: pokerProvider.countdown <= 10 ?Colors.red:Colors.green,
                                      ),
                                    ):Container(),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            ImageConst.icProfilePic1,
                                            height: MediaQuery.of(context).size.height * 0.11,
                                            width:  MediaQuery.of(context).size.width * 0.05,
                                          ),
                                          pokerProvider.isNewMyTurn
                                              ?Text(pokerProvider.countdown.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),):const Text('',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
                                  child: Column(
                                    children: [
                                      const Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                      pokerProvider.totalBetChips.toString().isNotEmpty
                                          ? Text('₹ ${double.parse(pokerProvider.totalBetChips.toString()).toStringAsFixed(2)}',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),)
                                          : Container()
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                      pokerProvider.bindName.isNotEmpty?Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                        child: Center(
                          child: Text(
                            pokerProvider.bindName,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ):Container()
                    ],
                  ),
                ),

                // Left Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Right Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

          if(pokerProvider.playerCount == 4)
            Stack(
              children: [
                // Main Player
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.13,
                  left: MediaQuery.of(context).size.width * 0.40,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Row(
                        children: [

                          Container(
                            height: 44,
                            width: 150,
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                            child: Stack(
                              children: [
                                Stack(
                                  children: [

                                    pokerProvider.isNewMyTurn ?SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.14,
                                      width:  MediaQuery.of(context).size.width * 0.051,
                                      child: CircularProgressIndicator(
                                        value: pokerProvider.countdown/50,
                                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                                        strokeWidth: 3,
                                        backgroundColor: pokerProvider.countdown <= 10 ?Colors.red:Colors.green,
                                      ),
                                    ):Container(),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            ImageConst.icProfilePic1,
                                            height: MediaQuery.of(context).size.height * 0.11,
                                            width:  MediaQuery.of(context).size.width * 0.05,
                                          ),
                                          pokerProvider.isNewMyTurn
                                              ?Text(pokerProvider.countdown.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),):const Text('',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
                                  child: Column(
                                    children: [
                                      const Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                      pokerProvider.totalBetChips.toString().isNotEmpty
                                          ? Text('₹ ${double.parse(pokerProvider.totalBetChips.toString()).toStringAsFixed(2)}',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),)
                                          : Container()
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                      pokerProvider.bindName.isNotEmpty?Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                        child: Center(
                          child: Text(
                            pokerProvider.bindName,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ):Container()
                    ],
                  ),
                ),

                // Left Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Right Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Top Player
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.width * 0.42,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

          if(pokerProvider.playerCount == 5)
            Stack(
              children: [
                // Main Player
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.13,
                  left: MediaQuery.of(context).size.width * 0.40,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Row(
                        children: [

                          Container(
                            height: 44,
                            width: 150,
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                            child: Stack(
                              children: [
                                Stack(
                                  children: [

                                    pokerProvider.isNewMyTurn ?SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.14,
                                      width:  MediaQuery.of(context).size.width * 0.051,
                                      child: CircularProgressIndicator(
                                        value: pokerProvider.countdown/50,
                                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                                        strokeWidth: 3,
                                        backgroundColor: pokerProvider.countdown <= 10 ?Colors.red:Colors.green,
                                      ),
                                    ):Container(),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            ImageConst.icProfilePic1,
                                            height: MediaQuery.of(context).size.height * 0.11,
                                            width:  MediaQuery.of(context).size.width * 0.05,
                                          ),
                                          pokerProvider.isNewMyTurn
                                              ?Text(pokerProvider.countdown.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),):const Text('',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
                                  child: Column(
                                    children: [
                                      const Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                      pokerProvider.totalBetChips.toString().isNotEmpty
                                          ? Text('₹ ${double.parse(pokerProvider.totalBetChips.toString()).toStringAsFixed(2)}',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),)
                                          : Container()
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                      pokerProvider.bindName.isNotEmpty?Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                        child: Center(
                          child: Text(
                            pokerProvider.bindName,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ):Container()
                    ],
                  ),
                ),

                // Left Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Right Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Left Bottom
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Right Bottom
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

          if(pokerProvider.playerCount == 6)
            Stack(
              children: [
                // Main Player
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.13,
                  left: MediaQuery.of(context).size.width * 0.40,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Row(
                        children: [

                          Container(
                            height: 44,
                            width: 150,
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                            child: Stack(
                              children: [
                                Stack(
                                  children: [

                                    pokerProvider.isNewMyTurn ?SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.14,
                                      width:  MediaQuery.of(context).size.width * 0.051,
                                      child: CircularProgressIndicator(
                                        value: pokerProvider.countdown/50,
                                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                                        strokeWidth: 3,
                                        backgroundColor: pokerProvider.countdown <= 10 ?Colors.red:Colors.green,
                                      ),
                                    ):Container(),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            ImageConst.icProfilePic1,
                                            height: MediaQuery.of(context).size.height * 0.11,
                                            width:  MediaQuery.of(context).size.width * 0.05,
                                          ),
                                          pokerProvider.isNewMyTurn
                                              ?Text(pokerProvider.countdown.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),):const Text('',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
                                  child: Column(
                                    children: [
                                      const Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                      pokerProvider.totalBetChips.toString().isNotEmpty
                                          ? Text('₹ ${double.parse(pokerProvider.totalBetChips.toString()).toStringAsFixed(2)}',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),)
                                          : Container()
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                      pokerProvider.bindName.isNotEmpty?Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                        child: Center(
                          child: Text(
                            pokerProvider.bindName,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ):Container()
                    ],
                  ),
                ),

                // Left Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Left Bottom
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Right Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Right Bottom
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                // Top Player
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.width * 0.42,
                  child: Row(
                    children: [

                      Container(
                        height: 44,
                        width: 150,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                              child: const Column(
                                children: [
                                  Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Text('₹ 2.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                ImageConst.icProfilePic2,
                                height: MediaQuery.of(context).size.height * 0.12,
                                width:  MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),



        ],
      );
    });
  }
}


