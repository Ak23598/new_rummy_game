
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/constant/socket_constants.dart';
import 'package:rummy_game/provider/socket_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class Sockets{

  static IO.Socket socket = IO.io('${SocketConstant.socketUrl}${SocketConstant.user1}',
      OptionBuilder()
          .setTransports(['websocket']).build());

  static void connectAndListen(BuildContext context,String gameId,String userId,ConfettiController controller){
    var socketProvider = Provider.of<SocketProvider>(context,listen: false);

print("socket connect and listen ");
    if(socket.connected){
      /*socket.emit('initializeGame', "game1");*/
      print("socket connected");
    }else{
      print("not connected");
      socket.connect();
    }
    socket.onConnect((_) {
      print("on connect");
      Future.delayed(const Duration(milliseconds: 300), () {

        socketProvider.createGame(gameId,context);
        socketProvider.upCard(context);
        socketProvider.downCard(context);
        socketProvider.handCard(context);
        socketProvider.turnTime(context);
        socketProvider.turnMessage(context,userId);
        socketProvider.roomMessage(context);
        socketProvider.gameOver(context,gameId);
        socketProvider.countDownEvent(context);

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