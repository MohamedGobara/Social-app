import 'package:flutter/material.dart';
import 'package:sochial_app/Global/Colors.dart' as MyColors;
import 'package:sochial_app/Global/Settings.dart' as Settings;

class ReceivedMessageWidget extends StatelessWidget {
  final String content;
  final String imageAddress;
  final String time;
  final bool isImage;
  const ReceivedMessageWidget({
    Key key,
    this.content,
    this.time,
    this.isImage,
    this.imageAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding:
          const EdgeInsets.only(right: 75.0, left: 8.0, top: 8.0, bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)),
        child: Container(
          color: Colors.greenAccent,
          child: Stack(
            children: <Widget>[
              !isImage
                  ? Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, top: 8.0, bottom: 15.0),
                      child: Text(
                        content,style: TextStyle (color: Colors.black87 , fontWeight: FontWeight.bold)
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, top: 8.0, bottom: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Image.asset(
                              imageAddress,
                              height: 130,
                              width: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            content,style: TextStyle (color: Colors.black87 , fontWeight: FontWeight.bold)
                          )
                        ],
                      ),
                    ),
              Positioned(
                bottom: 1,
                right: 10,
                child: Text(
                  time,
                  style: TextStyle(
                      fontSize: 10, color: Colors.blueGrey),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
