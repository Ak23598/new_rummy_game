import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/custom_dialog/finish_dialog.dart';
import 'package:rummy_game/constant/image_constants.dart';
import 'package:rummy_game/provider/socket_provider.dart';
import 'package:rummy_game/utils/Sockets.dart';
import 'package:rummy_game/widgets/main_player/new_main_set_widget.dart';

class TwoPlayerTableWidget extends StatefulWidget {
  String gameId;
   TwoPlayerTableWidget({super.key,required this.gameId});

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
      return socketProvider.playerCount == 1
          ?Positioned(
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
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
      child: Center(child: Text('Start Game in ${socketProvider.countDown} Seconds...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
      ),
      ],
      )
          : Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
      Container(
      height: 40,
      width: double.infinity,
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent,Colors.grey,Colors.transparent])),
      child: const Center(child: Text('Not Joining Another Player...',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),),
      ),
      ],
      ),
      )
      ],
      ),
      )
          :Stack(
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
                        child: SizedBox(
                          height: 65,
                          width: 65,
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width * 0.246,
                        child: SizedBox(
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
                            if(socketProvider.isNewDataMyTurn){
                                Sockets.socket.emit("draw","down");
                            }else{
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
                                    if(socketProvider.isNewDataMyTurn){
                                        Sockets.socket.emit("draw","up");

                                    }else{
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

                            print('  Local data :-  ${data}');

                            if(socketProvider.isNewDataMyTurn){



                              if(socketProvider.isNewSortTrueFalseNew){

                                List removeData = [];
                                int dropCardIndex = 0;
                                for(int i = 0;i< socketProvider.newSortListGroupData.length;i++){
                                  if(socketProvider.newSortListGroupData[i] !=100){
                                    removeData.add(socketProvider.newSortListGroupData[i]);
                                  }
                                }
                                if(removeData.length ==11){
                                    int finishData = socketProvider.newSortListGroupData[int.parse(data.toString())];
                                    for(int i = 0;i< socketProvider.newIndexData.length ;i++){
                                      if(socketProvider.newIndexData[i] == finishData){
                                        dropCardIndex = i;
                                      }
                                    }

                                    print('datadatadat  1 :-  ${finishData}');
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
                              }
                              else if(socketProvider.noSortGroupFalse){
                                List removeData = [];
                                int dropCardIndex = 0;
                                for(int i = 0;i< socketProvider.noNewSortListGroupData.length;i++){
                                  if(socketProvider.noNewSortListGroupData[i] !=100){
                                    removeData.add(socketProvider.noNewSortListGroupData[i]);
                                  }
                                }
                                if(removeData.length ==11){
                                  int finishData = socketProvider.noNewSortListGroupData[int.parse(data.toString())];
                                  for(int i = 0;i< socketProvider.newIndexData.length ;i++){
                                    if(socketProvider.newIndexData[i] == finishData){
                                      dropCardIndex = i;
                                    }
                                  }
                                  print('datadatadat  2:-  ${finishData}');
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
                              }
                              else{
                                if(socketProvider.newIndexData.length ==11){
                                  if(socketProvider.isSortTrueFalse == true){
                                    int finishData = socketProvider.newSort[int.parse(data.toString())];
                                    print('datadatadat  3:-  ${finishData}');
                                    socketProvider.setNoDropCard(false);
                                    socketProvider.setCardListIndex(finishData);
                                    socketProvider.setOldCardHandRemove(int.parse(data.toString()));
                                    socketProvider.dropCard(int.parse(data.toString()));
                                    socketProvider.setOneAcceptHandCardList(2,int.parse(data.toString()));
                                  }else{
                                    if(socketProvider.isNewSortTrueFalseNew == true){
                                      int finishData = socketProvider.newSortListGroupData[int.parse(data.toString())];

                                      print('datadatadat  4:-  ${finishData}');
                                      socketProvider.setNoDropCard(false);
                                      socketProvider.setCardListIndex(finishData);
                                      socketProvider.setOldCardSortRemove(int.parse(data.toString()));
                                      socketProvider.dropCard(int.parse(data.toString()));
                                      socketProvider.setOneAcceptCardList(2,int.parse(data.toString()));
                                    }else{
                                      int finishData = socketProvider.newIndexData[int.parse(data.toString())];

                                      print('datadatadat  5:-  ${finishData}');
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

                            if(socketProvider.isNewDataMyTurn) {
                             if(socketProvider.newIndexData.length == 11){
                               if(socketProvider.isNewSortTrueFalseNew == true) {
                                 List<int> dataValue =[];
                                 int? intNewValue;
                                 int? finaIntValue;

                                 intNewValue = socketProvider.noNewSortListGroupData[int.parse(data.toString())];

                                 for(int i = 0;i< socketProvider.newIndexData.length;i++){
                                   dataValue.add(socketProvider.newIndexData[i]);
                                   if(socketProvider.newIndexData[i] == intNewValue){
                                     finaIntValue = i;
                                   }
                                 }


                                 FinishDialog(
                                   title: 'Finish Game',
                                   message: "Are you sure you want to finish this game ?",
                                   leftButton: 'Cancel',
                                   rightButton: 'Exit',
                                   onTapLeftButton: () {
                                     int finishData = socketProvider.newIndexData[int.parse(finaIntValue.toString())];
                                     socketProvider.setFinishCardIndex(finishData - 1);
                                     socketProvider.setCardUpTrue(int.parse(data.toString()),context);
                                     socketProvider.setOneAcceptCardList(2, int.parse(data.toString()));
                                     socketProvider.finishCard(int.parse(finaIntValue.toString()),context,widget.gameId);
                                     Navigator.pop(context);
                                   },
                                   onTapRightButton: () {

                                   },
                                 ).show(context);


                               }
                               else if(socketProvider.noSortGroupFalse == true){
                                 List<int> dataValue =[];
                                 int? intNewValue;
                                 int? finaIntValue;

                                 intNewValue = socketProvider.noNewSortListGroupData[int.parse(data.toString())];

                                 for(int i = 0;i< socketProvider.newIndexData.length;i++){
                                   dataValue.add(socketProvider.newIndexData[i]);
                                   if(socketProvider.newIndexData[i] == intNewValue){
                                     finaIntValue = i;
                                   }
                                 }


                                 FinishDialog(
                                   title: 'Finish Game',
                                   message: "Are you sure you want to finish this game ?",
                                   leftButton: 'Cancel',
                                   rightButton: 'Exit',
                                   onTapLeftButton: () {
                                     int finishData = socketProvider.newIndexData[int.parse(finaIntValue.toString())];
                                     socketProvider.setFinishCardIndex(finishData - 1);
                                     socketProvider.setCardUpTrue(int.parse(data.toString()),context);
                                     socketProvider.setOneAcceptCardList(2, int.parse(data.toString()));
                                     socketProvider.finishCard(int.parse(finaIntValue.toString()),context,widget.gameId);
                                     Navigator.pop(context);
                                   },
                                   onTapRightButton: () {

                                   },
                                 ).show(context);
                               }
                               else{

                                 List<int> dataValue =[];
                                 int? intNewValue;
                                 int? finaIntValue;

                                 intNewValue = socketProvider.noNewSortListGroupData[int.parse(data.toString())];

                                 for(int i = 0;i< socketProvider.newIndexData.length;i++){
                                   dataValue.add(socketProvider.newIndexData[i]);
                                   if(socketProvider.newIndexData[i] == intNewValue){
                                     finaIntValue = i;
                                   }
                                 }


                                 FinishDialog(
                                   title: 'Finish Game',
                                   message: "Are you sure you want to finish this game ?",
                                   leftButton: 'Cancel',
                                   rightButton: 'Exit',
                                   onTapLeftButton: () {
                                     int finishData = socketProvider.newIndexData[int.parse(finaIntValue.toString())];
                                     socketProvider.setFinishCardIndex(finishData - 1);
                                     socketProvider.setCardUpTrue(int.parse(data.toString()),context);
                                     socketProvider.setOneAcceptCardList(2, int.parse(data.toString()));
                                     socketProvider.finishCard(int.parse(finaIntValue.toString()),context,widget.gameId);
                                     Navigator.pop(context);
                                   },
                                   onTapRightButton: () {

                                   },
                                 ).show(context);


                               }
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

                               socketProvider.setOneAcceptCardList(2, int.parse(data.toString()));
                             }
                            }
                            else{
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


                              socketProvider.setOneAcceptCardList(2, int.parse(data.toString()));
                            }
                          },
                        ),
                      ),

                      Positioned(
                          top: MediaQuery.of(context).size.height / 4,
                          left: MediaQuery.of(context).size.width * 0.60,
                          child: socketProvider.sortList.length == 1
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: (){
                                  if(socketProvider.noSortGroupFalse == true){
                                    socketProvider.setSortData();
                                    List<int> dataValue =[];
                                    int intValue =0;
                                    int? intNewValue;
                                    int? finaIntValue;

                                    for(int i = 0;i< socketProvider.cardUp.length;i++){
                                      if(socketProvider.cardUp[i] == true){
                                        intValue = i;
                                      }
                                    }

                                    intNewValue = socketProvider.noNewSortListGroupData[intValue];

                                    for(int i = 0;i< socketProvider.newIndexData.length;i++){
                                      dataValue.add(socketProvider.newIndexData[i]);
                                      if(socketProvider.newIndexData[i] == intNewValue){
                                        finaIntValue = i;
                                      }
                                    }


                                    if(socketProvider.isNewDataMyTurn){
                                      if(dataValue.length == 11){

                                        socketProvider.dropCard(finaIntValue ??0);
                                        socketProvider.setCardUpTrue(intValue,context);



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
                                  }
                                  else if(socketProvider.isNewSortTrueFalseNew == true){
                                    socketProvider.setSortData();
                                    List<int> dataValue =[];
                                    int intValue =0;
                                    int? intNewValue;
                                    int? finaIntValue;

                                    for(int i = 0;i< socketProvider.cardUp.length;i++){
                                      if(socketProvider.cardUp[i] == true){
                                        intValue = i;
                                      }
                                    }

                                    intNewValue = socketProvider.newSortListGroupData[intValue];

                                    for(int i = 0;i< socketProvider.newIndexData.length;i++){
                                      dataValue.add(socketProvider.newIndexData[i]);
                                      if(socketProvider.newIndexData[i] == intNewValue){
                                        finaIntValue = i;
                                      }
                                    }


                                    if(socketProvider.isNewDataMyTurn){
                                      if(dataValue.length == 11){

                                        socketProvider.dropCard(finaIntValue ??0);
                                        socketProvider.setCardUpTrue(intValue,context);

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
                                  }
                                  else{
                                    socketProvider.setSortData();
                                    List<int> dataValue =[];
                                    int intValue =0;
                                    int? finaIntValue;

                                    for(int i = 0;i< socketProvider.cardUp.length;i++){
                                      if(socketProvider.cardUp[i] == true){
                                        intValue = i;
                                      }
                                    }

                                    dataValue = socketProvider.GroupData;

                                    for(int i = 0; i< dataValue.length;i++){
                                    }

                                    for(int i = 0;i<socketProvider.newIndexData.length;i++){
                                      if(socketProvider.newIndexData[i] == intValue){
                                        finaIntValue = i;
                                      }
                                    }

                                    if(socketProvider.isNewDataMyTurn){
                                      if(socketProvider.newIndexData.length == 11){
                                        if(socketProvider.noSortGroupFalse == true){
                                          socketProvider.setOldSortCardRemove(socketProvider.setCardUpIndex);
                                          socketProvider.dropCard(intValue);
                                          socketProvider.setCardUpTrue(socketProvider.setCardUpIndex,context);
                                        }else{
                                          if(socketProvider.isNewSortTrueFalseNew == true){
                                            socketProvider.setOldSortCardRemove(socketProvider.setCardUpIndex);
                                            socketProvider.dropCard(finaIntValue ??0);
                                            socketProvider.setCardUpTrue(socketProvider.setCardUpIndex,context);
                                          }
                                          else{
                                            socketProvider.setOldCardRemove(socketProvider.setCardUpIndex);
                                            socketProvider.dropCard(socketProvider.setCardUpIndex);
                                            socketProvider.setCardUpTrue(socketProvider.setCardUpIndex,context);
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
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset('assets/images/pokerCheckButton.png'),
                                    Text('drop'.toUpperCase(),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: (){

                                if(socketProvider.isNewDataMyTurn){
                                 if(socketProvider.newIndexData.length == 11){
                                   if(socketProvider.isNewSortTrueFalseNew == true){
                                     List<int> dataValue =[];
                                     int intValue =0;
                                     int? intNewValue;
                                     int? finaIntValue;

                                     for(int i = 0;i< socketProvider.cardUp.length;i++){
                                       if(socketProvider.cardUp[i] == true){
                                         intValue = i;
                                       }
                                     }

                                     intNewValue = socketProvider.noNewSortListGroupData[intValue];

                                     for(int i = 0;i< socketProvider.newIndexData.length;i++){
                                       dataValue.add(socketProvider.newIndexData[i]);
                                       if(socketProvider.newIndexData[i] == intNewValue){
                                         finaIntValue = i;
                                       }
                                     }


                                     FinishDialog(
                                       title: 'Finish Game',
                                       message: "Are you sure you want to finish this game ?",
                                       leftButton: 'Cancel',
                                       rightButton: 'Exit',
                                       onTapLeftButton: () {
                                         int finishData = socketProvider.newIndexData[int.parse(finaIntValue.toString())];
                                         socketProvider.setFinishCardIndex(finishData - 1);
                                         socketProvider.setCardUpTrue(intValue,context);
                                         socketProvider.setOneAcceptCardList(2, int.parse(intValue.toString()));
                                         socketProvider.finishCard(int.parse(finaIntValue.toString()),context,widget.gameId);
                                         Navigator.pop(context);
                                       },
                                       onTapRightButton: () {

                                       },
                                     ).show(context);

                                   }
                                   else if(socketProvider.noSortGroupFalse == true){
                                     List<int> dataValue =[];
                                     int intValue =0;
                                     int? intNewValue;
                                     int? finaIntValue;

                                     for(int i = 0;i< socketProvider.cardUp.length;i++){
                                       if(socketProvider.cardUp[i] == true){
                                         intValue = i;
                                       }
                                     }

                                     intNewValue = socketProvider.noNewSortListGroupData[intValue];

                                     for(int i = 0;i< socketProvider.newIndexData.length;i++){
                                       dataValue.add(socketProvider.newIndexData[i]);
                                       if(socketProvider.newIndexData[i] == intNewValue){
                                         finaIntValue = i;
                                       }
                                     }

                                     FinishDialog(
                                       title: 'Finish Game',
                                       message: "Are you sure you want to finish this game ?",
                                       leftButton: 'Cancel',
                                       rightButton: 'Exit',
                                       onTapLeftButton: () {
                                         int finishData = socketProvider.newIndexData[int.parse(finaIntValue.toString())];
                                         socketProvider.setFinishCardIndex(finishData - 1);
                                         socketProvider.setCardUpTrue(intValue,context);
                                         socketProvider.setOneAcceptCardList(2, int.parse(intValue.toString()));
                                         socketProvider.finishCard(int.parse(finaIntValue.toString()),context,widget.gameId);
                                         Navigator.pop(context);
                                       },
                                       onTapRightButton: () {

                                       },
                                     ).show(context);

                                   }
                                   else{
                                     List<int> dataValue =[];
                                     int intValue =0;
                                     int? intNewValue;
                                     int? finaIntValue;

                                     for(int i = 0;i< socketProvider.cardUp.length;i++){
                                       if(socketProvider.cardUp[i] == true){
                                         intValue = i;
                                       }
                                     }

                                     intNewValue = socketProvider.newIndexData[intValue];

                                     for(int i = 0;i< socketProvider.newIndexData.length;i++){
                                       dataValue.add(socketProvider.newIndexData[i]);
                                       if(socketProvider.newIndexData[i] == intNewValue){
                                         finaIntValue = i;
                                       }
                                     }

                                     FinishDialog(
                                       title: 'Finish Game',
                                       message: "Are you sure you want to finish this game ?",
                                       leftButton: 'Cancel',
                                       rightButton: 'Exit',
                                       onTapLeftButton: () {
                                         int finishData = socketProvider.newIndexData[int.parse(finaIntValue.toString())];
                                         socketProvider.setFinishCardIndex(finishData - 1);
                                         socketProvider.setCardUpTrue(intValue,context);
                                         socketProvider.setOneAcceptCardList(2, int.parse(intValue.toString()));
                                         socketProvider.finishCard(int.parse(finaIntValue.toString()),context,widget.gameId);
                                         Navigator.pop(context);
                                       },
                                       onTapRightButton: () {

                                       },
                                     ).show(context);
                                   }
                                 }else{
                                   showToast("Pick Up a Card".toUpperCase(),
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
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset('assets/images/pokerCallButton.png'),
                                    Text('finish'.toUpperCase(),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                                  ],
                                ),
                              ),
                            ],
                          )
                              : socketProvider.sortList.length >= 2
                              ? InkWell(
                            onTap: (){
                              if(socketProvider.isNewSortTrueFalseNew ){
                                socketProvider.setNewGroupData();
                              }else{
                                if(socketProvider.noSortGroupFalse == false){
                                  socketProvider.setNoSortGroupFalse(true);
                                }
                                Future.delayed(const Duration(microseconds: 500),(){
                                  socketProvider.setNewGroupData();});
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/images/pokerFoldCheckButton.png'),
                                Text('group'.toUpperCase(),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                              ],
                            ),
                          )
                              :  socketProvider.isNewSortTrueFalseNew
                              ? Container()
                              : socketProvider.noSortGroupFalse ? Container():InkWell(
                            onTap: (){
                              if(socketProvider.isNewSortTrueFalseNew == false){

                                socketProvider.sortDataEvent(socketProvider.mapSortData);

                                socketProvider.setNoSortGroupFalse(false);

                                socketProvider.setNewSortTrueFalse(true);


                              }else{
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/images/pokerFoldSwitchButton.png'),
                                Text('Sort'.toUpperCase(),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                              ],
                            ),
                          )
                      ),


                      const NewPlayer3SeatWidget(
                        userProfileImage: ImageConst.icProfilePic3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),


              if( socketProvider.playerCount == 2)
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.width * 0.50,
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

               if( socketProvider.playerCount == 3)
                 Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.18,
                  right: MediaQuery.of(context).size.width * 0.08,
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
                  top: MediaQuery.of(context).size.height * 0.18,
                  left: MediaQuery.of(context).size.width * 0.08,
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
              ],
            ),

               if( socketProvider.playerCount == 4)
                 Stack(
                   children: [
                     Positioned(
                       top: MediaQuery.of(context).size.height * 0.04,
                       left: MediaQuery.of(context).size.width * 0.50,
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
                     Positioned(
                       top: MediaQuery.of(context).size.height * 0.18,
                       right: MediaQuery.of(context).size.width * 0.08,
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
                       top: MediaQuery.of(context).size.height * 0.18,
                       left: MediaQuery.of(context).size.width * 0.08,
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
                   ],
                 ),

               if( socketProvider.playerCount == 5)
                 Stack(
                   children: [
                     Positioned(
                       top: MediaQuery.of(context).size.height * 0.18,
                       right: MediaQuery.of(context).size.width * 0.08,
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
                       top: MediaQuery.of(context).size.height * 0.18,
                       left: MediaQuery.of(context).size.width * 0.08,
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
                       bottom: MediaQuery.of(context).size.height * 0.19,
                       right: MediaQuery.of(context).size.width * 0.08,
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
                       bottom: MediaQuery.of(context).size.height * 0.19,
                       left: MediaQuery.of(context).size.width * 0.08,
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
                   ],
                 ),

               if( socketProvider.playerCount == 5)
                 Stack(
                   children: [
                     Positioned(
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
                     Positioned(
                       top: 20.0,
                       right: MediaQuery.of(context).size.width * 0.05,
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
                       top: 20.0,
                       left: MediaQuery.of(context).size.width * 0.05,
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.end,
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
                     Positioned(
                       bottom: 70.0,
                       right: MediaQuery.of(context).size.width * 0.05,
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Container(
                             padding: const EdgeInsets.only(bottom: 2.0),
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

                   ],
                 ),

        ],
      );
    });
  }
}
