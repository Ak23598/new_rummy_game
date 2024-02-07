
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/socket_constants.dart';
import 'package:rummy_game/poker/poker_provider/poker_provider.dart';
import 'package:rummy_game/provider/socket_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class PokerSockets{

  static IO.Socket socket = IO.io(SocketConstant.pokerSocketUrl,
      OptionBuilder()
          .setTransports(['websocket']).build());

  static void connectAndListen(BuildContext context,String playerId,String gameId,String chip,String data){
    var pokerProvider = Provider.of<PokerProvider>(context,listen: false);
    print("poker Socket connect and listen ");
    if(socket.connected){
      /*socket.emit('initializeGame', "game1");*/
      print("poker Socket connected");
    }else{
      print("not connected");
      socket.connect();
    }
    socket.onConnect((_) {
      print("on connect");
      Future.delayed(const Duration(milliseconds: 300), () {

        pokerProvider.cardsEvent(context);
        pokerProvider.blindNameEvent(context);
        pokerProvider.displayPlayerOptionsEvent(context);
        pokerProvider.flopCardsEvent(context);
        pokerProvider.turnCardsEvent(context);
        pokerProvider.riverCardsEvent(context);
        pokerProvider.winnerEvent(context);
        pokerProvider.winnerAmountEvent(context);
        pokerProvider.bigBlindTrnWithOutActionEvent(context);
        pokerProvider.roomMessageActionEvent(context);
        pokerProvider.gameJoinCard(context,playerId,gameId,chip);
        pokerProvider.playerActionCard(context,data);

      });
    });

    socket.onDisconnect((_) {
      print('disconnect  ${_}');
    });
    socket.onError((data) {
      print('error  ${data.toString()}');
    });
  }

}