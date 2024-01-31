import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:provider/provider.dart';
import 'package:rummy_game/constant/image_constants.dart';

import 'package:rummy_game/provider/socket_provider.dart';
import 'package:rummy_game/utils/Sockets.dart';
import 'package:rummy_game/widgets/main_player/new_main_set_widget.dart';

class FivePlayerTableWidget extends StatefulWidget {
  final List<bool> servedPages;
  final List<bool> flipedPages;
  final List<int> cardPage;

  const FivePlayerTableWidget({super.key,
    required this.servedPages,
    required this.flipedPages,
    required this.cardPage,
  });

  @override
  State<FivePlayerTableWidget> createState() => _FivePlayerTableWidgetState();
}

class _FivePlayerTableWidgetState extends State<FivePlayerTableWidget> {

  @override
  void initState() {
    super.initState();
    var socketProvider = Provider.of<SocketProvider>(context,listen: false);
    socketProvider.setCardUpFalse();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(builder: (context,socketProvider,_){
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
              child: socketProvider.stopCountDown == 1
                  ? Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
                    child: Center(child: Text('Start Game in ${socketProvider.countDown} Seconds...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
                  ),
                ],
              )
                  : Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [

                  Positioned(
                      top: MediaQuery.of(context).size.height / 6.5,
                      left: MediaQuery.of(context).size.width * 0.25,
                      child: Text('Down : ${socketProvider.totalDownCard}',style: TextStyle(color: Colors.white,fontSize: 12),)),
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
                        if(socketProvider.isMyTurn){
                          if(socketProvider.isSortTrueFalse){
                            socketProvider.sortTrueFalse();
                            Sockets.socket.emit("draw","down");
                          }else{
                            Sockets.socket.emit("draw","down");
                          }
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

                  // Player
                  Positioned(
                    top: 20.0,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Image.asset(
                            ImageConst.icProfilePic2,
                            height: MediaQuery.of(context).size.height * 0.13,
                            width:  MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                  Positioned(
                    bottom: 70.0,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Image.asset(
                            ImageConst.icProfilePic5,
                            height: MediaQuery.of(context).size.height * 0.13,
                            width:  MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 70.0,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Image.asset(
                            ImageConst.icProfilePic2,
                            height: MediaQuery.of(context).size.height * 0.13,
                            width:  MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ],
                    ),
                  ),


                  Positioned(
                    top: MediaQuery.of(context).size.height / 5,
                    left: MediaQuery.of(context).size.width * 0.40,
                    child: DragTarget(
                      builder: (context, candidateData, rejectedData){
                        return Stack(
                          children: [
                            ...socketProvider.cardListIndex.map((e) => InkWell(
                              onTap: (){
                                if(socketProvider.isMyTurn){
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
                                child: Image.asset(socketProvider.rummyCardList[e - 1]),),
                            ),),
                            if(socketProvider.cardListIndex.isEmpty)
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
                        if(socketProvider.isMyTurn){
                          if(socketProvider.newIndexData.length ==11){
                            int finishData = socketProvider.newIndexData[int.parse(data.toString())];
                            socketProvider.setNoDropCard(false);
                            socketProvider.setCardListIndex(finishData -1);
                            socketProvider.setOldCardRemove(int.parse(data.toString()));
                            socketProvider.dropCard(int.parse(data.toString()));
                            socketProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                            // socketProvider.setCardUpTrue(socketProvider.setCardUpIndex,context);
                            /*for(int i = 0; i < socketProvider.cardList.length; i++){
                                  Map<String,dynamic> singleData = socketProvider.cardList[i];
                                  if((i+1) == int.parse(data.toString())){
                                    socketProvider.dropCard(int.parse(data.toString()));
                                  }
                                }
                                for(int j = 0; j < socketProvider.newIndexData.length;j++){
                                  if(socketProvider.newIndexData[j] == data){
                                    socketProvider.setNewRemoveIndex(j);
                                    socketProvider.setOneAcceptCardList(2,j);
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
                            socketProvider.setOneAcceptCardList(2,int.parse(data.toString()));
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
                          socketProvider.setOneAcceptCardList(2,int.parse(data.toString()));
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
                            socketProvider.finishCardIndex == null?
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
                              child: Image.asset(socketProvider.rummyCardList[socketProvider.finishCardIndex!]),),
                          ],
                        );
                      },
                      onAccept: (data){
                        print('dta     :-    ${data}');
                        int finishData = socketProvider.newIndexData[int.parse(data.toString())];
                        socketProvider.setFinishCardIndex(finishData -1);
                        socketProvider.setOldCardRemove(int.parse(data.toString()));
                        //socketProvider.setNewRemoveIndex(int.parse(data.toString()));
                        socketProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                        socketProvider.finishCard(int.parse(data.toString()));
                      },
                    ),
                  ),

                  Positioned(
                    top: MediaQuery.of(context).size.height / 4,
                    left: MediaQuery.of(context).size.width * 0.60,
                    child:  socketProvider.sortList.length == 1
                        ? InkWell(
                      onTap: (){
                        if(socketProvider.isMyTurn){
                          if(socketProvider.newIndexData.length == 11){
                            socketProvider.setOldCardRemove(socketProvider.setCardUpIndex);
                            socketProvider.dropCard(socketProvider.setCardUpIndex);
                            socketProvider.setCardUpTrue(socketProvider.setCardUpIndex,context);
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
                        socketProvider.newSetData();
                        socketProvider.sortDataEvent(socketProvider.listOfMap);
                        socketProvider.checkSetSequenceData(socketProvider.listOfMap);
                        socketProvider.sortTrueFalse();
                        socketProvider.isSortGroup(socketProvider.newIndexData);
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
      );
    });
  }
}
