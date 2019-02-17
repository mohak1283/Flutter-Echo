import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static FirebaseDatabase firebaseDatabase = FirebaseDatabase();
  DatabaseReference databaseReference =
      firebaseDatabase.reference().child("logs");
  StreamSubscription<Event> subscription;
  var data = '';
  FlutterTts flutterTts = new FlutterTts();
  GoogleTranslator translator = GoogleTranslator();
  var stringsArray = [];
  StringBuffer myString = new StringBuffer(" ");

  var _languages = ["English", "French", "Chinese", "Sanskrit"];

  var current;

  @override
  void initState() {
    super.initState();
    subscription = databaseReference.onChildAdded.listen((event) {
      setState(() {
        data = event.snapshot.value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Echo"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                data,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            gifWidget(data),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                myString.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Translate into : ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: DropdownButton<String>(
                items: _languages.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newItemSelected) {
                  setState(() {
                    current = newItemSelected;
                    // translateAndSpeak(data, current);
                  });
                },
                value: current,
              ),
              //       child: DropdownButton<String>(
              //             items: _priorities.map((String dropDownStringItem) {
              //               return DropdownMenuItem<String>(
              //                 value: dropDownStringItem,
              //                 child: Text(dropDownStringItem),
              //               );
              //             }).toList(),
              //             onChanged: (String newItemSelected) {
              //               updatePriorityAsInt(newItemSelected);
              //             },
              //             style: textStyle,
              //             value: updatePriorityAsString(note.priority),
              //           ),
              //         ),

              // )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: 300.0,
              //     height: 450.0,
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //             image: AssetImage('assets/test.gif'),
              //             fit: BoxFit.cover)),
              //   ),
              // )
            )
          ],
        ),
      ),
    );
  }

  Widget gifWidget(String data) {
    switch (data) {
      case 'A':
        return gifContainerWidget('A');
        break;
      case 'B':
        return gifContainerWidget('B');
        break;
      case 'C':
        return gifContainerWidget('C');
        break;
      case 'D':
        return gifContainerWidget('D');
        break;
      case 'E':
        return gifContainerWidget('E');
        break;
      case 'F':
        return gifContainerWidget('F');
        break;
      case 'G':
        return gifContainerWidget('G');
        break;
      case 'H':
        return gifContainerWidget('H');
        break;
      case 'I':
        return gifContainerWidget('I');
        break;
      case 'J':
        return gifContainerWidget('J');
        break;
      case 'K':
        return gifContainerWidget('K');
        break;
      case 'L':
        return gifContainerWidget('L');
        break;
      case 'M':
        return gifContainerWidget('M');
        break;
      case 'N':
        return gifContainerWidget('N');
        break;
      case 'O':
        return gifContainerWidget('O');
        break;
      case 'P':
        return gifContainerWidget('P');
        break;
      case 'Q':
        return gifContainerWidget('Q');
        break;
      case 'R':
        return gifContainerWidget('R');
        break;
      case 'S':
        return gifContainerWidget('S');
        break;
      case 'T':
        return gifContainerWidget('T');
        break;
      case 'U':
        return gifContainerWidget('U');
        break;
      case 'V':
        return gifContainerWidget('V');
        break;
      case 'W':
        return gifContainerWidget('W');
        break;
      case 'X':
        return gifContainerWidget('X');
        break;
      case 'Y':
        return gifContainerWidget('Y');
        break;
      case 'Z':
        return gifContainerWidget('Z');
        break;
      case '.':
        return gifContainerWidget('.');
        break;
      default:
        return gifContainerWidget(" ");
    }
  }

  Widget gifContainerWidget(String data) {
    if (data == " ") {
      setState(() {
        myString.write(" ");
      });
      _speak(myString.toString(), current);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 300.0,
          height: 400.0,
        ),
      );
    } else if (data == ".") {
      _speak(myString.toString(), current);

      setState(() {
        myString.clear();
        print("MyString value : ${myString.toString()}");
      });

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(),
      );
    } else {
      setState(() {
        myString.write(data);
      });

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 300.0,
          height: 450.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                  image: AssetImage('assets/' + '$data' + '.gif'),
                  fit: BoxFit.cover)),
          // child: FadeInImage(
          //   placeholder: AssetImage('assets/'),
          //   image: AssetImage('assets/' + '$data' + '.gif'),
          //   fit: BoxFit.cover,
          // ),
        ),
      );
    }
  }

  void _speak(String data, String currentLanguage) async {
    print("Current Language : $currentLanguage");
    if (currentLanguage == "English") {
      await flutterTts.speak(data);
    } else if (currentLanguage == "French") {
      translator.translate(data, to: 'fr').then((s) {
        print("Source: " +
            data +
            "\n"
            "Translated: " +
            s +
            "\n");
        flutterTts.speak(s);
      });
    } else if (currentLanguage == "Chinese") {
      translator.translate(data, to: 'zh').then((s) {
        print("Source: " +
            data +
            "\n"
            "Translated: " +
            s +
            "\n");
        flutterTts.speak(s);
      });
    } else if (currentLanguage == "Sanskrit") {
      translator.translate(data, to: 'sa').then((s) {
        print("Source: " +
            data +
            "\n"
            "Translated: " +
            s +
            "\n");
        flutterTts.speak(s);
      });
    }

    // await flutterTts.speak(data);

    // translator.translate(data, to: 'hi').then((s) {
    //   print("Source: " +
    //       data +
    //       "\n"
    //       "Translated: " +
    //       s +
    //       "\n");
    //   // flutterTts.speak(s);
    // });
  }
}
