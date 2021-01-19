// To parse this JSON data, do
//
//     final postinganModel = postinganModelFromJson(jsonString);

import 'dart:convert';

List<PostinganModel> postinganModelFromJson(String str) => List<PostinganModel>.from(json.decode(str).map((x) => PostinganModel.fromJson(x)));

String postinganModelToJson(List<PostinganModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostinganModel {
    PostinganModel({
        this.idPost,
        this.idUser,
        this.postDescription,
        this.imgUrl,
        this.createdPosting,
        this.profileImage,
        this.likeCount,
        this.komenCount,
        this.isLiked,
    });

    int idPost;
    String idUser;
    String postDescription;
    String imgUrl;
    String createdPosting;
    String profileImage;
    int likeCount;
    int komenCount;
    int isLiked;

    factory PostinganModel.fromJson(Map<String, dynamic> json) => PostinganModel(
        idPost: json["idPost"],
        idUser: json["idUser"],
        postDescription: json["postDescription"],
        imgUrl: json["imgUrl"],
        createdPosting: json["createdPosting"],
        profileImage: json["profileImage"],
        likeCount: json["likeCount"],
        komenCount: json["komenCount"],
        isLiked: json["isLiked"],
    );

    Map<String, dynamic> toJson() => {
        "idPost": idPost,
        "idUser": idUser,
        "postDescription": postDescription,
        "imgUrl": imgUrl,
        "createdPosting": createdPosting,
        "profileImage": profileImage,
        "likeCount": likeCount,
        "komenCount": komenCount,
        "isLiked": isLiked,
    };
}
