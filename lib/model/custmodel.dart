// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.idUser,
        this.name,
        this.emailUser,
        this.profileImage,
        this.bioUser,
        this.linkBio,
        this.password,
        this.createdUserDate,
        this.onUpdateUser,
    });

    String idUser;
    String name;
    String emailUser;
    String profileImage;
    String bioUser;
    String linkBio;
    String password;
    DateTime createdUserDate;
    DateTime onUpdateUser;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["idUser"],
        name: json["name"],
        emailUser: json["emailUser"],
        profileImage: json["profileImage"],
        bioUser: json["bioUser"],
        linkBio: json["linkBio"],
        password: json["password"],
        createdUserDate: DateTime.parse(json["createdUserDate"]),
        onUpdateUser: DateTime.parse(json["onUpdateUser"]),
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "name": name,
        "emailUser": emailUser,
        "profileImage": profileImage,
        "bioUser": bioUser,
        "linkBio": linkBio,
        "password": password,
        "createdUserDate": createdUserDate.toIso8601String(),
        "onUpdateUser": onUpdateUser.toIso8601String(),
    };
}
