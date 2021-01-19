import 'package:flutter/material.dart';
import 'package:instaflutt/db/authAPi.dart';
import 'package:instaflutt/db/sharedPref.dart';
import 'package:instaflutt/pages/home_page.dart';
import 'package:instaflutt/pages/root_app.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:instaflutt/theme/textStyles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();

  String pass, user;
  bool cekdata = false;
  bool load = false;
  bool secureText = true;

  SharedPref sharedPref = new SharedPref();


  setId(String id){
    setState(() {
      sharedPref.saveString('uid', id);
    });
  }

  showHide() {
    setState(() {
      secureText = !secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(14),
              height: MediaQuery.of(context).size.height - 28,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    'Instaflutt',
                    style: TextStyle(
                        fontFamily: 'Billabong', fontSize: 40, color: black),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextField(
                    controller: controller1,
                    // style: subtittleHitam,
                    // minLines: 1,
                    // maxLines: 2,
                    onChanged: (e) {
                      setState(() {
                        user = e;
                      });
                    },
                    // expands: false,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      hintText: "nama pengguna",
                      // hintStyle: subtittle2,
                      focusedBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: new BorderSide(color: Colors.grey[300])),
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: new BorderSide(color: Colors.grey[300])),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextField(
                    controller: controller2,
                    // style: subtittleHitam,
                    obscureText: secureText,
                    // minLines: 1,
                    // maxLines: 2,
                    onChanged: (e) {
                      setState(() {
                        pass = e;
                      });
                    },
                    // expands: false,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                            secureText ? Icons.visibility_off : Icons.visibility,
                            color: buttonFollowColor,
                            size: 15.0),
                        onPressed: showHide,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      hintText: "Kata Sandi",
                      // hintStyle: subtittle2,
                      focusedBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: new BorderSide(color: Colors.grey[300])),
                      enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: new BorderSide(color: Colors.grey[300])),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  FlatButton(
                    
                      height: 46,
                      minWidth: width,
                      color: buttonFollowColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      onPressed: () {
                        setState(() {
                          cekdata = false;
                          load = true;
                        });
                        AuthApi().loginUser(uid: user, pass: pass).then((value) {
                          if (value == 200) {
                            setId(user);
                            AuthApi().getUser(
                                userFid: user, context: context, a: 1).then((value) => Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    settings: const RouteSettings(name: '/masuk'),
                                    builder: (context) => new MyApp())));
                            
                          } else {
                            _errorMessage();
                            setState(() {
                              cekdata = true;
                              load = false;
                            });
                          }
                        });
                      },
                      child: load ? CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(white),
                      ) : Text(
                        'Masuk',
                        style: TextStyle(
                          color: white,
                        ),
                      )),
                  SizedBox(
                    height: 14,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Lupa detail login anda ? ', style: subtittleText),
                    TextSpan(
                        text: 'Dapatkan bantuan untuk login',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textFieldBackground))
                  ])),
                  Spacer(),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Belum punya akun? ', style: subtittleText),
                        TextSpan(
                          text: 'Buat akun',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textFieldBackground,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  // SizedBox(
                  //   height: 14,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       width: (width / 2) - 50,
                  //       child: Divider(
                  //         thickness: 1,
                  //       )),
                  //     Container(
                  //       alignment: Alignment.center,
                  //       width: 50,
                  //       child: Text('Atau',
                  //       style: subtittleText,
                  //       )),
                  //     Container(
                  //       width: (width/ 2) - 50,
                  //       child: Divider(
                  //         thickness: 1,
                  //       ))
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _errorMessage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username atau password salah',
                    style: tittle,
                    ),
                     Container(
                       padding: EdgeInsets.symmetric(
                         vertical: 4
                       ),
                       child: Text('Pastikan username dan password yang dimasukkan benar dan pastikan akun anda sudah terdaftar',
                    style: subtittleText,
                    ),
                     ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Kembali')),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
