// To parse this JSON data, do
//
//     final createGameModel = createGameModelFromJson(jsonString);

import 'dart:convert';

CreateGameModel createGameModelFromJson(String str) => CreateGameModel.fromJson(json.decode(str));

String createGameModelToJson(CreateGameModel data) => json.encode(data.toJson());

class CreateGameModel {
  List<Game>? games;

  CreateGameModel({
    this.games,
  });

  factory CreateGameModel.fromJson(Map<String, dynamic> json) => CreateGameModel(
    games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "games": List<dynamic>.from(games?.map((x) => x.toJson()) ?? {}),
  };
}

class Game {
  String? id;
  int? pointValue;
  int? minEntry;
  int? maxPlayer;
  int? totalPlayers;
  int? selectedPlayersRange;
  List<dynamic>? players;
  int? v;

  Game({
    this.id,
    this.pointValue,
    this.minEntry,
    this.maxPlayer,
    this.totalPlayers,
    this.selectedPlayersRange,
    this.players,
    this.v,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json["_id"],
    pointValue: json["pointValue"],
    minEntry: json["minEntry"],
    maxPlayer: json["maxPlayer"],
    totalPlayers: json["totalPlayers"],
    selectedPlayersRange: json["selectedPlayersRange"],
    players: List<dynamic>.from(json["players"].map((x) => x)),
    v: json["__v"],
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
  };
}
