// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool isSuccess;
  String message;
  List<Datum> data;

  Welcome({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    isSuccess: json["is_success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String nama;
  String lokasi;
  String noHp;
  String gambarKampus;
  String latKampus;
  String longKampus;

  Datum({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.noHp,
    required this.gambarKampus,
    required this.latKampus,
    required this.longKampus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    lokasi: json["lokasi"],
    noHp: json["no_hp"],
    gambarKampus: json["gambar_kampus"],
    latKampus: json["lat_kampus"],
    longKampus: json["long_kampus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "lokasi": lokasi,
    "no_hp": noHp,
    "gambar_kampus": gambarKampus,
    "lat_kampus": latKampus,
    "long_kampus": longKampus,
  };
}
