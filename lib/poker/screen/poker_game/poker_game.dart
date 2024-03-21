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

  String playerId = 'User 2';
  String gameId = '6r5252string45689tn';
  String chip = '200';
  String constantId = '6e5252int4568579uy';
  String smallBind = '10';
  String bigBind = '30';
  String playerName = 'User 2';

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
                      child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[0]}',style: const TextStyle(color: Colors.yellow
                      ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                    ):Container()
                  ],
                ),
              ),

              // Top Player
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                right: pokerProvider.playerBet[1].isNotEmpty && pokerProvider.playerBet[1].toString() !='0'?MediaQuery.of(context).size.width * 0.33:MediaQuery.of(context).size.width * 0.42,
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
                                      pokerProvider.playerChips[1] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
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
                      child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${double.parse(pokerProvider.playerBet[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Colors.yellow
                          ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                    ):Container()
                  ],
                ),
              ),




            ],
          ),

          if(pokerProvider.playerNames.length == 3)
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
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[0]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Left Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.02,
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
                                        pokerProvider.playerChips[1] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
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
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[1]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Right Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: MediaQuery.of(context).size.width * 0.03,
                  child: Row(
                    children: [
                      pokerProvider.playerBet[2].isNotEmpty && pokerProvider.playerBet[2].toString() !='0'?Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[2]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container(),
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

                                        pokerProvider.playerNames[2].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[2].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[2].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[2] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[2].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[2],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
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
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[0]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Left Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.02,
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
                                        pokerProvider.playerChips[1] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
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
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[1]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Right Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: MediaQuery.of(context).size.width * 0.03,
                  child: Row(
                    children: [
                      pokerProvider.playerBet[2].isNotEmpty && pokerProvider.playerBet[2].toString() !='0'?Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[2]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container(),
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

                                        pokerProvider.playerNames[2].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[2].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[2].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[2] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[2].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[2],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
                      ),

                    ],
                  ),
                ),

                // Top Player
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.08,
                  right: pokerProvider.playerBet[3].isNotEmpty && pokerProvider.playerBet[3].toString() !='0'?MediaQuery.of(context).size.width * 0.33:MediaQuery.of(context).size.width * 0.42,
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

                                        pokerProvider.playerNames[3].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[3].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[3].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[3] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[3].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[3].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[3],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
                      ),
                      pokerProvider.playerBet[3].isNotEmpty && pokerProvider.playerBet[1].toString() !='0'?Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.40),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[3]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
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
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[0]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Left Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.02,
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
                                        pokerProvider.playerChips[1] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
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
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[1]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Right Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: MediaQuery.of(context).size.width * 0.03,
                  child: Row(
                    children: [
                      pokerProvider.playerBet[2].isNotEmpty && pokerProvider.playerBet[2].toString() !='0'?Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[2]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container(),
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

                                        pokerProvider.playerNames[2].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[2].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[2].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[2] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[2].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[2],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
                      ),

                    ],
                  ),
                ),

                // Left Bottom
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  left: MediaQuery.of(context).size.width * 0.02,
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

                                        pokerProvider.playerNames[3].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[3].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[3].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[3] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[3].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[3].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[3],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
                      ),
                      pokerProvider.playerBet[3].isNotEmpty && pokerProvider.playerBet[3].toString() !='0'?Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.40),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[3]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Right Bottom
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [
                      pokerProvider.playerBet[4].isNotEmpty && pokerProvider.playerBet[4].toString() !='0'?Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[4]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container(),
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

                                        pokerProvider.playerNames[4].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[4].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[4].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[4] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[4].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[4].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[4],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
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
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[0]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Left Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.02,
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
                                        pokerProvider.playerChips[1] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[1].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
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
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[1]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
                    ],
                  ),
                ),

                // Left Bottom
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
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

                                        pokerProvider.playerNames[2].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[2].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[2].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[2] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[2].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[2].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[2],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
                      ),
                      pokerProvider.playerBet[2].isNotEmpty && pokerProvider.playerBet[2].toString() !='0'?Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[2]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container(),

                    ],
                  ),
                ),

                // Right Top
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: MediaQuery.of(context).size.width * 0.03,
                  child: Row(
                    children: [
                      pokerProvider.playerBet[3].isNotEmpty && pokerProvider.playerBet[3].toString() !='0'?Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[3]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container(),
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

                                        pokerProvider.playerNames[3].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[3].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[3].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[3] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[3].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[3].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[3],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
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
                      pokerProvider.playerBet[4].isNotEmpty && pokerProvider.playerBet[4].toString() !='0'?Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[4]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container(),
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

                                        pokerProvider.playerNames[4].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[4].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[4].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[4] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[4].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[4].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[4],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
                      ),

                    ],
                  ),
                ),

                // Top Player
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.08,
                  right: pokerProvider.playerBet[5].isNotEmpty && pokerProvider.playerBet[5].toString() !='0'?MediaQuery.of(context).size.width * 0.33:MediaQuery.of(context).size.width * 0.42,
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

                                        pokerProvider.playerNames[5].toString().contains(pokerProvider.player)
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
                                              pokerProvider.playerNames[5].toString().contains(pokerProvider.player)
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
                                        Text(pokerProvider.playerNames[5].toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                        pokerProvider.playerChips[5] == null ?Container():Text('₹ ${double.parse(pokerProvider.playerChips[5].toString()).toStringAsFixed(2)}',style: const TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 12),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          pokerProvider.playerBilndname[5].isNotEmpty?Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            child: Center(
                              child: Text(
                                pokerProvider.playerBilndname[5],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ):Container()
                        ],
                      ),
                      pokerProvider.playerBet[5].isNotEmpty && pokerProvider.playerBet[5].toString() !='0'?Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.40),
                        child: Container(height: 30,width: 80,decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.yellow)),child: Center(child: Text('Bet : ${pokerProvider.playerBet[5]}',style: const TextStyle(color: Colors.yellow
                            ,fontWeight: FontWeight.bold,fontSize: 13),)),),
                      ):Container()
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


