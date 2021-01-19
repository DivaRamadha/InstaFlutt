import 'package:flutter/material.dart';
import 'package:instaflutt/model/custmodel.dart';

class AuthProvider with ChangeNotifier{
  int idkomen;
  String mentions;
  UserModel cus;
  bool submit = false;

  int get getkondisikomen =>idkomen;
  String get getmentions =>mentions;
  UserModel get cust=> cus;
  bool get submitMentions => submit;

  set setmentions(String val){
    mentions = val;
    notifyListeners();
  }

  set submitMentions(bool a){
    submit = a;
    notifyListeners();
  }

  set setkondisikomen(int val) {
    idkomen = val;
    notifyListeners();
  }

  void clearmentions(){
    submit = false;
    idkomen = null;
    mentions = null;
    notifyListeners();
  }

  set setUserModel(UserModel customer){
    cus = customer;
    notifyListeners();
  }
  
}
