import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  List<bool> _servedPages = [false, false, false,false,false];
  List<bool> _filpPages = [false, false, false,false,false];
  Timer? servingTimer;
  Timer? flipingTimer;
  bool isPlaying = false;

  @override
  void initState() {
    sizeChangeAnimation();
    PokerSockets.connectAndListen(context,'user12fq2','9909434317','300','controller','90540968587','50','70');
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
      return Stack(
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
                            const Row(
                              children: [
                                Text('Total Bet : ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                Text('₹ 5.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 14),),

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
                      left: MediaQuery.of(context).size.width * 0.37
                  ),
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                      itemCount: pokerProvider.flopCard.length,
                      itemBuilder: (context,index){
                    return Container(
                      width: 45,
                      child: Image.asset(pokerProvider.pokerCardList[pokerProvider.flopCard[index] - 1]),
                    );
                  }),
                ),

              ],
            ),
          ),
          Positioned(
              left: 0.0,
              right: 0.0,
              top: MediaQuery.of(context).size.height * 0.07,
              child: const MainPlayer()),
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

                              pokerProvider.isMyTurn ?Container(
                                height: MediaQuery.of(context).size.height * 0.14,
                                width:  MediaQuery.of(context).size.width * 0.051,
                                child: CircularProgressIndicator(
                                  value: pokerProvider.secondsRemaining/30,
                                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                                  strokeWidth: 3,
                                  backgroundColor: pokerProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                                ),
                              ):Container(),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      ImageConst.icProfilePic1,
                                      height: MediaQuery.of(context).size.height * 0.12,
                                      width:  MediaQuery.of(context).size.width * 0.05,
                                    ),
                                    pokerProvider.isMyTurn
                                        ?Text(pokerProvider.secondsRemaining.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),):const Text('',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ],
                                ),
                              ),


                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
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
      );
    });
  }
}


