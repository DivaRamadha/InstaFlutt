import 'package:flutter/material.dart';
import 'package:instaflutt/db/authAPi.dart';
import 'package:instaflutt/db/postinganApi.dart';
import 'package:instaflutt/db/urls.dart';
import 'package:instaflutt/model/custmodel.dart';
import 'package:instaflutt/model/postinganModel.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:instaflutt/theme/textStyles.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  final String userId;

  const AccountPage({Key key,@required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authe = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: userId == '0' ? null : AppBar(
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.arrow_back,
        color: black,
        ), onPressed: ()=> Navigator.pop(context)),
        elevation: 1,
        title: Text(userId,
        style: tittle,
        ),
      ),
      body: userId == '0' ? ProfilWidget(
        u: authe.cust,
      ) : FutureBuilder<UserModel>(
        
        future: AuthApi().getUser(userFid: userId, context: context,a: 0),
        builder: (context, data){
          if (!data.hasData) {
            return SizedBox();
          }
          return ProfilWidget(
        u: data.data,
      );
        }
         )
    );
  }
}

class ProfilWidget extends StatelessWidget {
  final UserModel u;

  const ProfilWidget({Key key, this.u}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: NestedScrollView(
          // allows you to build a list of elements that would be scrolled away till the body reached the top
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(1, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(999),
                                    child: Image.network(BaseUrl.img2 +
                                        u.profileImage)),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Container(
                                width: 80,
                                child: Column(
                                  children: [
                                    Text('50', style: tittletextprofil),
                                    Text('Postingan', style: subtittleprofil)
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                child: Column(
                                  children: [
                                    Text(
                                      '120k',
                                      style: tittletextprofil,
                                    ),
                                    Text(
                                      'Pengikut',
                                      style: subtittleprofil,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                child: Column(
                                  children: [
                                    Text(
                                      '120',
                                      style: tittletextprofil,
                                    ),
                                    Text(
                                      'Mengikuti',
                                      style: subtittleprofil,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            u.name,
                            style: titlename,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            u.bioUser,
                            style: subtittleprofil,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            u.linkBio,
                            style: linktext,
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ];
          },
          // You tab view goes here
          body: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: black,
                tabs: [
                  Tab(
                      icon: Icon(
                    Icons.grid_on,
                    color: black,
                  )),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<PostinganModel>>(
                      future: PostinganAPI()
                          .getPostingByid(idCus: u.idUser.toString()),
                      builder: (context, data) {
                        if (!data.hasData) {
                          return SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.count(
                            padding: EdgeInsets.zero,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            crossAxisCount: 3,
                            children: List.generate(
                              data.data.length,
                              (index) {
                                return Container(
                                  child: Image.network(BaseUrl.img2 + data.data[index].imgUrl,
                                  fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                        // Colors.primaries.map((color) {
                        //   return Container(color: color, height: 150.0);
                        // }).toList(),
                      },
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      children: Colors.primaries.map((color) {
                        return Container(color: color, height: 150.0);
                      }).toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
