
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class SettingsProvider with ChangeNotifier {

  final List<String> _voicesList = [
    'Male Voice 1',
    'Male Voice 2',
    'Male Voice 3',
    'Female Voice 1',
    'Female Voice 2',
    'Female Voice 3'
  ];

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  List<String> get voicesList => _voicesList;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }




}