import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/poker/poker_provider/poker_provider.dart';

class MainPlayer extends StatefulWidget {
  const MainPlayer({super.key});

  @override
  State<MainPlayer> createState() => _MainPlayerState();
}

class _MainPlayerState extends State<MainPlayer> {
  List<bool> _servedPages = [false, false, false];
  List<bool> _filpPages = [false, false, false];
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

    servingTimer =
        Timer.periodic(const Duration(milliseconds: 200), (serveTimer) {
      if (!mounted) return;
      setState(() {
        _servedPages[serveCounter] = true;
      });
      serveCounter++;
      if (serveCounter == 2) {
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
            if (flipCounter == 2) {
              flipTimer.cancel();
              flipingTimer?.cancel();
            }
          });
        });
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isPlaying = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokerProvider>(builder: (context,pokerProvider,_){
      return Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.54),
            child: SizedBox(
              height: 75,
              child: isPlaying
                  ? pokerProvider.newHandCard.isNotEmpty?Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 0.29, left: 2.0),
                    height: 60 + 0.29,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(350 / 370),
                      child: OpacityAnimatedWidget.tween(
                        opacityEnabled: 1,
                        opacityDisabled: 0,
                        enabled: true,
                        child: RotationAnimatedWidget.tween(
                          enabled: true,
                          rotationDisabled: Rotation.deg(y: 180),
                          rotationEnabled: Rotation.deg(y: 0),
                          child: Image.asset(pokerProvider.pokerCardList[pokerProvider.newHandCard[0]]),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 0.2, left: 23),
                    height: 60 + 0.1,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(350 / 350),
                      child: OpacityAnimatedWidget.tween(
                        opacityEnabled: 1,
                        opacityDisabled: 0,
                        enabled: true,
                        child: RotationAnimatedWidget.tween(
                          enabled: true,
                          rotationDisabled: Rotation.deg(y: 180),
                          rotationEnabled: Rotation.deg(y: 0),
                          child: Image.asset(pokerProvider.pokerCardList[pokerProvider.newHandCard[1]]),
                        ),
                      ),
                    ),
                  ),
                  /*Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.0),
                        width: 60,
                        height: 60,
                        child: Image.asset('assets/cards/bl8.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        width: 60,
                        height: 60,
                        child: Image.asset('assets/cards/bl9.png'),
                      ),*/
                ],
              ):Container()
                  : Stack(
                children: [
                  // One Card
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.45,bottom: 15),
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
                              MediaQuery.of(context).size.width * 0.0,
                              -MediaQuery.of(context).size.height * 0.45),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 500),
                          child:Container(
                            padding: const EdgeInsets.only(bottom: 0.29, left: 2.0),
                            height: 60 + 0.29,
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(350 / 370),
                              child: OpacityAnimatedWidget.tween(
                                opacityEnabled: 1,
                                opacityDisabled: 0,
                                enabled: true,
                                child: RotationAnimatedWidget.tween(
                                  enabled: true,
                                  rotationDisabled: Rotation.deg(y: 180),
                                  rotationEnabled: Rotation.deg(y: 0),
                                  child: Image.asset('assets/cards/red_back.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Two Card
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.48,bottom: 15),
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
                              MediaQuery.of(context).size.width * 0.0,
                              -MediaQuery.of(context).size.height * 0.45),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 0.2, left: 05),
                            height: 60 + 0.1,
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(350 / 355),
                              child: OpacityAnimatedWidget.tween(
                                opacityEnabled: 1,
                                opacityDisabled: 0,
                                enabled: true,
                                child: RotationAnimatedWidget.tween(
                                  enabled: true,
                                  rotationDisabled: Rotation.deg(y: 180),
                                  rotationEnabled: Rotation.deg(y: 0),
                                  child: Image.asset('assets/cards/red_back.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
