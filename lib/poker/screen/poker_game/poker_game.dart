import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:rummy_game/constant/image_constants.dart';
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
    return Stack(
      children: [
        Positioned(
          left: 0.0,
          right: 0.0,
          top: MediaQuery.of(context).size.height * 0.07,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width -50,
                  height: MediaQuery.of(context).size.height - 70,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/poker/poker_table.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.21),
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
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.62,left: MediaQuery.of(context).size.width * 0.55),
                child: const Row(
                  children: [
                    Text('₹ ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                    Text('3.0',style: TextStyle(color: Color(0xff22EB72),fontSize: 16,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              isPlaying
                  ? Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.31,
                        left: MediaQuery.of(context).size.width * 0.37),
                    width: 60,
                    height: 60,
                    child: Image.asset('assets/cards/bl8.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.31,
                        left: MediaQuery.of(context).size.width * 0.42),
                    width: 60,
                    height: 60,
                    child: Image.asset('assets/cards/bl9.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.31,
                        left: MediaQuery.of(context).size.width * 0.47),
                    width: 60,
                    height: 60,
                    child: Image.asset('assets/cards/bl5.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.31,
                        left: MediaQuery.of(context).size.width * 0.52),
                    width: 60,
                    height: 60,
                    child: Image.asset('assets/cards/blj.png'),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.31,
                        left: MediaQuery.of(context).size.width * 0.57),
                    width: 60,
                    height: 60,
                    child: Image.asset('assets/cards/bla.png'),
                  ),
                ],
              )
                  : Stack(
                children: [
                  // One Card
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.31,
                          left: MediaQuery.of(context).size.width * 0.37),
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[0],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: const Size(60, 60),
                        sizeDisabled: const Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[0],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(
                              MediaQuery.of(context).size.width * 0.10,
                              -MediaQuery.of(context).size.height * 0.15),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Two Card
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.31,
                          left: MediaQuery.of(context).size.width * 0.42),
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[1],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: const Size(60, 60),
                        sizeDisabled: const Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[1],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(
                              MediaQuery.of(context).size.width * 0.05,
                              -MediaQuery.of(context).size.height * 0.2),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Three Card
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.31,
                          left: MediaQuery.of(context).size.width * 0.47),
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[2],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: const Size(60, 60),
                        sizeDisabled: const Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[2],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(
                              MediaQuery.of(context).size.width * 0.0,
                              -MediaQuery.of(context).size.height * 0.2),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Four Card
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.31,
                          left: MediaQuery.of(context).size.width * 0.52),
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[3],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: const Size(60, 60),
                        sizeDisabled: const Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[3],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(
                              -MediaQuery.of(context).size.width * 0.05,
                              -MediaQuery.of(context).size.height * 0.2),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Five Card
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.31,
                          left: MediaQuery.of(context).size.width * 0.57,),
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[4],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: const Size(60, 60),
                        sizeDisabled: const Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[4],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(
                              -MediaQuery.of(context).size.width * 0.10,
                              -MediaQuery.of(context).size.height * 0.2),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),
                ],
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
          bottom: MediaQuery.of(context).size.height * 0.11,
          left: MediaQuery.of(context).size.width * 0.40,
          child: Row(
            children: [

              Container(
                height: 55,
                width: 160,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                child: Stack(
                  children: [
                    Image.asset(
                      ImageConst.icProfilePic3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width:  MediaQuery.of(context).size.width * 0.06,
                    ),
                     const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,top: 5),
                        child: Column(
                          children: [
                            Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('₹ 5.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 14),),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.22,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Row(
            children: [

              Container(
                height: 55,
                width: 160,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                child: Stack(
                  children: [
                    Image.asset(
                      ImageConst.icProfilePic2,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width:  MediaQuery.of(context).size.width * 0.06,
                    ),
                     const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,top: 5),
                        child: Column(
                          children: [
                            Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('₹ 5.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 14),),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.35,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Row(
            children: [

              Container(
                height: 55,
                width: 160,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                child: Stack(
                  children: [
                    Image.asset(
                      ImageConst.icProfilePic4,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width:  MediaQuery.of(context).size.width * 0.06,
                    ),
                     const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20,top: 5),
                        child: Column(
                          children: [
                            Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('₹ 5.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 14),),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.22,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Row(
            children: [

              Container(
                height: 55,
                width: 160,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                child: Stack(
                  children: [
                     const Padding(
                       padding: EdgeInsets.only(left: 30,top: 5),
                       child: Column(
                         children: [
                           Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                           Text('₹ 5.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 14),),
                         ],
                       ),
                     ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        ImageConst.icProfilePic5,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width:  MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.35,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Row(
            children: [

              Container(
                height: 55,
                width: 160,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.56),borderRadius: BorderRadius.circular(30),border: Border.all(color: const Color(0xffF5CE33))),
                child: Stack(
                  children: [
                     const Padding(
                       padding: EdgeInsets.only(left: 30,top: 5),
                       child: Column(
                         children: [
                           Text('Surdhi',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                           Text('₹ 5.0',style: TextStyle(color: Color(0xff22EB72),fontWeight: FontWeight.bold,fontSize: 14),),
                         ],
                       ),
                     ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        ImageConst.icProfilePic2,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width:  MediaQuery.of(context).size.width * 0.06,
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
  }
}


