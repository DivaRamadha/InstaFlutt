import 'package:flutter/material.dart';
import 'package:instaflutt/theme/colors.dart';
import 'package:instaflutt/theme/textStyles.dart';

class StoryItem extends StatelessWidget {
  final String img;
  final String name;
  const StoryItem({
    Key key, this.img, this.name, 

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20,bottom: 10),
      child: Column(
      children: <Widget>[
        Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: storyBorderColor)
      ),
              child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            border: Border.all(
              color: white,
              width: 2
            ),
            shape: BoxShape.circle,
            image: DecorationImage(image: 
            NetworkImage(img,),fit: BoxFit.cover)
          ),
        ),
      ),
          ),
          SizedBox(height: 2,),
          Container(
            alignment: Alignment.center,
      width: 70,
      child: 
      Text(name,
      overflow: TextOverflow.ellipsis,
      style: subtittle2Text),
          )
      ],
          ),
    );
  }
}