import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/tooltip/tooltip_box.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/custom_dialog/exit_dialog.dart';
import 'package:rummy_game/poker/poker_provider/poker_provider.dart';
import '../poker_game/poker_game.dart';

class PokerScreen extends StatefulWidget {
  const PokerScreen({Key? key}) : super(key: key);

  @override
  State<PokerScreen> createState() => _PokerScreenState();
}

class _PokerScreenState extends State<PokerScreen> {

  double _currentSliderValue = 0;
  double _TotalSliderValue = 100;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  Future<bool> _willPopCallback() async {
    ExitDialog(
        title: 'Quit Game',
        message: "Quiting On Going Game In The Middle Results",
        leftButton: 'Cancel',
        rightButton: 'Exit',
        onTapLeftButton: () {
          Provider.of<PokerProvider>(context,listen: false).disconnectSocket(context);
          Navigator.pop(context);
        },
        onTapRightButton: () {

        },
        gameId: '1234'
    ).show(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokerProvider>(builder: (context,pokerProvider,_){
      return Scaffold(
        body: WillPopScope(
          onWillPop: _willPopCallback,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset('assets/images/poker/poker_backgroud.jpg',fit: BoxFit.fill,),
              ),

              const PokerGameScreen(),
              // Padding(
              //   padding: const EdgeInsets.only(right: 20,left: 20,bottom: 5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       InkWell(
              //         onTap:(){
              //           pokerProvider.gameJoinCard(context, 'user 123', '123', '100','1234');
              //         },
              //         child: Stack(
              //           alignment: Alignment.center,
              //           children: [
              //             Image.asset("assets/images/pokerFoldSwitchButton.png"),
              //             const Text("FOLD & SWITCH",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
              //           ],
              //         ),
              //       ),
              //       InkWell(
              //         onTap:(){
              //           pokerProvider.gameJoinCard(context,'User 1','123','100','1234');
              //         },
              //         child: Stack(
              //           alignment: Alignment.center,
              //           children: [
              //             Image.asset("assets/images/pokerCheckButton.png"),
              //             const Text("CHECK",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
              //           ],
              //         ),
              //       ),
              //       InkWell(
              //         onTap:(){
              //           if(pokerProvider.chipSliderTrueFalse == false){
              //             pokerProvider.setChipSliderTrueFalse(true);
              //           }else{
              //             pokerProvider.setChipSliderTrueFalse(false);
              //           }
              //
              //         },
              //         child: Stack(
              //           alignment: Alignment.center,
              //           children: [
              //             Image.asset("assets/images/pokerFoldCheckButton.png"),
              //             const Text("FOLD & CHECK",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
              //           ],
              //         ),
              //       ),
              //       InkWell(
              //         onTap:(){
              //         },
              //         child: Stack(
              //           alignment: Alignment.center,
              //           children: [
              //             Image.asset("assets/images/pokerCallButton.png"),
              //             const Text("CHECK & CALL ANY",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.black),),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              pokerProvider.isMyTurn
                  ?Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.separated(
                    separatorBuilder: (context,index){
                      return SizedBox(width: MediaQuery.of(context).size.width * 0.25,);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                      itemCount: pokerProvider.callButtonList.length,
                      itemBuilder: (context,index){
                    return InkWell(
                                onTap:(){
                                  if(pokerProvider.callButtonList[index].toUpperCase() == "CALL"){
                                    pokerProvider.setCallBet(pokerProvider.callChips.toString());
                                    pokerProvider.playerActionCard(context, pokerProvider.callButtonList[index],pokerProvider.callChips.toString());
                                  }else if(pokerProvider.callButtonList[index].toUpperCase() == "BET"){
                                    setState(() {
                                      _currentSliderValue = double.parse(double.parse(pokerProvider.callChips).toStringAsFixed(2));
                                      _TotalSliderValue = double.parse(double.parse(pokerProvider.totalBetChips).toStringAsFixed(2));
                                    });
                                    if(pokerProvider.chipSliderTrueFalse == false){
                                      pokerProvider.setChipSliderTrueFalse(true);
                                    }else{
                                      pokerProvider.setChipSliderTrueFalse(false);
                                    }
                                  }else if(pokerProvider.callButtonList[index].toUpperCase() == "ALLIN"){
                                    pokerProvider.playerActionCard(context, pokerProvider.callButtonList[index],double.parse(pokerProvider.totalBetChips.toString()).toStringAsFixed(2));
                                    pokerProvider.setCallBet(double.parse(pokerProvider.totalBetChips.toString()).toStringAsFixed(2));
                                  }else if(pokerProvider.callButtonList[index].toUpperCase() == "CALL"){
                                    pokerProvider.setCallBet('0.0');
                                    pokerProvider.playerActionCard(context, pokerProvider.callButtonList[index],'0.0');
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(pokerProvider.buttonImage[index]),
                                    Text(pokerProvider.callButtonList[index].toUpperCase(),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                                  ],
                                ),
                              );
                  }),
                ),
              ):Container(),

              if (pokerProvider.chipSliderTrueFalse)
                Row(
                    children: [
                      Expanded(child: InkWell(
                          onTap: (){
                            pokerProvider.setChipSliderTrueFalse(false);
                          },
                          child: Container())),
                      Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.18,),
                          Container(
                            height: 90,width: 45,decoration: BoxDecoration(color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                          child:  Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  if(_currentSliderValue !=100.0){
                                    setState(() {
                                      _currentSliderValue += 1.0;
                                    });
                                  }
                                },
                                child: const SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Icon(Icons.add,color: Colors.red,)),
                              ),
                              const Divider(color: Colors.red,),
                              InkWell(
                                onTap: (){
                                  if(_currentSliderValue != 0.0){
                                    setState(() {
                                      _currentSliderValue -= 1.0;
                                    });
                                  }
                                },
                                child: const SizedBox(
                                    height: 30,
                                    width: 40,
                                    child: Icon(Icons.minimize_sharp,color: Colors.red,)),
                              ),
                            ],
                          ),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            width: 45,decoration: BoxDecoration(color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    double data = _currentSliderValue;

                                    if(_currentSliderValue != 100.0){

                                      data *= 2.0;
                                      if(data < 100.0){
                                        setState(() {
                                          _currentSliderValue = data;
                                        });
                                      }

                                    }
                                  },
                                  child: const SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Center(child: Text('2X',style: TextStyle(color: Colors.red),))),
                                ),
                                const Divider(color: Colors.red,),
                                InkWell(
                                  onTap: (){
                                    double data = _currentSliderValue;

                                    if(_currentSliderValue != 100.0){

                                      data *= 3.0;
                                      if(data < 100.0){
                                        setState(() {
                                          _currentSliderValue = data;
                                        });
                                      }

                                    }
                                  },
                                  child: const SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Center(child: Text('3X',style: TextStyle(color: Colors.red),))),
                                ),
                                const Divider(color: Colors.red,),
                                InkWell(
                                  onTap: (){
                                    double data = _currentSliderValue;

                                    if(_currentSliderValue != 100.0){

                                        data *= 4.0;
                                        if(data < 100.0){
                                          setState(() {
                                          _currentSliderValue = data;
                                          });
                                        }

                                    }
                                  },
                                  child: const SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Center(child: Text('4X',style: TextStyle(color: Colors.red),))),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            height: 40,width: 45,decoration: BoxDecoration(color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                            child:  InkWell(
                              onTap: (){
                                pokerProvider.setChipSliderTrueFalse(false);
                                pokerProvider.setCallBet(_currentSliderValue.toString());
                                pokerProvider.playerActionCard(context, 'bet', _currentSliderValue.toString());
                              },
                              child: const SizedBox(
                                  height: 45,
                                  width: 40,
                                  child: Center(child: Text('BET',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 04,),
                      Padding(
                                    padding: EdgeInsets.only(right:MediaQuery.of(context).size.width * 0.05),
                                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                          Container(
                            height:40,
                            width: 40,
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.7),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                            child:  Center(child: Text(_currentSliderValue.toString(),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.80,
                            width: 40,
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.7),borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                            child: FlutterSlider(
                              step: const FlutterSliderStep(step: 0.1),
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
                                    color: Colors.redAccent),
                              ),
                              handler: customHandler(Icons.abc),
                              tooltip: FlutterSliderTooltip(
                                  /*format: (value){
                                    return value.split('.')[0];
                                  },*/
                                  textStyle: const TextStyle(fontSize: 14, color: Colors.red,fontWeight: FontWeight.bold),
                                  boxStyle: FlutterSliderTooltipBox(
                                      decoration: BoxDecoration(
                                          borderRadius:BorderRadius.circular(10),
                                          color: Colors.white
                                      )
                                  )
                              ),
                              axis: Axis.vertical,
                              max: _TotalSliderValue,
                              min: 0, values: [_currentSliderValue],
                              onDragging: (handlerIndex, lowerValue, upperValue){
                                setState(() {
                                  _currentSliderValue = lowerValue;
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                                    ),
                                  ),
                    ],
                  )
              else Container(),
            ],
          ),
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
