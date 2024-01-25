import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:provider/provider.dart';
import 'package:rummy_game/constant/image_constants.dart';
import 'package:rummy_game/provider/rummy_provider.dart';
import 'package:rummy_game/provider/socket_provider.dart';
import 'package:rummy_game/utils/Sockets.dart';
import 'package:rummy_game/widgets/main_player/new_main_set_widget.dart';
import 'package:rummy_game/widgets/menu/animation_button_widget.dart';

class TwoPlayerTableWidget extends StatefulWidget {
  final List<bool> servedPages;
  final List<bool> jokerServedPages;
  final List<bool> jokerFlipedPages;
  final List<bool> flipedPages;
  final List<int> cardPage;

  const TwoPlayerTableWidget({
    required this.jokerFlipedPages,
    required this.jokerServedPages,
    required this.servedPages,
    required this.flipedPages,
    required this.cardPage,
  });

  @override
  State<TwoPlayerTableWidget> createState() => _TwoPlayerTableWidgetState();
}

class _TwoPlayerTableWidgetState extends State<TwoPlayerTableWidget> {
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
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            top: MediaQuery.of(context).size.height * 0.14,
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
                        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
                        child: Center(child: Text('Start Game in ${rummyProvider.countDown} Seconds...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
                      ),
                    ],
                  )
                      : Stack(
                    clipBehavior: Clip.none,
                    children: [

                      Positioned(
                          top: MediaQuery.of(context).size.height / 6.5,
                          left: MediaQuery.of(context).size.width * 0.25,
                          child: Text('Down : ${rummyProvider.totalDownCard}',style: TextStyle(color: Colors.white,fontSize: 12),)),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width * 0.234,
                        child: Container(
                          height: 65,
                          width: 65,
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width * 0.238,
                        child: Container(
                          height: 65,
                          width: 65,
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width * 0.242,
                        child: Container(
                          height: 65,
                          width: 65,
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width * 0.246,
                        child: Container(
                          height: 65,
                          width: 65,
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width * 0.25,
                        child: InkWell(
                          onTap: (){
                            if(rummyProvider.isMyTurn){
                              Sockets.socket.emit("draw","down");
                            if (kDebugMode) {
                              print('draw emit down done');
                            }}else{
                              showToast("It's not your turn,please wait for your Turn".toUpperCase(),
                                context: context,
                                animation: StyledToastAnimation.slideFromTop,
                                reverseAnimation: StyledToastAnimation.fade,
                                position: StyledToastPosition.top,
                                animDuration: const Duration(seconds: 1),
                                duration: const Duration(seconds: 4),
                                curve: Curves.elasticOut,
                                textStyle: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                                backgroundColor: Colors.red.withOpacity(0.8),
                                reverseCurve: Curves.linear,
                              );
                            }

                          },
                          child: SizedBox(
                            height: 65,
                            width: 65,
                            child: Image.asset('assets/cards/red_back.png'),
                          ),
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
                        top: MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width * 0.40,
                        child: DragTarget(
                          builder: (context, candidateData, rejectedData){
                            return Stack(
                              children: [
                                ...rummyProvider.cardListIndex.map((e) => InkWell(
                                  onTap: (){
                                    if(rummyProvider.isMyTurn){
                                        Sockets.socket.emit("draw","up");
                                        print('draw emit up done');

                                    }else{showToast("It's not your turn,please wait for your Turn".toUpperCase(),
                                      context: context,
                                      animation: StyledToastAnimation.slideFromTop,
                                      reverseAnimation: StyledToastAnimation.fade,
                                      position: StyledToastPosition.top,
                                      animDuration: const Duration(seconds: 1),
                                      duration: const Duration(seconds: 4),
                                      curve: Curves.elasticOut,
                                      textStyle: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                                      backgroundColor: Colors.red.withOpacity(0.8),
                                      reverseCurve: Curves.linear,
                                    );

                                    }
                                  },
                                  child: SizedBox(
                                    height: 65,
                                    width: 55,
                                    child: Image.asset(rummyProvider.rummyCardList[e - 1]),),
                                ),),
                                if(rummyProvider.cardListIndex.isEmpty)
                                  Container(
                                    height: 65,
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
                            print('dta     :-    ${data}');
                            if(rummyProvider.isMyTurn){
                              if(rummyProvider.newIndexData.length ==11){
                                int finishData = rummyProvider.newIndexData[int.parse(data.toString())];
                                rummyProvider.setNoDropCard(false);
                                rummyProvider.setCardListIndex(finishData -1);
                                rummyProvider.setOldCardRemove(int.parse(data.toString()));
                                rummyProvider.dropCard(int.parse(data.toString()));
                                rummyProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                                // rummyProvider.setCardUpTrue(rummyProvider.setCardUpIndex,context);
                                /*for(int i = 0; i < rummyProvider.cardList.length; i++){
                                  Map<String,dynamic> singleData = rummyProvider.cardList[i];
                                  if((i+1) == int.parse(data.toString())){
                                    rummyProvider.dropCard(int.parse(data.toString()));
                                  }
                                }
                                for(int j = 0; j < rummyProvider.newIndexData.length;j++){
                                  if(rummyProvider.newIndexData[j] == data){
                                    rummyProvider.setNewRemoveIndex(j);
                                    rummyProvider.setOneAcceptCardList(2,j);
                                  }
                                }*/
                              }else{
                                showToast("Pick Up a Card".toUpperCase(),
                                  context: context,
                                  animation: StyledToastAnimation.slideFromTop,
                                  reverseAnimation: StyledToastAnimation.fade,
                                  position: StyledToastPosition.top,
                                  animDuration: Duration(seconds: 1),
                                  duration: Duration(seconds: 4),
                                  curve: Curves.elasticOut,
                                  textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                                  backgroundColor: Colors.red.withOpacity(0.8),
                                  reverseCurve: Curves.linear,
                                );
                                rummyProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                              }
                            }else{
                              showToast("It's not your turn,please wait for your Turn".toUpperCase(),
                                context: context,
                                animation: StyledToastAnimation.slideFromTop,
                                reverseAnimation: StyledToastAnimation.fade,
                                position: StyledToastPosition.top,
                                animDuration: Duration(seconds: 1),
                                duration: Duration(seconds: 4),
                                curve: Curves.elasticOut,
                                textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                                backgroundColor: Colors.red.withOpacity(0.8),
                                reverseCurve: Curves.linear,
                              );
                              rummyProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                            }
                          },
                        ),
                      ),

                      Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width * 0.50,
                        child: DragTarget(
                          builder: (context, candidateData, rejectedData){
                            return Stack(
                              children: [
                                rummyProvider.finishCardIndex == null?
                                  Container(
                                    height: 70,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_drop_down_outlined,color: Colors.grey.withOpacity(0.5),size: 30,),
                                        Text('FINISH',style: TextStyle(color: Colors.grey.withOpacity(0.5),fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ):SizedBox(
                                  height: 65,
                                  width: 55,
                                  child: Image.asset(rummyProvider.rummyCardList[rummyProvider.finishCardIndex!]),),
                              ],
                            );
                          },
                          onAccept: (data){
                            print('dta     :-    ${data}');
                            int finishData = rummyProvider.newIndexData[int.parse(data.toString())];
                            rummyProvider.setFinishCardIndex(finishData -1);
                            rummyProvider.setOldCardRemove(int.parse(data.toString()));
                            //rummyProvider.setNewRemoveIndex(int.parse(data.toString()));
                            rummyProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                            rummyProvider.finishCard(int.parse(data.toString()));
                          },
                        ),
                      ),


                      /*Positioned(
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

                     Positioned(
                       top: MediaQuery.of(context).size.height / 4,
                       left: MediaQuery.of(context).size.width * 0.60,
                       child:  rummyProvider.sortList.length == 1
                         ? InkWell(
                       onTap: (){
                         if(rummyProvider.isMyTurn){
                           if(rummyProvider.newIndexData.length == 11){
                              rummyProvider.setOldCardRemove(rummyProvider.setCardUpIndex);
                              rummyProvider.dropCard(rummyProvider.setCardUpIndex);
                              rummyProvider.setCardUpTrue(rummyProvider.setCardUpIndex,context);
                           }
                           else{
                             showToast("Pick Up a Card".toUpperCase(),
                               context: context,
                               animation: StyledToastAnimation.slideFromTop,
                               reverseAnimation: StyledToastAnimation.fade,
                               position: StyledToastPosition.top,
                               animDuration: Duration(seconds: 1),
                               duration: Duration(seconds: 4),
                               curve: Curves.elasticOut,
                               textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                               backgroundColor: Colors.red.withOpacity(0.8),
                               reverseCurve: Curves.linear,
                             );
                           }
                         }
                         else{
                           showToast("It's not your turn,please wait for your Turn".toUpperCase(),
                             context: context,
                             animation: StyledToastAnimation.slideFromTop,
                             reverseAnimation: StyledToastAnimation.fade,
                             position: StyledToastPosition.top,
                             animDuration: const Duration(seconds: 1),
                             duration: const Duration(seconds: 4),
                             curve: Curves.elasticOut,
                             textStyle: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                             backgroundColor: Colors.red.withOpacity(0.8),
                             reverseCurve: Curves.linear,
                           );
                         }

                       },
                       child: Container(
                         height: 30,
                         decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),
                         child: const Padding(
                           padding: EdgeInsets.only(left: 20,right: 20),
                           child: Center(
                             child: Text('Drop',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                           ),
                         ),
                       ),
                     )
                         : InkWell(
                       onTap: (){
                         rummyProvider.newSetData();
                         rummyProvider.sortDataEvent(rummyProvider.listOfMap);
                         rummyProvider.checkSetSequenceData(rummyProvider.listOfMap);
                         rummyProvider.sortTrueFalse();
                         rummyProvider.isSortGroup(rummyProvider.newIndexData);
                       },
                       child: Container(
                         height: 30,
                         decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),
                         child: const Padding(
                           padding: EdgeInsets.only(left: 20,right: 20),
                           child: Center(
                             child: Text('Sort',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                           ),
                         ),
                       ),
                     ),),

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
                        // oneCardNo: widget.cardPage[0],
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
          ),
          rummyProvider.stopCountDown == 1
              ?Container():Positioned(
            top: MediaQuery.of(context).size.height * 0.04,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Image.asset(
                    ImageConst.icProfilePic1,
                    height: MediaQuery.of(context).size.height * 0.13,
                    width:  MediaQuery.of(context).size.width * 0.06,
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
