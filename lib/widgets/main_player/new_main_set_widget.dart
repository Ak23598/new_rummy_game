import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';

import 'package:rummy_game/provider/socket_provider.dart';

class NewPlayer3SeatWidget extends StatefulWidget {
  const NewPlayer3SeatWidget({
     required this.userProfileImage,
    // required this.oneCardServed,
    // required this.twoCardServed,
    // required this.threeCardServed,
    // required this.fourCardServed,
    // required this.fiveCardServed,
    // required this.sixCardServed,
    // required this.sevenCardServed,
    // required this.eightCardServed,
    // required this.nineCardServed,
    // required this.tenCardServed,
    // required this.elevenCardServed,
    // required this.twelveCardServed,
    // required this.thirteenCardServed,
    // required this.oneCardFliped,
    // required this.twoCardFliped,
    // required this.threeCardFliped,
    // required this.fourCardFliped,
    // required this.fiveCardFliped,
    // required this.sixCardFliped,
    // required this.sevenCardFliped,
    // required this.eightCardFliped,
    // required this.nineCardFliped,
    // required this.tenCardFliped,
    // required this.elevenCardFliped,
    // required this.twelveCardFliped,
    // required this.thirteenCardFliped,
    // required this.oneCardNo,
    // required this.twoCardNo,
    // required this.threeCardNo,
    // required this.fourCardNo,
    // required this.fiveCardNo,
    // required this.sixCardNo,
    // required this.sevenCardNo,
    // required this.eightCardNo,
    // required this.nineCardNo,
    // required this.tenCardNo,
    // required this.elevenCardNo,
    // required this.twelveCardNo,
    // required this.thirteenCardNo,
    // required this.jokerCardFliped,
    // required this.jokerCardNo,
    // required this.jokerCardServed,
    required this.Served,
    required this.Fliped,
    required this.CardNo
  });

   final String userProfileImage;
  // final bool oneCardServed;
  // final bool twoCardServed;
  // final bool threeCardServed;
  // final bool fourCardServed;
  // final bool fiveCardServed;
  // final bool sixCardServed;
  // final bool sevenCardServed;
  // final bool eightCardServed;
  // final bool nineCardServed;
  // final bool tenCardServed;
  // final bool elevenCardServed;
  // final bool twelveCardServed;
  // final bool thirteenCardServed;
  // final bool jokerCardServed;
  // final bool oneCardFliped;
  // final bool twoCardFliped;
  // final bool threeCardFliped;
  // final bool fourCardFliped;
  // final bool fiveCardFliped;
  // final bool sixCardFliped;
  // final bool sevenCardFliped;
  // final bool eightCardFliped;
  // final bool nineCardFliped;
  // final bool tenCardFliped;
  // final bool elevenCardFliped;
  // final bool twelveCardFliped;
  // final bool thirteenCardFliped;
  // final bool jokerCardFliped;
  // final int  oneCardNo;
  // final int  twoCardNo;
  // final int  threeCardNo;
  // final int  fourCardNo;
  // final int  fiveCardNo;
  // final int  sixCardNo;
  // final int  sevenCardNo;
  // final int  eightCardNo;
  // final int  nineCardNo;
  // final int  tenCardNo;
  // final int  elevenCardNo;
  // final int  twelveCardNo;
  // final int  thirteenCardNo;
  // final int  jokerCardNo;
  final List<bool> Served;
  final List<bool> Fliped;
  final List<int> CardNo;

  @override
  State<NewPlayer3SeatWidget> createState() => _NewPlayer3SeatWidgetState();
}

class _NewPlayer3SeatWidgetState extends State<NewPlayer3SeatWidget> with SingleTickerProviderStateMixin{

  AnimationController? _controller;

  final List<bool> _servedPages = [false, false, false,false,false, false, false,false,false, false,false,false,false,false,false,false];
  final List<bool> _flipedPages = [false, false, false,false,false, false, false,false,false, false,false,false,false,false,false,false];
  Timer? servingTimer;
  Timer? flipingTimer;
  bool isPlaying = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    sizeChangeAnimation();
  }

  @override
  void dispose() {
    servingTimer?.cancel();
    flipingTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  sizeChangeAnimation() {
    int serveCounter = 0;
    int flipCounter = 0;

    servingTimer = Timer.periodic(const Duration(milliseconds: 200), (serveTimer) {
      if (!mounted) return;
      setState(() {
        _servedPages[serveCounter] = true;
      });
      serveCounter++;
      if (serveCounter == 11) {
        serveTimer.cancel();
        servingTimer?.cancel();
        Future.delayed(const Duration(seconds: 1),(){
          Provider.of<SocketProvider>(context,listen: false).setFilpCard(false);
          flipingTimer = Timer.periodic(const Duration(milliseconds: 200), (flipTimer) {
            if (!mounted) return;
            setState(() {
              _flipedPages[flipCounter] = true;
            });
            flipCounter++;
            if (flipCounter == 11) {
              flipTimer.cancel();
              flipingTimer?.cancel();
            }
          });
        });
      }
    });
    Future.delayed(const Duration(seconds: 5),(){
      setState(() {
        isPlaying = true;
      });
      Provider.of<SocketProvider>(context,listen: false).newSetData();
      // Provider.of<SocketProvider>(context,listen: false).setNewSortTrueFalse(false);
      // Provider.of<SocketProvider>(context,listen: false).setNewSortListData();
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned(
      right: 0.0,
      left: 0.0,
      bottom: isPlaying?MediaQuery.of(context).size.height * -0.10:MediaQuery.of(context).size.height * 0.05,
      child: isPlaying
          ?Consumer<SocketProvider>(
        builder: (context,socketProvider,_){
          return Column(
            children: [
              socketProvider.isNewSortTrueFalseNew
                  ? SizedBox(
                   height: 100,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: socketProvider.setSequencesResponse.length,
                              itemBuilder: (context,index){
                                return  SizedBox(
                                  width: 45 * socketProvider.newSortListData[index].length.toDouble(),
                                  child: socketProvider.newSortListData[index].length >= 2?Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      socketProvider.setSequencesResponse[index] == 'd'?Container():socketProvider.setSequencesResponse[index] == 'invalid'?const Icon(Icons.close,color: Colors.red,size: 16,):const Icon(Icons.check,color: Colors.green,size: 16,),
                                      const SizedBox(width: 05,),
                                      socketProvider.setSequencesResponse[index] == 'd'?Container():socketProvider.setSequencesResponse[index] == 'invalid'?Center(child: Text(socketProvider.setSequencesResponse[index].toString().toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)):Center(child: Text('valid'.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),)),
                                    ],
                                  ):Container(),
                                );

                              }),
                        ),
                        Container(
                                        height: 70,
                                        margin: const EdgeInsets.only(bottom: 9.0),
                                        child: ReorderableListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return Align(
                              key: ValueKey(index),
                              alignment: Alignment.bottomLeft,
                              child: socketProvider.newSortListGroupData[index] == 100
                                  ? const SizedBox( height: 20,
                                width: 20,)
                                  :Container(
                                margin: EdgeInsets.only(top: socketProvider.cardUp[index]?5:15),
                                child: SizeAnimatedWidget.tween(
                                  enabled: true,
                                  duration: const Duration(milliseconds: 200),
                                  sizeEnabled: socketProvider.newSortListGroupData[index] == 100?const Size(20, 70):const Size(40, 70),
                                  sizeDisabled: const Size(0, 0),
                                  curve: Curves.ease,
                                  child: TranslationAnimatedWidget.tween(
                                    enabled: true,
                                    delay: const Duration(milliseconds: 500),
                                    translationEnabled: const Offset(0, 0),
                                    translationDisabled: const Offset(10.0, -(20.0)),
                                    curve: Curves.ease,
                                    duration: const Duration(milliseconds: 500),
                                    child: InkWell(
                                      onTap: () {
                                        socketProvider.setCardUpTrue(index,context);
                                      },
                                      child: Draggable<int>(
                                        onDragStarted: () {
                                          socketProvider.setOneAcceptHandCardList(1,index);
                                        },
                                        onDraggableCanceled: (velocity, offset) {
                                          socketProvider.setOneAcceptHandCardList(2,index);
                                        },
                                        feedback: SizedBox(
                                          height: 70,
                                          width: 40,
                                          child: Image.asset(socketProvider.rummyCardList[socketProvider.newSortListGroupData[index] - 1]),
                                        ),
                                        data: index,
                                        child: socketProvider.isAcceptSortCardList[index] == 1
                                            ? const SizedBox()
                                            : socketProvider.isAcceptSortCardList[index] == 2
                                            ? Image.asset(socketProvider.rummyCardList[socketProvider.newSortListGroupData[index] - 1])
                                            : OpacityAnimatedWidget.tween(
                                          opacityEnabled: 1,
                                          opacityDisabled: 0,
                                          enabled: true,
                                          child: RotationAnimatedWidget.tween(
                                            enabled: true,
                                            rotationDisabled: Rotation.deg(y: 10),
                                            rotationEnabled: Rotation.deg(y: 10),
                                            child: Image.asset(socketProvider.rummyCardList[socketProvider.newSortListGroupData[index] - 1]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: socketProvider.newSortListGroupData.length,  onReorder: (oldIndex,newIndex){
                        print('OldIndex :-  $oldIndex **** NewIndex :- $newIndex');
                        socketProvider.setRemoveAndIndexNewSortData(newIndex, oldIndex);
                                        }),
                                      ),
                      ],
                    ),
                  )
                  : socketProvider.noSortGroupFalse
                  ? SizedBox(
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: socketProvider.setSequencesResponse.length,
                          itemBuilder: (context,index){
                            return  SizedBox(
                              width: 45 * socketProvider.newSortListData[index].length.toDouble(),
                              child: socketProvider.newSortListData[index].length >= 2?Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  socketProvider.setSequencesResponse[index] == 'd'?Container():socketProvider.setSequencesResponse[index] == 'invalid'?const Icon(Icons.close,color: Colors.red,size: 16,):const Icon(Icons.check,color: Colors.green,size: 16,),
                                  const SizedBox(width: 05,),
                                  socketProvider.setSequencesResponse[index] == 'd'?Container():socketProvider.setSequencesResponse[index] == 'invalid'?Center(child: Text(socketProvider.setSequencesResponse[index].toString().toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)):Center(child: Text('valid'.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),)),
                                ],
                              ):Container(),
                            );

                          }),
                    ),
                    Container(
                      height: 70,
                      margin: const EdgeInsets.only(bottom: 9.0),
                      child: ReorderableListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return Align(
                              key: ValueKey(index),
                              alignment: Alignment.bottomLeft,
                              child: socketProvider.noNewSortListGroupData[index] == 100
                                  ? const SizedBox( height: 20,
                                width: 20,)
                                  :Container(
                                margin: EdgeInsets.only(top: socketProvider.cardUp[index]?5:15),
                                child: SizeAnimatedWidget.tween(
                                  enabled: true,
                                  duration: const Duration(milliseconds: 200),
                                  sizeEnabled: socketProvider.noNewSortListGroupData[index] == 100?const Size(20, 70):const Size(40, 70),
                                  sizeDisabled: const Size(0, 0),
                                  curve: Curves.ease,
                                  child: TranslationAnimatedWidget.tween(
                                    enabled: true,
                                    delay: const Duration(milliseconds: 500),
                                    translationEnabled: const Offset(0, 0),
                                    translationDisabled: const Offset(10.0, -(20.0)),
                                    curve: Curves.ease,
                                    duration: const Duration(milliseconds: 500),
                                    child: InkWell(
                                      onTap: () {
                                        socketProvider.setCardUpTrue(index,context);
                                      },
                                      child: Draggable<int>(
                                        onDragStarted: () {
                                          socketProvider.setOneAcceptHandCardList(1,index);
                                        },
                                        onDraggableCanceled: (velocity, offset) {
                                          socketProvider.setOneAcceptHandCardList(2,index);
                                        },
                                        feedback: SizedBox(
                                          height: 70,
                                          width: 40,
                                          child: Image.asset(socketProvider.rummyCardList[socketProvider.noNewSortListGroupData[index] - 1]),
                                        ),
                                        data: index,
                                        child: socketProvider.isAcceptSortCardList[index] == 1
                                            ? const SizedBox()
                                            : socketProvider.isAcceptSortCardList[index] == 2
                                            ? Image.asset(socketProvider.rummyCardList[socketProvider.noNewSortListGroupData[index] - 1])
                                            : OpacityAnimatedWidget.tween(
                                          opacityEnabled: 1,
                                          opacityDisabled: 0,
                                          enabled: true,
                                          child: RotationAnimatedWidget.tween(
                                            enabled: true,
                                            rotationDisabled: Rotation.deg(y: 10),
                                            rotationEnabled: Rotation.deg(y: 10),
                                            child: Image.asset(socketProvider.rummyCardList[socketProvider.noNewSortListGroupData[index] - 1]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: socketProvider.noSortListGroupData.length,  onReorder: (oldIndex,newIndex){
                        print('OldIndex :-  $oldIndex **** NewIndex :- $newIndex');
                        socketProvider.setRemoveAndIndexNewSortData(newIndex, oldIndex);
                      }),
                    ),
                  ],
                ),
              )
                  :Container(
                height: 70,
                margin: const EdgeInsets.only(bottom: 09.0),
                child: ReorderableListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(0),
                    children: [
                      for(int index = 0;index < socketProvider.newIndexData.length;index++)

                        Align(
                          key: ValueKey(index),
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: socketProvider.cardUp[index]?5:15),
                            child: SizeAnimatedWidget.tween(
                              enabled: true,
                              duration: const Duration(milliseconds: 200),
                              sizeEnabled: const Size(40, 70),
                              sizeDisabled: const Size(0, 0),
                              curve: Curves.ease,
                              child: TranslationAnimatedWidget.tween(
                                enabled: true,
                                delay: const Duration(milliseconds: 500),
                                translationEnabled: const Offset(0, 0),
                                translationDisabled: Offset(10.0, -(20.0)),
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 500),
                                child: InkWell(
                                  onTap: () {
                                    socketProvider.setCardUpTrue(index,context);
                                  },
                                  child: Draggable<int>(
                                    onDragStarted: () {
                                      socketProvider.setOneAcceptCardList(1,index);
                                    },
                                    onDraggableCanceled: (velocity, offset) {
                                      socketProvider.setOneAcceptCardList(2,index);
                                    },
                                    feedback: SizedBox(
                                      height: 70,
                                      width: 40,
                                      child: Image.asset(socketProvider.rummyCardList[socketProvider.newIndexData[index] - 1]),
                                    ),
                                    data: index,
                                    child: socketProvider.isAcceptCardList[index] == 1
                                        ? const SizedBox()
                                        : socketProvider.isAcceptCardList[index] == 2
                                        ? Image.asset(socketProvider.rummyCardList[socketProvider.newIndexData[index] - 1])
                                        : OpacityAnimatedWidget.tween(
                                      opacityEnabled: 1,
                                      opacityDisabled: 0,
                                      enabled: true,
                                      child: RotationAnimatedWidget.tween(
                                        enabled: true,
                                        rotationDisabled: Rotation.deg(y: 10),
                                        rotationEnabled: Rotation.deg(y: 10),
                                        child: Image.asset(socketProvider.rummyCardList[socketProvider.newIndexData[index] - 1]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                    onReorder: (oldIndex,newIndex){
                      print('OldIndex :-  $oldIndex **** NewIndex :- $newIndex');
                      socketProvider.setRomoveAndIndexData(newIndex, oldIndex);
                    }),
              ),
              socketProvider.isMyTurn == false
                  ?SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                width:  MediaQuery.of(context).size.width * 0.06,
                child: Image.asset(
                  widget.userProfileImage,
                ),
              )
                  :Stack(
                alignment: Alignment.center,
                children: [


                  Container(
                    height: MediaQuery.of(context).size.height * 0.135,
                    width:  MediaQuery.of(context).size.width * 0.062,
                    child: CircularProgressIndicator(
                      value: socketProvider.secondsRemaining/30,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 3,
                      backgroundColor: socketProvider.secondsRemaining <= 10 ?Colors.red:Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                    width:  MediaQuery.of(context).size.width * 0.06,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          widget.userProfileImage,
                        ),
                        Container(
                            decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(socketProvider.secondsRemaining.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                            ))
                      ],
                    ),
                  ),
                ],
              ),

            ],
          );
        },
      )
          :Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Consumer<SocketProvider>(builder: (context,socketProvider,_){

            return  Container(
              height: 75,
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  // One Card
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.23,top: socketProvider.cardUp[0]?5:15),
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[0],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[0],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(MediaQuery.of(context).size.width * 0.02, -MediaQuery.of(context).size.height * 0.38),
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
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.276,top: socketProvider.cardUp[0]?5:15),
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[1],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[1],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.025, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Three Card
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.322,top: socketProvider.cardUp[0]?5:15),
                      alignment: Alignment.bottomLeft,
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[2],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[2],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.07, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Four Card
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.368,top: socketProvider.cardUp[0]?5:15),
                      alignment: Alignment.bottomLeft,
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[3],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[3],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.115, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  //Five Card
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.414,top: socketProvider.cardUp[0]?5:15),
                      alignment: Alignment.bottomLeft,
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[4],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[4],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.16, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Six Card
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.46,top: socketProvider.cardUp[0]?5:15),
                      alignment: Alignment.bottomLeft,
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[5],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[5],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.205, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Seven Card
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.506,top: socketProvider.cardUp[0]?5:15),
                      alignment: Alignment.bottomLeft,
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[6],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[6],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.25, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Eight Card
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.553,top: socketProvider.cardUp[0]?5:15),
                      alignment: Alignment.bottomLeft,
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[7],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[7],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.295, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  // Nine Card
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.60,top: socketProvider.cardUp[0]?5:15),
                      alignment: Alignment.bottomLeft,
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[8],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[8],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.34, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),

                  //Ten Card
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: socketProvider.isSortCard?0:MediaQuery.of(context).size.width * 0.647,top: socketProvider.cardUp[0]?5:15),
                      alignment: Alignment.bottomLeft,
                      child: SizeAnimatedWidget.tween(
                        enabled: _servedPages[9],
                        duration: const Duration(milliseconds: 200),
                        sizeEnabled: Size(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.30),
                        sizeDisabled: Size(0, 0),
                        curve: Curves.ease,
                        child: TranslationAnimatedWidget.tween(
                          enabled: _servedPages[9],
                          delay: const Duration(milliseconds: 500),
                          translationEnabled: const Offset(0, 0),
                          translationDisabled: Offset(-MediaQuery.of(context).size.width * 0.385, -MediaQuery.of(context).size.height * 0.38),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset('assets/cards/red_back.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

}
