

import 'package:flutter/material.dart';
import 'package:instaflutt/db/postinganApi.dart';
import 'package:instaflutt/db/urls.dart';
import 'package:instaflutt/model/custmodel.dart';
import 'package:instaflutt/model/postinganModel.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:instaflutt/theme/textStyles.dart';
import 'package:instaflutt/widgets/story_item.dart';
import 'package:provider/provider.dart';

import '../widgets/post_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authe = Provider.of<AuthProvider>(context, listen: true);
    return getBody(authe.cust.idUser, authe.cust);
  }


  Widget getBody(String ids, UserModel us) {
    return SingleChildScrollView(
          child: Column(
        
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
              Padding(
              padding: const EdgeInsets.only(right: 20, left: 15,bottom: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 68,
                    height: 68,
                    child: Stack(
                      children: <Widget>[
                        // Text(id),
                        Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage(BaseUrl.img2 + us.profileImage),fit: BoxFit.cover)
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                          width: 19,
                          height: 19,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: white
                          ),
                          child: Icon(Icons.add_circle,color: buttonFollowColor,size: 19,),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  SizedBox(width: 70,
                  child: Text('Cerita anda',
                  overflow: TextOverflow.ellipsis,
                  style: subtittle2Text)
                  ,)
                ],
              ),
            ),
             FutureBuilder<List<UserModel>>(
               future: PostinganAPI().getallUser(idCus: ids),
            builder: (context,data){
              if (!data.hasData) {
                return SizedBox();
              }
               return Row(
                    children: List.generate(data.data.length, (index) {
                  return StoryItem(
                    img: BaseUrl.img2 + data.data[index].profileImage,
                    name: data.data[index].idUser,
                  );
                }));
            }
             ),
            
            ],),
          ),
          Divider(
            color: black.withOpacity(0.2),
          ),
          FutureBuilder<List<PostinganModel>>(
            future: PostinganAPI().getPosting(idCus: ids),
            builder: (context,data){
              if (!data.hasData) {
                return SizedBox();
              }
              return Column(
              children: List.generate(data.data.length, (index){
                return PostItem(
                  p: data.data[index],
                  // postImg: BaseUrl.img2 + data.data[index].imgUrl,
                  // profileImg: BaseUrl.img2 + data.data[index].profileImage,
                  // name: data.data[index].idUser,
                  // caption: data.data[index].postDescription,
                  // isLoved: data.data[index].isLiked,
                  // viewCount: data.data[index].komenCount.toString(),
                  // likedBy: data.data[index].likeCount.toString(),
                  // dayAgo: data.data[index].createdPosting.toString(),
                );
              }),
            );
            },
          
          )
        ],
      ),
    );
  }
}


