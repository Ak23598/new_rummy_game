import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
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

  String playerId = 'jaydip';
  String gameId = '6r5252string45689tr';
  String chip = '200';
  String constantId = '6e5252int4568579uy';
  String smallBind = '10';
  String bigBind = '30';
  String playerName = 'jaydip';

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
                pokerProvider.callBet.toString().isNotEmpty?Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.62,left: MediaQuery.of(context).size.width * 0.55),
                  child:  Row(
                    children: [
                      const Text('₹ ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      Text(pokerProvider.callBet.toString(),style: const TextStyle(color: Color(0xff22EB72),fontSize: 16,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ):Container(),
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

          if(pokerProvider.playerCount == 2)
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


