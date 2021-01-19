import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instaflutt/db/postinganApi.dart';
import 'package:instaflutt/db/urls.dart';
import 'package:instaflutt/model/balasanModel.dart';
import 'package:instaflutt/model/komenModel.dart';
import 'package:instaflutt/pages/comment/komen.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:instaflutt/theme/textStyles.dart';
import 'package:provider/provider.dart';

class ListKomenItem extends StatefulWidget {
  final KomenModel k;

  const ListKomenItem({Key key, this.k}) : super(key: key);
  @override
  _ListKomenItemState createState() => _ListKomenItemState();
}

class _ListKomenItemState extends State<ListKomenItem> {
  KomenModel k;

  int start = 0;
  int endItem = 0;
  int cek = 0;
  bool show = false;
  int totalKomen;

  @override
  void initState() {
    super.initState();
    k = widget.k;
    totalKomen = k.komenCount;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    // color: primaryColor
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: Image.network(
                      BaseUrl.img2 + k.profileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'Ditulis oleh',
                      //   style: subtittle2,
                      // ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: k.idUser + ' ',
                          style: titlename,
                        ),
                        TextSpan(text: k.komentar, style: subtittlekomen),
                      ])),

                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            child: Text(
                              timeSinceDate(k.createdKomen.toString()),
                              style: subtittle2Text,
                            ),
                          ),
                          Container(
                            width: 60,
                            child: Text(
                              k.likeCount.toString() + ' suka',
                              style: subtittle2Text,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              auth.setkondisikomen = k.idkomen;
                              auth.setmentions = k.idUser;
                            },
                            child: Container(
                              width: 60,
                              child: Text(
                                'Balas',
                                style: subtittle2Text,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    PostinganAPI()
                        .inputDataLikeKomentar(
                            userFid: auth.cust.idUser,
                            aidi: k.idkomen.toString())
                        .then((value) {
                      if (value == 200) {
                        setState(() {
                          k.isLiked = 1;
                          k.likeCount = k.likeCount += 1;
                        });
                      } else {
                        setState(() {
                          k.isLiked = 0;
                          k.likeCount = k.likeCount -= 1;
                        });
                      }
                    });
                    // setState(() {
                    //   k.isLiked = k.isLiked == 1 ?  0 : 1;
                    //   k.likeCount = k.isLiked == 1 ? (k.likeCount +=1) : (k.likeCount -=1);
                    // });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: k.isLiked == 1
                        ? SvgPicture.asset(
                            "assets/images/loved_icon.svg",
                            width: 14,
                          )
                        : SvgPicture.asset(
                            "assets/images/love_icon.svg",
                            width: 14,
                            color: textFieldBackground,
                          ),
                  ),
                )
              ],
            ),
            widget.k.komenCount > 0 && k.komenCount != 0
                ? InkWell(
                    onTap: () {
                      setState(() {
                        // start = endItem;
                        cek = k.komenCount > 2 ? 3 : k.komenCount;
                        endItem = endItem + cek;

                        k.komenCount = k.komenCount > 2
                            ? k.komenCount - cek
                            : k.komenCount - k.komenCount;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Container(width: 44, child: Divider()),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Lihat ' + (k.komenCount).toString() + ' Balasan',
                              style: subtittle2Text,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            totalKomen == endItem && totalKomen > 0
                ? InkWell(
                    onTap: () {
                      setState(() {
                        cek = 0;
                        endItem = 0;
                        k.komenCount = totalKomen;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Container(width: 44, child: Divider()),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Tutup',
                              style: subtittle2Text,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            endItem == 0
                ? SizedBox()
                : FutureBuilder<List<BalasanModel>>(
                    future: PostinganAPI().getBalasam(
                        idCus: auth.cust.idUser.toString(),
                        id: k.idkomen.toString(),
                        from: start.toString(),
                        to: endItem.toString()),
                    builder: (context, data) {
                      if (!data.hasData) {
                        return CircularProgressIndicator();
                      }
                      return Column(
                          children: List.generate(data.data.length,
                              (index) => ListBalasan(b: data.data[index])));
                    })
          ],
        ),
      ),
    );
  }
}

class ListBalasan extends StatefulWidget {
  final BalasanModel b;

  const ListBalasan({Key key, this.b}) : super(key: key);
  @override
  _ListBalasanState createState() => _ListBalasanState();
}

class _ListBalasanState extends State<ListBalasan> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: EdgeInsets.only(left: 40),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    // color: primaryColor
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: Image.network(
                      BaseUrl.img2 + widget.b.profileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4 - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: widget.b.idUser + ' ',
                          style: titlename,
                        ),
                        TextSpan(
                            text: widget.b.balasanKomentar,
                            style: subtittlekomen),
                      ])),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            child: Text(
                              timeSinceDate(widget.b.createdDate.toString()),
                              style: subtittle2Text,
                            ),
                          ),
                          Container(
                            width: 60,
                            child: Text(
                              widget.b.likeCount.toString() + ' suka',
                              style: subtittle2Text,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              auth.setmentions = widget.b.idUser;
                              auth.setkondisikomen = widget.b.idkomen;
                            },
                            child: Container(
                              width: 60,
                              child: Text(
                                'Balas',
                                style: subtittle2Text,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    PostinganAPI()
                        .inputDataLikeBalasan(
                            userFid: auth.cust.idUser,
                            aidi: widget.b.idbalasan.toString())
                        .then((value) {
                      if (value == 200) {
                        setState(() {
                          widget.b.isLiked = 1;
                          widget.b.likeCount += 1;
                        });
                      } else {
                        setState(() {
                          widget.b.isLiked = 0;
                          widget.b.likeCount -= 1;
                        });
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: widget.b.isLiked == 1
                        ? SvgPicture.asset(
                            "assets/images/loved_icon.svg",
                            width: 14,
                          )
                        : SvgPicture.asset(
                            "assets/images/love_icon.svg",
                            width: 14,
                            color: textFieldBackground,
                          ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
