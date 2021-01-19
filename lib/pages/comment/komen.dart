import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instaflutt/db/postinganApi.dart';
import 'package:instaflutt/db/urls.dart';
import 'package:instaflutt/model/komenModel.dart';
import 'package:instaflutt/model/postinganModel.dart';
import 'package:instaflutt/provider/authProvider.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:instaflutt/theme/textStyles.dart';
import 'package:instaflutt/widgets/komen_item.dart';
import 'package:provider/provider.dart';

class ListKomen extends StatefulWidget {
  final PostinganModel p;

  const ListKomen({Key key, this.p}) : super(key: key);
  @override
  _ListKomenState createState() => _ListKomenState();
}

class _ListKomenState extends State<ListKomen> {
  TextEditingController controller = new TextEditingController();
  String a = '';
  int cc = 0;

  getdatat(String idUser) async {
    setState(() {
    PostinganAPI().getKomenPostingnan(idCus: idUser, idPostingan: widget.p.idPost.toString());
    });
  }

  bool stik = false;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    // controller.text = auth.getmentions != null ?'@' + auth.getmentions : new TextEditingController().text;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        title: Text(
          'Komentar',
          style: tittle,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: FutureBuilder<List<KomenModel>>(
        future: PostinganAPI().getKomenPostingnan(
            idCus: auth.cust.idUser, idPostingan: widget.p.idPost.toString()),
        builder: (context, data) {
          if (!data.hasData) {
            return Container(
              width: 200,
              height: 14,
              // color: secondaryColor,
            );
          }
          return Scaffold(
            resizeToAvoidBottomPadding: true,
            backgroundColor: white,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                color: white,
                child: Wrap(
                  children: [
                    auth.getmentions != null ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Balas @'+ auth.getmentions,
                          style: subtittle2Text,
                          ),
                          InkWell(
                            onTap: (){
                              auth.clearmentions();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10
                              ),
                              child: Icon(Icons.close,
                              color: Colors.grey
                              ),
                            ),
                          )
                        ],
                      ),
                    ) : SizedBox(),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            // style: subtittleHitam,
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (e) {
                              setState(() {
                                a = e;
                              });
                            },
                            // expands: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 4),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(99),
                                        child: Image.network(
                                          BaseUrl.img2 +auth.cust.profileImage,
                                          height: 20,
                                          width: 20,
                                        ))),
                              ),
                              hintText: "Tambahkan komentar ...",
                              hintStyle: subtittle2Text,
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                            onTap: () async {
                              // addMessage();
                              
                              if (auth.getmentions !=null) {
                                await PostinganAPI()
                                  .inputDataKomen(userFid: auth.cust.idUser, aidi: auth.getkondisikomen.toString(), komen: '@'+ auth.getmentions+ " " +a, cekbalasan: 0)
                                  .then((value) {
                                print(
                                    'value===================================' +
                                        value.toString());
                                if (value == 200) {
                                  setState(() {
                                    getdatat(auth.cust.idUser);
                                  auth.submitMentions = true;
                                  controller.clear();
                                  auth.clearmentions();
                                  });
                                } else {
                                  return null;
                                }
                              });
                              }else{
                                await PostinganAPI()
                                  .inputDataKomen(userFid: auth.cust.idUser, aidi: widget.p.idPost.toString(), komen:  a, cekbalasan: 1)
                                  .then((value) {
                                print(
                                    'value===================================' +
                                        value.toString());
                                if (value == 200) {
                                   setState(() {
                                    getdatat(auth.cust.idUser);
                                  auth.submitMentions = true;
                                  controller.clear();
                                  auth.clearmentions();
                                  });
                                } else {
                                  return null;
                                }
                              });
                              }
                            },
                            child: Container(
                                height: 40,
                                // width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Posting',
                                  style: TextStyle(
                                      color: a.length == 0 ?
                                          buttonFollowColor.withOpacity(0.4) : buttonFollowColor),
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(99),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      BaseUrl.img2 + widget.p.profileImage))
                              // color: primaryColor
                              ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: widget.p.idUser + ' ',
                                  style: titlename,
                                ),
                                TextSpan(
                                    text: widget.p.postDescription,
                                    style: subtittlekomen),
                              ])),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                timeSinceDate(widget.p.createdPosting),
                                style: subtittle2Text,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    // height: 30,
                    child: ListView.builder(
                        itemCount: data.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          KomenModel k = data.data[i];
                          return ListKomenItem(k: k,);
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

String timeSinceDate(String dateString, {bool numericDates = true}) {
  DateTime date = DateTime.parse(dateString);
  final date2 = DateTime.now();
  final difference = date2.difference(date);

  if ((difference.inDays / 365).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} tahun ';
  } else if ((difference.inDays / 365).floor() >= 1) {
    return (numericDates) ? '1 tahun ' : 'tahun';
  } else if ((difference.inDays / 30).floor() >= 2) {
    return '${(difference.inDays / 365).floor()} bulan ';
  } else if ((difference.inDays / 30).floor() >= 1) {
    return (numericDates) ? '1 bulan ' : 'bulan';
  } else if ((difference.inDays / 7).floor() >= 2) {
    return '${(difference.inDays / 7).floor()} minggu ';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '1 minggu ' : 'minggu';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} hari ';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1 hari ' : 'Kemarin';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} jam ';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1 jam ' : 'jam ';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} menit ';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 menit ' : 'menit ';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} detik ';
  } else {
    return 'Just now';
  }
}
