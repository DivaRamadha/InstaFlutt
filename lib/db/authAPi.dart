// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:customer_maps/models/user.dart';

// class AuthApi {
//   static final String urlServin = "https://api.servin.id";

//   Future<String> register({@required Map<String, dynamic> data}) async {
//     final String url = '$urlServin/register';
//     print('````````````````````````````````````');
//     print(data);
//     var res = await http.post(url, body: data).then((val) => val.body);
//     final encoded = jsonDecode(res);
//     return encoded['id'];
//   }

//   Future<void> addDevice({@required String userFid}) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     print('add device ${preferences.getString('deviceId')}');
//     await http.post('$urlServin/add-device', body: {
//       'fid': userFid,
//       'device': preferences.getString('deviceId'),
//       'platform': 'android',
//     });
//   }

//   Future<User> getUser({@required userFid}) async {
//     print('api get user');
//     Map<String, dynamic> userJson = {'fid_user': userFid};
//     var res = await http.post('$urlServin/getUser', body: {'id': userFid});
//     Map jsonKeEncode = jsonDecode(res.body);
//     if (jsonKeEncode['nama_user'] == null) {
//       print('error user: ${res.body}, \n map: $jsonKeEncode');
//       return User();
//     }
//     userJson.addAll(jsonKeEncode);
//     return User.fromJson(userJson);
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:instaflutt/db/urls.dart';
import 'package:instaflutt/model/custmodel.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static final String urlServin = "https://api.servin.id";


  Future<int> loginUser({@required String uid, String pass}) async {
    final String url = BaseUrl.urlAPI + '/lihatUserlog';

    var res =
        await http.get(url + '/$uid/$pass').then((val) => val.body);
    final encoded = jsonDecode(res);
    int pesan = encoded['status'];
    return pesan;
  }

  Future<UserModel> getUser(
      {@required userFid, @required BuildContext context, @required int a}) async {
    UserModel cus = new UserModel();
    final authe = Provider.of<AuthProvider>(context, listen: false);
    print('api get user');
    print(userFid);
    final response =
        await http.get(BaseUrl.urlAPI + 'lihatUserIg/$userFid');
    final responseJson = json.decode(response.body.toString());
    for (Map user in responseJson) {
      cus = UserModel.fromJson(user);
      // _userDetails.add(Vendor.fromJson(user));
    }
    print(cus.idUser);
      if (a == 1) {
        authe.setUserModel = cus;
      }
    
    // print(cus);
    return cus;
  }

    
}
