import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rummy_game/poker/poker_provider/poker_provider.dart';
import 'package:rummy_game/provider/create_game_provider.dart';
import 'package:rummy_game/provider/socket_provider.dart';
import 'package:rummy_game/screens/splash_screen.dart';
import 'package:wakelock/wakelock.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((value) => runApp( MyApp()));

  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return MultiProvider(providers: [
          ChangeNotifierProvider<CreateGameProvider>(create: (_) => CreateGameProvider()),
          ChangeNotifierProvider<SocketProvider>(create: (_) => SocketProvider()),
          ChangeNotifierProvider<PokerProvider>(create: (_) => PokerProvider()),
        ],child: const MaterialApp(
          title: 'Rummy & Poker',
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),

        ),);
      });
    });
  }
}
