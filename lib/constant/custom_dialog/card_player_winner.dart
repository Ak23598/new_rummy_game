import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/image_constants.dart';
import 'package:rummy_game/provider/rummy_provider.dart';
import 'package:rummy_game/provider/socket_provider.dart';

class CardPlayerWinner {
  final String title;
  final String message;
  final String rightButton;
  final VoidCallback onTapRightButton;
  final String leftButton;
  final VoidCallback onTapLeftButton;

  CardPlayerWinner({
    required this.title,
    required this.message,
    required this.rightButton,
    required this.onTapRightButton,
    required this.leftButton,
    required this.onTapLeftButton,
  });

  show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _PopupCall(
            title: title,
            message: message,
            leftButton: leftButton,
            rightButton: rightButton,
            onTapLeftButton: onTapLeftButton,
            onTapRightButton: onTapRightButton);
      },
    );
  }
}

class _PopupCall extends StatefulWidget {
  final String title;
  final String message;
  final String rightButton;
  final VoidCallback onTapRightButton;
  final String leftButton;
  final VoidCallback onTapLeftButton;

  const _PopupCall(
      {Key? key,
        required this.title,
        required this.message,
        required this.rightButton,
        required this.onTapRightButton,
        required this.leftButton,
        required this.onTapLeftButton})
      : super(key: key);
  @override
  _PopupCallState createState() => _PopupCallState();
}

class _PopupCallState extends State<_PopupCall> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RummyProvider>(builder: (context,rummyProvider,_){
      return Container(
        width: MediaQuery.of(context).size.width -150,
        decoration:  BoxDecoration(color: Colors.black.withOpacity(0.7),borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text('ScoreCard'.toUpperCase(),style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),),

                  ),
                ),
                const SizedBox(width: 10,),
                Image.asset('assets/images/scorecard.png',height: 40),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/r_image/cancelBack.png',height: 30,width: 30,),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.only(left: 40,right: 40),
              child: SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Player',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),),
                      Text('Card',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),),
                      Text('Result',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),),
                    ],
                  )),
            ),
            Divider(color: Colors.white.withOpacity(0.5),),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: ListView.builder(
                  itemCount: rummyProvider.dataResponse['game']['game']['players'].length,
                  shrinkWrap: true,
                  itemBuilder: (context,finalIndex){
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40,right: 40),
                          child: SizedBox(
                              height: 80,
                              width: double.infinity,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(bottom: 2.0),
                                        child: Image.asset(
                                          'assets/images/ic_profile_pic_${finalIndex +1}.png',
                                          height: MediaQuery.of(context).size.height * 0.13,
                                          width:  MediaQuery.of(context).size.width * 0.06,
                                        ),
                                      ),
                                      Text(rummyProvider.dataResponse['game']['game']['players'][finalIndex]['name'],style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),),
                                    ],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index){
                                      return SizedBox(
                                        height: 60,
                                        width: 40,
                                        child: Image.asset(rummyProvider.rummyCardList[rummyProvider.playerWinnerCardList[finalIndex][index] - 1]),
                                      );
                                    },itemCount: rummyProvider.newIndexData.length,),
                                  rummyProvider.dataResponse['game']['game']['players'][finalIndex]['isWinner'] == true?const Text('Winner',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),):Text('Lose',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),),
                                ],
                              )),
                        ),
                        Divider(color: Colors.white.withOpacity(0.5),),
                      ],
                    );
                  }),
            ),

          ],
        ),
      );
    });
  }
}