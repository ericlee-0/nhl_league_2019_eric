import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final String? image;
  final String? teamName;
  final bool? isIcon;

  const TeamCard({Key? key, this.image, this.teamName, this.isIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Card(
          elevation: 20,
          // color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.grey,
              image: DecorationImage(
                image: AssetImage(image!),
                // colorFilter: new ColorFilter.mode(
                //     Colors.black.withOpacity(0.4), BlendMode.dstATop),
                fit: BoxFit.fitWidth,
              ),
            ),
            width: isIcon! ? 50 : 150,
            height: isIcon! ? 50 : 200,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: isIcon!
                    ? SizedBox.shrink()
                    : Text(teamName!, style: TextStyle(fontSize: 20))),
          )),
    );
  }
}
