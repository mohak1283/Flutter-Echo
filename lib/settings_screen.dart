import 'package:echo/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  FlutterTts flutterTts = new FlutterTts();
  IconData icon = Icons.play_arrow;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              print("Value : ${provider.getVoiceValue()}");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Icon(
                Icons.save,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
            children: <Widget>[
        ...List.generate(provider.voicesList.length, (int index) {
          return GestureDetector(
            onTap: () {
              flutterTts.setVoice(
                  setCurrentVoice(provider.voicesList[index].text));
              flutterTts.speak("Welcome to Echo!!!");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "${provider.voicesList[index].text}                             ",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Checkbox(
                      value: provider.voicesList[index].isChecked,
                      onChanged: (bool value) {
                        provider.setCurrentItem(
                            index, provider.voicesList, value);
                        provider
                            .setVoiceValue(provider.voicesList[index].text);
                      }),
                ),
              ],
            ),
          );
        })
        ],
      ),
    ),);
  }

  String setCurrentVoice(String voice) {
    print("Default Voice : $voice");
    String newVoice = '';
    switch (voice) {
      case 'Male Voice 1':
        newVoice = 'id-id-x-dfz#male_1-local';
        break;
      case 'Male Voice 2':
        newVoice = 'th-th-x-mol#male_1-local';
        break;
      case 'Male Voice 3':
        newVoice = 'en-in-x-ahp#male_1-local';
        break;
      case 'Female Voice 1':
        newVoice = 'en-gb-x-fis#female_1-local';
        break;
      case 'Female Voice 2':
        newVoice = 'ru-ru-x-dfc#female_3-local';
        break;
      case 'Female Voice 3':
        newVoice = 'it-it-x-kda#female_2-local';
        break;
    }
    return newVoice;
  }
}