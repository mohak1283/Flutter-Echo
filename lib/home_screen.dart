import 'dart:async';

import 'package:echo/detail_screen.dart';
import 'package:echo/provider/settings_provider.dart';
import 'package:echo/settings_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:translator/translator.dart';

import 'models/language.dart';

const languages = const [
  const Language('Francais', 'fr_FR'),
  const Language('English', 'en_US'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),
];

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

  var _languages = ["English", "French"];
  static const platform = const MethodChannel('samples.flutter/call');

  //var _speech;

  var current;
  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    get();
  }

  @override
  void initState() {
    super.initState();
    _speech = SpeechRecognition();
    get();
    activateSpeechRecognizer();
    subscription = databaseReference.onChildAdded.listen((event) {
      setState(() {
        data = event.snapshot.value;
      });
    });
  }

  get() async {
    print("Inside get");
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String voice = _sharedPreferences.getString('voice');
    if (voice != null && voice.isNotEmpty) {
      flutterTts.setVoice(voice);
    }

    print("NEWVOICE : $voice");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);

    //_speech.setErrorHandler(errorHandler);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> callUser() async {
    try {
      final int result = await platform.invokeMethod('callUser');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage() async {
    try {
      final int result = await platform.invokeMethod('sendMessage');
    } on PlatformException catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    print("Inside build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Echoo"),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<SettingsProvider>(
                            child: SettingsScreen(),
                            builder: (context) => SettingsProvider.instance(),
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _speechRecognitionAvailable && !_isListening ? () => start() : null,
          child: Icon(Icons.mic),
      ),
      body: Center(
        child: SingleChildScrollView(
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
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget gifWidget(String data) {
    print("Data : $data");

    if (data == 'Emergency Call' || data == 'emergency call' || data == 'Emergency call') {
      callUser();
    } else if (data == 'MESSAGE' || data == 'message' || data == 'Message') {
      sendMessage();
    } else if(data == 'Yes absolutely, it\'s obvious' || data == 'yes absolutely, it\'s obvious' || data == 'Yes Absolutely, it\'s obvious') {
      setState(() {
        myString.write("Yes absolutely, it\'s obvious");
      });
      _speak(myString.toString(), current);
    } else if(data == 'Thank you everyone' || data == 'Thank You everyone') {
      setState(() {
        myString.write("Thank you everyone");
      });
      _speak(myString.toString(), current);
    }

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
  }

  void start() => _speech
      .listen(locale: selectedLang.code)
      .then((result) => print('RESULT :  ${result.toString()}'));

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() => _speech.stop().then((result) {
        setState(() => _isListening = result);
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) {
    setState(() {
      transcription = text;
      print("Transcription : $transcription");
    });
  }

  void onRecognitionComplete() {
    setState(() {
      _isListening = false;
    });
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: ((context) => new DetailScreen(transcription))));
  }

  //void onRecognitionComplete() => setState(() => _isListening = false);

  void errorHandler() => activateSpeechRecognizer();
}
