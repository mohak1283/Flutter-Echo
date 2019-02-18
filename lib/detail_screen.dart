import 'dart:async';

import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String text;

  DetailScreen(this.text);

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
 
   print("Text Received : ${widget.text}");

    return Scaffold(
      appBar: AppBar(title: Text("Next"),),
        body: Column(
          children: <Widget>[
            Text(widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic
                )),

                

              //  displayGifImage(widget.text),

            // FadeInImage(
            //   image: AssetImage('assets/'),
            // )    
          ],
        ),        );
  }

//   Widget displayGifImage(String data){
//     print("Text Received in method : ${data}");
//     if(data.isEmpty){
//        print("Inside if condition");
//       return new Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(),
//       );
//     }else{
//       print("Inside else condition");
//     for(int i = 0; i<data.length;i++){
//      String singleLetter =data[i].toUpperCase();
//      print("Singleletter : $singleLetter");
//      String imageUrl = 'assets/'+'${singleLetter}'+'.gif';
//      print("ImageUrl : $imageUrl");
    
//     Timer.periodic(Duration(microseconds: 3000), (Timer t) {
//    // Runs after every 1000ms
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           width: 300.0,
//           height: 450.0,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20.0),
//               image: DecorationImage(
//                   image: AssetImage(imageUrl),
//                   fit: BoxFit.cover)),
         
//         ),
//       );

// });


//    }
//     }

   

//   }

 
  }


