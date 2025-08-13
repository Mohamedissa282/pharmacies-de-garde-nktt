import 'package:flutter/material.dart';

class test extends ChangeNotifier{
   String name = 'ar';
  void update(){
     String name = 'ar';
     String name2 = 'en';
     notifyListeners();
  }
}