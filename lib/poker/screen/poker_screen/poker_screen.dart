import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/poker/Sockets/poker_sockets.dart';
import 'package:rummy_game/poker/poker_provider/poker_provider.dart';
import '../poker_game/poker_game.dart';

class PokerScreen extends StatefulWidget {
  const PokerScreen({Key? key}) : super(key: key);

  @override
  State<PokerScreen> createState() => _PokerScreenState();
}

class _PokerScreenState extends State<PokerScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokerProvider>(builder: (context,pokerProvider,_){
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
                      pokerProvider.gameJoinCard(context, 'user 123', '123', '100');
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
                      if(pokerProvider.chipSliderTrueFalse == false){
                        pokerProvider.setChipSliderTrueFalse(true);
                      }else{
                        pokerProvider.setChipSliderTrueFalse(false);
                      }

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
            pokerProvider.chipSliderTrueFalse
                ?Padding(
              padding: EdgeInsets.only(right:MediaQuery.of(context).size.width * 0.05),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: MediaQuery.of(context).size.height - 50,
                  width: 40,
                  decoration: BoxDecoration(   color: Colors.white,borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                  child: FlutterSlider(
                    rtl: true,
                    trackBar: FlutterSliderTrackBar(
                      inactiveTrackBarHeight: 14,
                      activeTrackBarHeight: 10,
                      inactiveTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                        border: Border.all(width: 3, color: Colors.redAccent),
                      ),
                      activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.redAccent.withOpacity(0.5)),
                    ),
                    handler: customHandler(Icons.abc),
                    tooltip: FlutterSliderTooltip(

                        textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                        boxStyle: FlutterSliderTooltipBox(
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                                color: Colors.redAccent.withOpacity(0.7)
                            )
                        )
                    ),
                    axis: Axis.vertical,
                    values: const [0],
                    max: 100,
                    min: 0,
                  ),
                ),
              ),
            )
                :Container()
          ],
        ),
      );
    });
  }

  customHandler(IconData icon) {
    return FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Image.asset('assets/images/poker/pocker_coin.png',height: 40,width: 40,),
    );
  }

}
