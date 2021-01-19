// To parse this JSON data, do
//
//     final komenModel = komenModelFromJson(jsonString);

import 'dart:convert';

List<KomenModel> komenModelFromJson(String str) => List<KomenModel>.from(json.decode(str).map((x) => KomenModel.fromJson(x)));

String komenModelToJson(List<KomenModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KomenModel {
    KomenModel({
        this.idkomen,
        this.idUser,
        this.idPost,
        this.komentar,
        this.createdKomen,
        this.profileImage,
        this.likeCount,
        this.komenCount,
        this.isLiked,
    });

    int idkomen;
    String idUser;
    int idPost;
    String komentar;
    DateTime createdKomen;
    String profileImage;
    int likeCount;
    int komenCount;
    int isLiked;

    factory KomenModel.fromJson(Map<String, dynamic> json) => KomenModel(
        idkomen: json["idkomen"],
        idUser: json["idUser"],
        idPost: json["idPost"],
        komentar: json["komentar"],
        createdKomen: DateTime.parse(json["createdKomen"]),
        profileImage: json["profileImage"],
        likeCount: json["likeCount"],
        komenCount: json["komenCount"],
        isLiked: json["isLiked"],
    );

    Map<String, dynamic> toJson() => {
        "idkomen": idkomen,
        "idUser": idUser,
        "idPost": idPost,
        "komentar": komentar,
        "createdKomen": createdKomen.toIso8601String(),
        "profileImage": profileImage,
        "likeCount": likeCount,
        "komenCount": komenCount,
        "isLiked": isLiked,
    };
}
