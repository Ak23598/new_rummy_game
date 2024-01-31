import 'package:flutter/material.dart';
import '../poker_game/poker_game.dart';

class PokerScreen extends StatefulWidget {
  const PokerScreen({Key? key}) : super(key: key);

  @override
  State<PokerScreen> createState() => _PokerScreenState();
}

class _PokerScreenState extends State<PokerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset('assets/images/poker/poker_backgroud.jpg',fit: BoxFit.fill,),
          ),
          const PokerGameScreen(),

          Padding(
            padding: const EdgeInsets.only(right: 20,left: 20,bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:(){
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/images/pokerFoldSwitchButton.png"),
                      const Text("FOLD & SWITCH",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                ),
                InkWell(
                  onTap:(){
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/images/pokerCheckButton.png"),
                      const Text("CHECK",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                ),
                InkWell(
                  onTap:(){
                    print("********** ");
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/images/pokerFoldCheckButton.png"),
                      const Text("FOLD & CHECK",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                ),
                InkWell(
                  onTap:(){
                    print("********** ");
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/images/pokerCallButton.png"),
                      const Text("CHECK & CALL ANY",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
