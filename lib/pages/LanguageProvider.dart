import 'package:fastdelivery/Pharmacie/item.dart';
import 'package:flutter/material.dart';

class languageProvider with ChangeNotifier{
  double _latitude = 0.0; 
 double _longitude = 0.0;
  Locale _locale = Locale("en");
  Locale get local => _locale;
  void ChangeLanguage(String langCode){
        _locale = Locale(langCode);
        notifyListeners();
  }
  List<item> myListItem = [];
  
  List<item> get myListItem2 => myListItem;
 void addItem(item itemAdd) { 
  myListItem.add(itemAdd); 
  notifyListeners(); 
  }
  void RemoveItem(item itemAdd) { 
  myListItem.remove(itemAdd); 
  notifyListeners(); 
  }
  List monList = [];
  void addMonList(String title, String name){
     monList.add(title); monList.add(name);
     notifyListeners();
  }
  void RemoveMonList(String title, String name){
     monList.remove(title); monList.add(name);
     notifyListeners();
  }
  int get count{
    return monList.length;
  }
  int get count2{
    return myListItem2.length;
  }
 double get latitude => _latitude;
 double get longitude => _longitude;
  void setPosition(double latitude, double longitude) {
_latitude = latitude; _longitude = longitude;
 notifyListeners();
 } 
}