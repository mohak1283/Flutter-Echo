
import 'package:flutter/material.dart';

class Voice {

  String _text;
  bool _isChecked;
  IconData _icon;



  Voice(this._text, this._isChecked, this._icon);


  String get text => _text;

  set text(String value) {
    _text = value;
  }

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
  }

  IconData get icon => _icon;

  set icon(IconData value) {
    _icon = value;
  }


}