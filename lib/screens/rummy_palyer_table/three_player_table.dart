import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rummy_game/constant/image_constants.dart';
import 'package:rummy_game/provider/rummy_provider.dart';
import 'package:rummy_game/provider/socket_provider.dart';
import 'package:rummy_game/utils/Sockets.dart';
import 'package:rummy_game/widgets/main_player/new_main_set_widget.dart';
class ThreePlayerTableWidget extends StatefulWidget {
  final List<bool> servedPages;
  final List<bool> jokerServedPages;
  final List<bool> jokerFlipedPages;
  final List<bool> flipedPages;
  final List<int> cardPage;

  const ThreePlayerTableWidget({
    required this.jokerFlipedPages,
    required this.jokerServedPages,
    required this.servedPages,
    required this.flipedPages,
    required this.cardPage,
  });

  @override
  State<ThreePlayerTableWidget> createState() => _ThreePlayerTableWidgetState();
}

class _ThreePlayerTableWidgetState extends State<ThreePlayerTableWidget> {
  List<bool> _moveOldServedPages = [];
  List<bool> _moveOldFlipedPages = [];
  Timer? moveOldServingTimer;
  Timer? moveOldFlipingTimer;

  @override
  void initState() {
    super.initState();
    var rummyProvider = Provider.of<RummyProvider>(context,listen: false);
    rummyProvider.setCardUpFalse();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<RummyProvider,SocketProvider>(builder: (context,rummyProvider,socketProvider,_){
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
              child: rummyProvider.stopCountDown == 1
                  ? Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
                    child: Center(child: Text('Start Game in ${rummyProvider.countDown} Seconds...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
                  ),
                ],
              )
                  : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [

                  Positioned(
                      top: 09.5,
                      left: 51.0,
                      child: Text('Down : ${rummyProvider.totalDownCard}',style: TextStyle(color: Colors.white,fontSize: 12),)),
                  Positioned(
                    top: 12.0,
                    left: 50.0,
                    child: Container(
                      height: 65,
                      width: 65,
                      child: Image.asset('assets/cards/red_back.png'),
                    ),
                  ),
                  Positioned(
                    top: 12.0,
                    left: 50.50,
                    child: Container(
                      height: 65,
                      width: 65,
                      child: Image.asset('assets/cards/red_back.png'),
                    ),
                  ),
                  Positioned(
                    top: 12.0,
                    left: 51.0,
                    child: Container(
                      height: 65,
                      width: 65,
                      child: Image.asset('assets/cards/red_back.png'),
                    ),
                  ),
                  Positioned(
                    top: 12.0,
                    left: 51.50,
                    child: Container(
                      height: 65,
                      width: 65,
                      child: Image.asset('assets/cards/red_back.png'),
                    ),
                  ),
                  Positioned(
                    top: 12.0,
                    left: 52.0,
                    child: InkWell(
                      onTap: (){
                        Sockets.socket.emit("draw","down");
                        print('draw emit down done');
                      },
                      child: Container(
                        height: 65,
                        width: 65,
                        child: Image.asset('assets/cards/red_back.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    right: 0.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Image.asset(
                            ImageConst.icProfilePic2,
                            height: 8.3,
                            width: 8.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 0.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Image.asset(
                            ImageConst.icProfilePic1,
                            height: 8.3,
                            width: 8.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Joker Card

                  // Positioned(
                  //   top: 12.0,
                  //   left: 30.0,
                  //   child: Container(
                  //     child: SizeAnimatedWidget.tween(
                  //       enabled: widget.jokerServedPages[0],
                  //       duration: const Duration(milliseconds: 200),
                  //       sizeEnabled: Size(15.5, 20.0),
                  //       sizeDisabled: Size(0, 0),
                  //       curve: Curves.ease,
                  //       child: TranslationAnimatedWidget.tween(
                  //         enabled: widget.jokerServedPages[0],
                  //         delay: const Duration(milliseconds: 500),
                  //         translationEnabled: const Offset(0, 0),
                  //         translationDisabled: Offset(0, -(50.0)),
                  //         curve: Curves.ease,
                  //         duration: const Duration(milliseconds: 200),
                  //         child: RummyJokerCardWidget(
                  //           jokerCardFliped: widget.jokerFlipedPages[0],
                  //           opacityEnabled: 1,
                  //           opacityDisabled: 0,
                  //           jokerCard: widget.cardPage[12],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 12.0,
                  //   left: 30.0,
                  //   child: Container(
                  //     alignment: Alignment.bottomLeft,
                  //     child: SizeAnimatedWidget.tween(
                  //       enabled: widget.jokerServedPages[0],
                  //       duration: const Duration(milliseconds: 200),
                  //       sizeEnabled: Size(15.5, 20.0),
                  //       sizeDisabled: Size(0, 0),
                  //       curve: Curves.ease,
                  //       child: TranslationAnimatedWidget.tween(
                  //         enabled: widget.jokerServedPages[0],
                  //         delay: const Duration(milliseconds: 500),
                  //         translationEnabled: const Offset(0, 0),
                  //         translationDisabled: Offset(18.0, 0.0),
                  //         curve: Curves.ease,
                  //         duration: const Duration(milliseconds: 200),
                  //         child: RummyJokerCardWidget(
                  //           jokerCardFliped: widget.jokerFlipedPages[0],
                  //           opacityEnabled: 0,
                  //           opacityDisabled: 1,
                  //           jokerCard: 53,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Positioned(
                    top: 12.0,
                    left: 70.0,
                    child: DragTarget(
                      builder: (context, candidateData, rejectedData){
                        return Stack(
                          children: [
                            ...rummyProvider.cardListIndex.map((e) => InkWell(
                              onTap: (){
                                Sockets.socket.emit("draw","up");
                                print('draw emit up done');
                              },
                              child: Container(
                                height: 68,
                                width: 55,
                                child: Image.asset('assets/cards/red_back.png')),
                            ),),
                            if(rummyProvider.cardListIndex.isEmpty)
                              Container(
                                height: 68,
                                width: 55,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              )
                          ],
                        );
                      },
                      onAccept: (data){
                        rummyProvider.setCardListIndex(int.parse(data.toString()));
                        for(int i = 0; i < rummyProvider.cardList.length; i++){
                          Map<String,dynamic> singleData = rummyProvider.cardList[i];
                          if((i+1) == int.parse(data.toString())){
                            rummyProvider.dropCard(int.parse(data.toString()));
                          }
                        }
                        for(int j = 0; j < rummyProvider.newIndexData.length;j++){
                          print('New ******  :-  $data  :-   ${rummyProvider.newIndexData}');
                          if(rummyProvider.newIndexData[j] == data){
                            rummyProvider.setNewRemoveIndex(j);
                            rummyProvider.setOneAcceptCardList(2,j);
                          }
                        }
                      },
                    ),
                  ),

                  /*Positioned(
                      top: 12.0.h,
                      left: 90.0,
                      child: Container(
                        height: 68,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Colors.blackithOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: Text('Finish',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),
                      )),

                  Positioned(
                      top: 13.5.h,
                      left: 110.0,
                      child: InkWell(
                        onTap: (){
                          // rummyProvider.setSortAllCard();
                          rummyProvider.checkSetSequenceData(rummyProvider.reArrangeData);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Colors.blackithOpacity(0.5),
                          elevation: 10,
                          child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.blackithOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text('Sort',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),)),
                          ),
                        ),
                      )),*/

                  NewPlayer3SeatWidget(
                    userProfileImage: ImageConst.icProfilePic3,
                    // oneCardServed: widget.servedPages[0],
                    // twoCardServed: widget.servedPages[1],
                    // threeCardServed: widget.servedPages[2],
                    // fourCardServed: widget.servedPages[3],
                    // fiveCardServed: widget.servedPages[4],
                    // sixCardServed: widget.servedPages[5],
                    // sevenCardServed: widget.servedPages[6],
                    // eightCardServed: widget.servedPages[7],
                    // nineCardServed: widget.servedPages[8],
                    // tenCardServed: widget.servedPages[9],
                    // oneCardFliped: widget.flipedPages[9],
                    // twoCardFliped: widget.flipedPages[8],
                    // threeCardFliped: widget.flipedPages[7],
                    // fourCardFliped: widget.flipedPages[6],
                    // fiveCardFliped: widget.flipedPages[5],
                    // sixCardFliped: widget.flipedPages[4],
                    // sevenCardFliped: widget.flipedPages[3],
                    // eightCardFliped: widget.flipedPages[2],
                    // nineCardFliped: widget.flipedPages[1],
                    // tenCardFliped: widget.flipedPages[0],
                    // // oneCardNo: widget.cardPage[0],
                    // twoCardNo: widget.cardPage[1],
                    // threeCardNo: widget.cardPage[2],
                    // fourCardNo: widget.cardPage[3],
                    // fiveCardNo: widget.cardPage[4],
                    // sixCardNo: widget.cardPage[5],
                    // sevenCardNo: widget.cardPage[6],
                    // eightCardNo: widget.cardPage[7],
                    // nineCardNo: widget.cardPage[8],
                    // tenCardNo: widget.cardPage[9],
                    // jokerCardFliped: widget.jokerFlipedPages[0],
                    // jokerCardNo: widget.cardPage[0],
                    // jokerCardServed: widget.jokerServedPages[0],
                    Served: widget.servedPages,
                    Fliped: widget.flipedPages,
                    CardNo: widget.cardPage,
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
