import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instaflutt/db/urls.dart';
import 'package:http/http.dart' as http;
import 'package:instaflutt/model/balasanModel.dart';
import 'package:instaflutt/model/custmodel.dart';
import 'package:instaflutt/model/komenModel.dart';
import 'package:instaflutt/model/postinganModel.dart';

class PostinganAPI {
  Future<List<PostinganModel>> getPosting(
      {@required String idCus, }) async {
        print(idCus + '--------------------------------------------------');
      String url = BaseUrl.urlAPI + 'liatPostinganUser/\'$idCus\'';
      print(url + '------------------------------------url--------------');
    var response = await http.get(url).then((val) => json.decode(val.body));

    List lala = response.map((baba) => PostinganModel.fromJson(baba)).toList();

    List<PostinganModel> barangss = new List<PostinganModel>.from(lala);
    // var response = await http.post(url).then((val) => json.decode(val.body));

    // print(responseJson);

    return barangss;
  }

  Future<List<PostinganModel>> getPostingByid(
      {@required String idCus, }) async {
        print(idCus + '--------------------------------------------------');
      String url = BaseUrl.urlAPI + 'liatPostinganbyId/\'$idCus\'';
      print(url + '------------------------------------url--------------');
    var response = await http.get(url).then((val) => json.decode(val.body));

    List lala = response.map((baba) => PostinganModel.fromJson(baba)).toList();

    List<PostinganModel> barangss = new List<PostinganModel>.from(lala);
    // var response = await http.post(url).then((val) => json.decode(val.body));

    // print(responseJson);

    return barangss;
  }

  Future<List<KomenModel>> getKomenPostingnan(
      {@required String idCus, String idPostingan}) async {
        print(idCus + '--------------------------------------------------');
      String url = BaseUrl.urlAPI + 'liatKomenUserIG/$idPostingan/\'$idCus\'';
      print(url + '------------------------------------url--------------');
    var response = await http.get(url).then((val) => json.decode(val.body));

    List lala = response.map((baba) => KomenModel.fromJson(baba)).toList();

    List<KomenModel> barangss = new List<KomenModel>.from(lala);
    // var response = await http.post(url).then((val) => json.decode(val.body));

    // print(responseJson);

    return barangss;
  }

  Future<List<UserModel>> getallUser(
      {@required String idCus}) async {
        print(idCus + '--------------------------------------------------');
      String url = BaseUrl.urlAPI + 'lihatsemuauser/$idCus';
      print(url + '------------------------------------url--------------');
    var response = await http.get(url).then((val) => json.decode(val.body));

    List lala = response.map((baba) => UserModel.fromJson(baba)).toList();

    List<UserModel> barangss = new List<UserModel>.from(lala);
    // var response = await http.post(url).then((val) => json.decode(val.body));

    // print(responseJson);

    return barangss;
  }

  Future<List<BalasanModel>> getBalasam(
      {@required String idCus, String id, String from, String to}) async {
        print(idCus + '--------------------------------------------------');
      String url = BaseUrl.urlAPI + 'liatBalasan/$id/\'$idCus\'/$from/$to';
      print(url + '------------------------------------url--------------');
    var response = await http.get(url).then((val) => json.decode(val.body));

    List lala = response.map((baba) => BalasanModel.fromJson(baba)).toList();

    List<BalasanModel> barangss = new List<BalasanModel>.from(lala);
    // var response = await http.post(url).then((val) => json.decode(val.body));

    // print(responseJson);

    return barangss;
  }
Future<int> inputDataKomen({@required userFid, @required String aidi, String komen,@required int cekbalasan}) async {
    final String url = BaseUrl.urlAPI + '/tambahKomentar';
    final String url2 = BaseUrl.urlAPI + '/tambahBalasan';

    var res =
        await http.post(cekbalasan == 1 ? url : url2,
        body: {
          'id': aidi,
          'uid': userFid,
          'komn': komen
        }
        ).then((val) => val.body);
    final encoded = jsonDecode(res);
    int pesan = encoded['status'];
    return pesan;
  }

Future<int> inputDataLike({@required userFid, @required String aidi}) async {
    final String url = BaseUrl.urlAPI + '/tambahLike';

    var res =
        await http.post(url,
        body: {
          'id': aidi,
          'uid': userFid,
        }
        ).then((val) => val.body);
    final encoded = jsonDecode(res);
    int pesan = encoded['status'];
    return pesan;
  }

  Future<int> inputDataLikeKomentar({@required userFid, @required String aidi}) async {
    final String url = BaseUrl.urlAPI + '/tambahLikeKomentar';

    var res =
        await http.post(url,
        body: {
          'id': aidi,
          'uid': userFid,
        }
        ).then((val) => val.body);
    final encoded = jsonDecode(res);
    int pesan = encoded['status'];
    return pesan;
  }

  Future<int> inputDataLikeBalasan({@required userFid, @required String aidi}) async {
    final String url = BaseUrl.urlAPI + '/tambahLikeBalasan';

    var res =
        await http.post(url,
        body: {
          'id': aidi,
          'uid': userFid,
        }
        ).then((val) => val.body);
    final encoded = jsonDecode(res);
    int pesan = encoded['status'];
    return pesan;
  }

}