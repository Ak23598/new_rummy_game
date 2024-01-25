

import 'dart:convert';

PlayerWinnerModel playerWinnerModelFromJson(String str) => PlayerWinnerModel.fromJson(json.decode(str));

String playerWinnerModelToJson(PlayerWinnerModel data) => json.encode(data.toJson());

class PlayerWinnerModel {
  PlayerWinnerModelGame? game;

  PlayerWinnerModel({
    this.game,
  });

  factory PlayerWinnerModel.fromJson(Map<String, dynamic> json) => PlayerWinnerModel(
    game: PlayerWinnerModelGame.fromJson(json["game"]),
  );

  Map<String, dynamic> toJson() => {
    "game": game?.toJson(),
  };
}

class PlayerWinnerModelGame {
  String? id;
  int? pointValue;
  int? minEntry;
  int? maxPlayer;
  int? totalPlayers;
  int? selectedPlayersRange;
  List<String>? players;
  int? v;
  GameGame? game;

  PlayerWinnerModelGame({
    this.id,
    this.pointValue,
    this.minEntry,
    this.maxPlayer,
    this.totalPlayers,
    this.selectedPlayersRange,
    this.players,
    this.v,
    this.game,
  });

  factory PlayerWinnerModelGame.fromJson(Map<String, dynamic> json) => PlayerWinnerModelGame(
    id: json["_id"],
    pointValue: json["pointValue"],
    minEntry: json["minEntry"],
    maxPlayer: json["maxPlayer"],
    totalPlayers: json["totalPlayers"],
    selectedPlayersRange: json["selectedPlayersRange"],
    players: List<String>.from(json["players"]?.map((x) => x) ?? {}),
    v: json["__v"],
    game: GameGame.fromJson(json["game"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "pointValue": pointValue,
    "minEntry": minEntry,
    "maxPlayer": maxPlayer,
    "totalPlayers": totalPlayers,
    "selectedPlayersRange": selectedPlayersRange,
    "players": List<dynamic>.from(players?.map((x) => x) ?? {}),
    "__v": v,
    "game": game?.toJson(),
  };
}

class GameGame {
  List<Player>? players;
  String? winner;
  String? socketId;

  GameGame({
    this.players,
    this.winner,
    this.socketId,
  });

  factory GameGame.fromJson(Map<String, dynamic> json) => GameGame(
    players: List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
    winner: json["winner"],
    socketId: json["socketId"],
  );

  Map<String, dynamic> toJson() => {
    "players": List<dynamic>.from(players?.map((x) => x.toJson()) ?? {}),
    "winner": winner,
    "socketId": socketId,
  };
}

class Player {
  String? name;
  List<dynamic>? hand;
  String? id;
  String? room;
  String? userId;

  Player({
    this.name,
    this.hand,
    this.id,
    this.room,
    this.userId,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    name: json["name"],
    hand: List<dynamic>.from(json["hand"].map((x) => x)),
    id: json["id"],
    room: json["room"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "hand": List<dynamic>.from(hand?.map((x) => x) ?? {}),
    "id": id,
    "room": room,
    "userId": userId,
  };
}
