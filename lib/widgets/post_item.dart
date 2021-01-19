import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaflutt/db/postinganApi.dart';
import 'package:instaflutt/db/urls.dart';
import 'package:instaflutt/model/postinganModel.dart';
import 'package:instaflutt/pages/comment/komen.dart';
import 'package:instaflutt/pages/user/userPage.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class PostItem extends StatefulWidget {
  final PostinganModel p;
  const PostItem({
    Key key,
    @required this.p,
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
   bool isliked;
  bool isTap = false;

    getdatat(int val) async {
    setState(() {
      if (val == 200) {
        widget.p.isLiked = 1;
        widget.p.likeCount += 1;
        isliked = !isliked;
        isTap = false;
      } else {
        widget.p.isLiked = 0;
        widget.p.likeCount -= 1;
        isliked = !isliked;
        isTap = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isliked = widget.p.isLiked == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountPage(userId: widget.p.idUser,)));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    BaseUrl.img2 + widget.p.profileImage),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.p.idUser,
                        style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Icon(
                  LineIcons.ellipsis_h,
                  color: black,
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Stack(
            children: [
               InkWell(
            onDoubleTap: () {
              PostinganAPI()
                  .inputDataLike(
                      userFid: auth.cust.idUser,
                      aidi: widget.p.idPost.toString())
                  .then((value) {
                setState(() {
                  if (value == 200) {
                    widget.p.likeCount += 1;
                    widget.p.isLiked = 1;
                    isTap = true;
                  } else {
                    widget.p.likeCount -= 1;
                    widget.p.isLiked = 0;
                    isTap = false;
                  }
                });
              });
            },
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(BaseUrl.img2 + widget.p.imgUrl),
                          fit: BoxFit.cover)),
                ),
              ),
              isTap == true && isliked == true ?
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: SvgPicture.asset("assets/loved_icon.svg",
                          height: 200,
                          color: white,
                          ),
                  )
                : SizedBox(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () => PostinganAPI()
                          .inputDataLike(
                              userFid: auth.cust.idUser,
                              aidi: widget.p.idPost.toString())
                          .then((value) {
                       getdatat(value);
                       setState(() {
                        isTap = true;
                      });
                      }),
                      child: Container(
                        width: 30,
                        child: widget.p.isLiked == 1
                            ? SvgPicture.asset(
                                "assets/images/loved_icon.svg",
                                width: 27,
                              )
                            : SvgPicture.asset(
                                "assets/images/love_icon.svg",
                                width: 27,
                                color: textFieldBackground,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListKomen(
                                      p: widget.p,
                                    )));
                      },
                      child: SvgPicture.asset(
                        "assets/images/comment_icon.svg",
                        width: 27,
                        color: textFieldBackground,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/message_icon.svg",
                      width: 27,
                      color: textFieldBackground,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/images/save_icon.svg",
                  width: 27,
                  color: textFieldBackground,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "${widget.p.likeCount} ",
                  style: TextStyle(
                      fontSize: 15,
                      color: textFieldBackground,
                      fontWeight: FontWeight.w700)),
              TextSpan(
                  text: "suka",
                  style: TextStyle(
                      fontSize: 15,
                      color: textFieldBackground,
                      fontWeight: FontWeight.w500)),
            ])),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "${widget.p.idUser} ",
                    style: TextStyle(
                        fontSize: 15,
                        color: textFieldBackground,
                        fontWeight: FontWeight.w700)),
                TextSpan(
                    text: "${widget.p.postDescription}",
                    style: TextStyle(
                        fontSize: 15,
                        color: textFieldBackground,
                        fontWeight: FontWeight.w500)),
              ]))),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "View ${widget.p.komenCount} comments",
              style: TextStyle(
                color: textFieldBackground.withOpacity(0.4),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    BaseUrl.img2 + auth.cust.profileImage),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Add a comment...",
                        style: TextStyle(
                            color: textFieldBackground.withOpacity(0.4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "😂",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "😍",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.add_circle,
                        color: textFieldBackground.withOpacity(0.4),
                        size: 18,
                      )
                    ],
                  )
                ],
              )),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "${widget.p.createdPosting}",
              style: TextStyle(
                  color: textFieldBackground.withOpacity(0.4),
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
