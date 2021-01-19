import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instaflutt/db/sharedPref.dart';
import 'package:instaflutt/pages/auth/login.dart';
import 'package:instaflutt/pages/home_page.dart';
import 'package:instaflutt/pages/search_page.dart';
import 'package:instaflutt/pages/user/userPage.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:instaflutt/theme/textStyles.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;
  SharedPref sharedPref = new SharedPref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: white,
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }
  Widget getBody(){
    List<Widget> pages = [
      HomePage(),
      SearchPage(),
      Center(
          child: Text("Upload Page",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: white
          ),),
      ),
      Center(
          child: Text("Activity Page",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: white
          ),),
      ),
     AccountPage(
       userId: '0',
     )
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }
  Widget getAppBar(){
    final authe = Provider.of<AuthProvider>(context, listen: true);
    if(pageIndex == 0){
      return AppBar(
        backgroundColor: white,
        brightness: Brightness.light,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SvgPicture.asset("assets/images/camera_icon.svg",width: 30,
            color: textFieldBackground,
            ),
            Text("Instagram",style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 35,
              color: textFieldBackground
            ),),
            SvgPicture.asset("assets/images/message_icon.svg",width: 30,
            color: textFieldBackground,
            ),
          ],
        ),
      );
    }else if(pageIndex == 1){
      return null;
    }else if(pageIndex == 2){
      return AppBar(
        backgroundColor: appBarColor,
        title: Text("Upload"),
      );
    }else if(pageIndex == 3){
      return AppBar(
        backgroundColor: appBarColor,
        title: Text("Activity"),
      );
    }else{
      return AppBar(
        backgroundColor: white,
        elevation: 1,
        title: Text(authe.cust.idUser,
        style: tittle,
        ),
        actions: [
          IconButton(icon: Icon(Icons.logout,
          color: black,
          ), onPressed: (){
            sharedPref.hapusAll('uid');
            authe.setUserModel = null;
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
          settings: const RouteSettings(name: '/masuk'),
          builder: (context) => new LoginScreen()));
          })
        ],
      );
    }
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/home_active_icon.svg"
          : "assets/images/home_icon.svg",
      pageIndex == 1
          ? "assets/images/search_active_icon.svg"
          : "assets/images/search_icon.svg",
      pageIndex == 2
          ? "assets/images/upload_active_icon.svg"
          : "assets/images/upload_icon.svg",
      pageIndex == 3
          ? "assets/images/love_active_icon.svg"
          : "assets/images/love_icon.svg",
      pageIndex == 4
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(color: white),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: SvgPicture.asset(
                  bottomItems[index],
                  color: black,
                  width: 27,
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
