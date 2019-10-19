import 'package:echo/models/voice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  SharedPreferences sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  SettingsProvider.instance() {
    init();
  }

  final List<Voice> _voicesList = [
    Voice('Male Voice 1', false, Icons.play_arrow),
    Voice('Male Voice 2', false, Icons.play_arrow),
    Voice('Male Voice 3', false, Icons.play_arrow),
    Voice('Female Voice 1', false, Icons.play_arrow),
    Voice('Female Voice 2', false, Icons.play_arrow),
    Voice('Female Voice 3', false, Icons.play_arrow)
  ];

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  List<Voice> get voicesList => _voicesList;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setCurrentItem(int index, List<Voice> newList, bool value) {
    _voicesList[index].isChecked = value;
    notifyListeners();
  }

  void setVoiceValue(String voice) {
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

    print(newVoice);

    sharedPreferences.setString('voice', newVoice).then((status) {
      if (status) {
        print("Value Set");
      }
    });
  }

  String getVoiceValue() {
    String voice = sharedPreferences.getString('voice');
    return voice;
  }
}
