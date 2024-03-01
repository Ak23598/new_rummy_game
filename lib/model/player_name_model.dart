import 'dart:convert';

List<PlayerNameModel> playerNameModelFromJson(String str) => List<PlayerNameModel>.from(json.decode(str).map((x) => PlayerNameModel.fromJson(x)));

String playerNameModelToJson(List<PlayerNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlayerNameModel {
  String? blindName;
  String? player;

  PlayerNameModel({
    this.blindName,
    this.player,
  });

  factory PlayerNameModel.fromJson(Map<String, dynamic> json) => PlayerNameModel(
    blindName: json["blindName"],
    player: json["player"],
  );

  Map<String, dynamic> toJson() => {
    "blindName": blindName,
    "player": player,
  };
}
