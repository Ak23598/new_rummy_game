import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/socket_constants.dart';
import 'package:rummy_game/provider/create_game_provider.dart';
import 'package:rummy_game/screens/rummy_game.dart';

import '../poker/screen/poker_screen/poker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool is2Player = false;
  bool is5Player = true;
  List<int> countList = [2, 3, 4, 5,6];
  List<bool> isTrueData = [true,false,false,false,false];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/r_image/Image_BackGroud.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset("assets/r_image/profileBackground.png",
                                height: 65, width: 160, fit: BoxFit.fill),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Center(
                                    child: Image.asset(
                                        'assets/r_image/profileImage.png'),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                    width: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Jaydip Navapariya",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "ID: 1164",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(width: 10,),
                        Container(
                          height: 25,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xff955609).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/r_image/coin.png'),
                              const Spacer(),
                              const Text(
                                "10000.0",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff96C314),
                                ),
                                child: Center(
                                  child:
                                      Image.asset('assets/r_image/refresh.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/r_image/iconBack.png'),
                                fit: BoxFit.fill),
                          ),
                          child: Image.asset(
                            'assets/r_image/cart.png',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/r_image/iconBack.png'),
                                fit: BoxFit.fill),
                          ),
                          child: Image.asset(
                            'assets/r_image/profile.png',
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/r_image/iconBack.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Image.asset(
                              'assets/r_image/wallet.png',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/r_image/iconBack.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Image.asset(
                              'assets/r_image/gift_.png',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/r_image/iconBack.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Image.asset(
                              'assets/r_image/book_text.png',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/r_image/iconBack.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Image.asset(
                              'assets/r_image/settings.png',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/r_image/iconBack.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Image.asset(
                              'assets/r_image/more.png',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 180,
                            width: 170,
                            decoration: BoxDecoration(
                              color: const Color(0xFF15141C),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Color(0xffEEB325),
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 0.75))
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 15),
                                  child:
                                      Image.asset('assets/r_image/rummy.png'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 5),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/r_image/playnowButton.png'),
                                      InkWell(
                                        onTap: () {
                                          showCustomBottomSheet(context);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Play Now",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 180,
                            width: 170,
                            decoration: BoxDecoration(
                              color: const Color(0xFF15141C),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Color(0xffEEB325),
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 0.75))
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 15),
                                  child: Image.asset(
                                      'assets/r_image/pokerImage.png'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 5),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/r_image/playnowButton.png'),
                                      InkWell(
                                        onTap: () {
                                          //showCustomBottomSheet(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PokerScreen()));
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Play Now",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 15,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 15,
                      //       width: 15,
                      //       decoration: const BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Colors.green
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10,),
                      //     const Text("0 Online Player",style: TextStyle(fontSize: 16,color: Colors.amber,fontWeight: FontWeight500),)
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectMatchBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width - 250,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        color: Color(0xff3E3E3E),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 15),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                              color: Color(0xff3E3E3E)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 28,
                                width: 160,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/r_image/titleBack.png'))),
                                child: const Center(
                                  child: Text(
                                    "RUMMY 2 PLAYER",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffFEBF3E),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 40,
                                margin:
                                    const EdgeInsets.only(right: 20, left: 20),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/r_image/tableTitle.png'),
                                        fit: BoxFit.fill)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "POINT VALUE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ),
                                      Text(
                                        "MAN ENTRY",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 11),
                                      ),
                                      Text(
                                        "MAX PLAYERS",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 11),
                                      ),
                                      Text(
                                        "TOTAL PLAYERS",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 11),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "JOIN",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Consumer<CreateGameProvider>(builder:
                                  (context, createGameProvider, child) {
                                return Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, i) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: createGameProvider
                                        .createGameDataList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 40,
                                        margin: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xff242424)
                                              .withOpacity(0.5),
                                        ),
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: const Color(0xff955609),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "       ${createGameProvider.createGameDataList[index].pointValue}    ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "                 ${createGameProvider.createGameDataList[index].minEntry}    ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "                ${createGameProvider.createGameDataList[index].maxPlayer}     ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "               ${createGameProvider.createGameDataList[index].totalPlayers}       ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  createGameProvider.playerJoinGame(createGameProvider.createGameDataList[index].id ?? "").then((value) {
                                                    Navigator.pop(context);
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RummyGameScreen(
                                                                  userId: SocketConstant.user2,
                                                                  gameId: createGameProvider.createGameDataList[index].id ?? "",)));
                                                  });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 65,
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/r_image/joinNow.png')),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "JOIN NOW",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/r_image/cancelBack.png'))),
                          child: const Center(
                            child: Icon(Icons.close,
                                color: Colors.black, size: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          });
        });
  }

  showCustomBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Select No. of Players",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/r_image/iconBack.png'),
                              fit: BoxFit.fill),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset('assets/r_image/whiteProfile.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: countList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                isTrueData.clear();
                                for(int i = 0; i < 5; i++){
                                  if(i == index){
                                    isTrueData.add(true);
                                  }else{
                                    isTrueData.add(false);
                                  }
                                }
                                setState(() {});
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  height: 55,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: isTrueData[index]
                                        ? const Color(0xff242424)
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${countList[index]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: isTrueData[index]
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Players",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: isTrueData[index]
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<CreateGameProvider>(
                      builder: (context, createGameProvider, child) {
                        return InkWell(
                          onTap: () {
                            createGameProvider
                                .getCreateGameList(isTrueData)
                                .then((value) {
                              createGameProvider.clearLoadingValue();
                              Navigator.pop(context);
                              selectMatchBottomSheet(context);
                            });
                          },
                          child: Container(
                            height: 45,
                            width: 150,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/r_image/dialogPlaynowButton.png'))),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Center(
                                child: createGameProvider.isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Text(
                                        "PLAY NOW",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
