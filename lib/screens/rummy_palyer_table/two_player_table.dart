import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/image_constants.dart';
import 'package:rummy_game/provider/socket_provider.dart';
import 'package:rummy_game/utils/Sockets.dart';
import 'package:rummy_game/widgets/main_player/new_main_set_widget.dart';

class TwoPlayerTableWidget extends StatefulWidget {
  final List<bool> servedPages;

  final List<bool> flipedPages;
  final List<int> cardPage;

  const TwoPlayerTableWidget({
    super.key,

    required this.servedPages,
    required this.flipedPages,
    required this.cardPage,
  });

  @override
  State<TwoPlayerTableWidget> createState() => _TwoPlayerTableWidgetState();
}

class _TwoPlayerTableWidgetState extends State<TwoPlayerTableWidget> {

  @override
  void initState() {
    super.initState();
    var socketProvider = Provider.of<SocketProvider>(context,listen: false);
    socketProvider.setCardUpFalse();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(builder: (context,socketProvider,_){
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
                  child: socketProvider.stopCountDown == 1
                      ? Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
                        child: Center(child: Text('Start Game in ${socketProvider.countDown} Seconds...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
                      ),
                    ],
                  )
                      : Stack(
                    clipBehavior: Clip.none,
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

                              if(socketProvider.isNewSortTrueFalseNew){

                                List removeData = [];
                                int dropCardIndex = 0;
                                for(int i = 0;i< socketProvider.newSortListGroupData.length;i++){
                                  if(socketProvider.newSortListGroupData[i] !=100){
                                    removeData.add(socketProvider.newSortListGroupData[i]);
                                  }
                                }
                                print('finifh   L_----:-  ${removeData.length} ........${data}.... ${socketProvider.isAcceptCardList}');
                                if(removeData.length ==11){
                                    int finishData = socketProvider.newSortListGroupData[int.parse(data.toString())];
                                    print('Print Data a a :-  ${finishData}');
                                    for(int i = 0;i< socketProvider.newIndexData.length ;i++){
                                      if(socketProvider.newIndexData[i] == finishData){
                                        dropCardIndex = i;
                                      }
                                    }
                                    socketProvider.setNoDropCard(false);
                                    socketProvider.setCardListIndex(finishData);
                                    socketProvider.setOldCardSortRemove(int.parse(data.toString()));
                                    socketProvider.dropCard(int.parse(dropCardIndex.toString()));
                                    socketProvider.setOneAcceptHandCardList(2,int.parse(data.toString()));
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
                                  socketProvider.setOneAcceptHandCardList(2,int.parse(data.toString()));
                                }
                              }else{
                                print('finifh  ........ ${socketProvider.isAcceptCardList}');
                                if(socketProvider.newIndexData.length ==11){
                                  if(socketProvider.isSortTrueFalse == true){
                                    int finishData = socketProvider.newSort[int.parse(data.toString())];
                                    socketProvider.setNoDropCard(false);
                                    socketProvider.setCardListIndex(finishData);
                                    socketProvider.setOldCardHandRemove(int.parse(data.toString()));
                                    socketProvider.dropCard(int.parse(data.toString()));
                                    socketProvider.setOneAcceptHandCardList(2,int.parse(data.toString()));
                                  }else{
                                    if(socketProvider.isNewSortTrueFalseNew == false){
                                      int finishData = socketProvider.newSortListGroupData[int.parse(data.toString())];
                                      print('finifh   L_----:-  $finishData');
                                      socketProvider.setNoDropCard(false);
                                      socketProvider.setCardListIndex(finishData);
                                      socketProvider.setOldCardSortRemove(int.parse(data.toString()));
                                      socketProvider.dropCard(int.parse(data.toString()));
                                      socketProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                                    }else{
                                      int finishData = socketProvider.newIndexData[int.parse(data.toString())];
                                      socketProvider.setNoDropCard(false);
                                      socketProvider.setCardListIndex(finishData);
                                      socketProvider.setOldCardRemove(int.parse(data.toString()));
                                      socketProvider.dropCard(int.parse(data.toString()));
                                      socketProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                                    }
                                  }
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
                                  socketProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                                }
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
                         socketProvider.setSortData();
                         List<int> dataValue =[];
                         int intValue =0;
                         int? finaIntValue;
                         intValue = socketProvider.GroupData[socketProvider.setCardUpIndex];

                         dataValue = socketProvider.GroupData;

                         for(int i = 0; i< dataValue.length;i++){
                            // dataValue.remove(100);
                         }

                         for(int i = 0;i<socketProvider.newIndexData.length;i++){
                           if(socketProvider.newIndexData[i] == intValue){
                             finaIntValue = i;
                           }
                         }

                         if(socketProvider.isMyTurn){
                           if(socketProvider.newIndexData.length == 11){
                              if(socketProvider.isNewSortTrueFalseNew == false){
                                socketProvider.setOldSortCardRemove(socketProvider.setCardUpIndex);
                                socketProvider.dropCard(finaIntValue ??0);
                                socketProvider.setCardUpTrue(socketProvider.setCardUpIndex,context);
                              }else{
                                socketProvider.setOldCardRemove(socketProvider.setCardUpIndex);
                                socketProvider.dropCard(socketProvider.setCardUpIndex);
                                socketProvider.setCardUpTrue(socketProvider.setCardUpIndex,context);
                              }
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
                         :  socketProvider.sortList.length >= 2
                           ? InkWell(
                         onTap: (){
                           // if(socketProvider.isNewSortTrueFalseNew == false){
                           //
                           //   socketProvider.setNewSortTrueFalse(true);
                           // }

                           socketProvider.setNewGroupData();

                       },
                         child: Container(
                         height: 30,
                         decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),
                         child: const Padding(
                           padding: EdgeInsets.only(left: 20,right: 20),
                           child: Center(
                             child: Text('Group',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                           ),
                         ),
                       ),):
                       socketProvider.isNewSortTrueFalseNew
                           ? Container()
                           : InkWell(
                         onTap: (){


                           if(socketProvider.isNewSortTrueFalseNew == false){
                             // socketProvider.setNewGroupData();

                             socketProvider.setNewSortTrueFalse(true);


                             // socketProvider.setNewSortListData();
                             /* socketProvider.newSetData();
                          socketProvider.sortDataEvent(socketProvider.listOfMap);
                          Future.delayed(const Duration(milliseconds: 500),(){
                            socketProvider.checkSetSequenceData(socketProvider.listOfMap);
                            socketProvider.sortTrueFalse();
                            socketProvider.isSortGroup(socketProvider.newIndexData);
                          });*/
                           }else{
                             // socketProvider.setNewSortTrueFalse(false);
                           }
                         },
                         child: Container(
                           height: 30,
                           decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),
                           child:  const Padding(
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Center(
                               child: Text('Sort',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                             ),
                           ),
                         ),
                       )),

                      NewPlayer3SeatWidget(
                        userProfileImage: ImageConst.icProfilePic3,
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
          socketProvider.stopCountDown == 1
              ?Container():Positioned(
            top: MediaQuery.of(context).size.height * 0.04,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 2.0),
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
