import 'package:flutter/material.dart';
import 'package:instaflutt/constant/search_json.dart';
import 'package:instaflutt/db/postinganApi.dart';
import 'package:instaflutt/db/urls.dart';
import 'package:instaflutt/model/postinganModel.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:instaflutt/widgets/search_category_item.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final authe = Provider.of<AuthProvider>(context, listen: true);
    return getBody(authe.cust.idUser);
  }

  Widget getBody(String id) {
    var size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        
        // FutureBuilder<List<PostinganModel>>(
        //     future: PostinganAPI().getPosting(idCus: id),
        //     builder: (context, data) {
        //       if (!data.hasData) {
        //         return SizedBox();
        //       }
        //       return GridView.builder(
        //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             childAspectRatio: 3 / 3,
        //             mainAxisSpacing: 8,
        //             crossAxisSpacing: 8,
        //             crossAxisCount:
        //                 (orientation == Orientation.portrait) ? 3 : 3,
        //           ),
        //           shrinkWrap: true,
        //           physics: NeverScrollableScrollPhysics(),
        //           itemBuilder: (context, i) {
        //             return Container(
        //               height: 100,
        //               child: Image.network(BaseUrl.img2 + data.data[i].imgUrl),
        //             );
        //           });
        //     })
      ],
    ));
  }
}
