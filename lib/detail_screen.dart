import 'dart:async';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String text;

  DetailScreen(this.text);

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String updatedUrl = "assets/H.gif";
  Timer timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    print("Text : ${widget.text}");
  }

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    print("Text Received : ${widget.text}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Next"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontStyle: FontStyle.italic)),

          displayGifImage(widget.text),

          // FadeInImage(
          //   image: AssetImage('assets/'),
          // )
        ],
      ),
    );
  }

  Widget displayGifImage(String data) {
    print("Text Received in method : ${data}");

    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        print("DATA I : ${data[i]}");
        print("Length : ${data.length}");
        print("Data : $data");
        String singleLetter = data[i].toUpperCase();
        print("Singleletter : $singleLetter");

        imageUrl = 'assets/' + '${data[i].toUpperCase()}' + '.gif';
        print("ImageUrl : $imageUrl");


          Timer.periodic(Duration(microseconds: 3000), (Timer t) {
            timer = t;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300.0,
                height: 450.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: AssetImage(imageUrl), fit: BoxFit.cover)),
              ),
            );
          });
      }
      return Container();

    } else {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(),
      );
    }

//    if (data.isEmpty) {
//      print("Inside if condition");
//      return new Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Container(),
//      );
//    } else {
//      print("Inside else condition");
//      for (int i = 0; i < data.length; i++) {
//        print("DATA I : ${data[i]}");
//        print("Length : ${data.length}");
//        print("Data : $data");
//        String singleLetter = data[i].toUpperCase();
//        print("Singleletter : $singleLetter");
//
//        imageUrl = 'assets/' + '${data[i].toUpperCase()}' + '.gif';
//        print("ImageUrl : $imageUrl");
//
////        return new Padding(
////          padding: const EdgeInsets.all(8.0),
////          child: Container(
////            width: 300.0,
////            height: 450.0,
////            decoration: BoxDecoration(
////                borderRadius: BorderRadius.circular(20.0),
////                image: DecorationImage(
////                    image: AssetImage(imageUrl), fit: BoxFit.cover)),
////          ),
////        );
//
//
//
//
//        Timer.periodic(Duration(microseconds: 3000), (Timer t) {
//          timer = t;
//
////          setState(() {
////            updatedUrl = imageUrl;
////          });
//          return Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Container(
//              width: 300.0,
//              height: 450.0,
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(20.0),
//                  image: DecorationImage(
//                      image: AssetImage(imageUrl), fit: BoxFit.cover)),
//            ),
//          );
//
//          // Runs after every 1000ms
//
//        });
//
//      } //for loop end
//     // timer.cancel();
//      return Container();
//
//    }
  }
}
