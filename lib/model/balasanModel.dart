// To parse this JSON data, do
//
//     final balasanModel = balasanModelFromJson(jsonString);

import 'dart:convert';

List<BalasanModel> balasanModelFromJson(String str) => List<BalasanModel>.from(json.decode(str).map((x) => BalasanModel.fromJson(x)));

String balasanModelToJson(List<BalasanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BalasanModel {
    BalasanModel({
        this.idbalasan,
        this.idUser,
        this.idkomen,
        this.balasanKomentar,
        this.createdDate,
        this.profileImage,
        this.likeCount,
        this.isLiked,
    });

    int idbalasan;
    String idUser;
    int idkomen;
    String balasanKomentar;
    DateTime createdDate;
    String profileImage;
    int likeCount;
    int isLiked;

    factory BalasanModel.fromJson(Map<String, dynamic> json) => BalasanModel(
        idbalasan: json["idbalasan"],
        idUser: json["idUser"],
        idkomen: json["idkomen"],
        balasanKomentar: json["balasanKomentar"],
        createdDate: DateTime.parse(json["createdDate"]),
        profileImage: json["profileImage"],
        likeCount: json["likeCount"],
        isLiked: json["isLiked"],
    );

    Map<String, dynamic> toJson() => {
        "idbalasan": idbalasan,
        "idUser": idUser,
        "idkomen": idkomen,
        "balasanKomentar": balasanKomentar,
        "createdDate": createdDate.toIso8601String(),
        "profileImage": profileImage,
        "likeCount": likeCount,
        "isLiked": isLiked,
    };
}
