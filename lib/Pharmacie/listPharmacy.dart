import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastdelivery/Pharmacie/item.dart';
import 'package:fastdelivery/generated/l10n.dart';
import 'package:fastdelivery/main.dart';
import 'package:fastdelivery/pages/Drawer/contact-nous.dart';
import 'package:fastdelivery/pages/Drawer/favorite.dart';
import 'package:fastdelivery/pages/LanguageProvider.dart';
import 'package:fastdelivery/pages/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';

//import 'package:vibration/vibration.dart';

class listPharmacy extends StatefulWidget {
  const listPharmacy({super.key});

  @override
  State<listPharmacy> createState() => _listPharmacyState();
}

class _listPharmacyState extends State<listPharmacy> {

  

  void calculateDistances() {
    for (var pharmacy in data) {
      double distance = Geolocator.distanceBetween(
        Provider.of<languageProvider>(context, listen: false).latitude,
        Provider.of<languageProvider>(context, listen: false).longitude,
        pharmacy['lat'],
        pharmacy['lng'],
      );
      pharmacy['distance'] = distance / 1000; // Convertir en kilomètres
      print("La distance est : ${pharmacy['distance']} Km");
    }
    data.sort((a, b) => a['distance'].compareTo(b['distance']));
    setState(() {});
  }
  StreamSubscription<Position>? positionStream ;
   Future<void> getCurrentPosition() async{
    bool serviceEnabled;
     LocationPermission permission;
     
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
     if(! serviceEnabled){
        print("Not enable");
        return ;
     }
     permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
             return Future.error('Erreur!');
    }
  
  }
    if(permission == LocationPermission.whileInUse){
   positionStream = Geolocator.getPositionStream().listen(
    (Position? position) {
     
Provider.of<languageProvider>(context, listen: false).setPosition(position!.latitude, position.longitude);
      
calculateDistances();

        setState(() {
         
         

        });
        
    });
    
    }
  } 
   List<Map<String, dynamic>> data = [];
    Future<void>  getData() async{
    QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection("maPharmacie").get();
    List<Map<String, dynamic>> tempPharmacies = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['distance'] = 0.0; // Initialiser la distance à 0.0
      tempPharmacies.add(data);
    }
    setState(() {
      data = tempPharmacies;
    });
    calculateDistances();
        
    }
    
  void initState(){
    super.initState();
    getCurrentPosition();
    getData();
    
    getData2();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(backgroundColor: Colors.white70,
    title: Row(
      children: [
        Text(isArabic() ?" صيد ": "Ma", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
        Text(isArabic() ? "لياتي" : "Pharmacie", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
      ],
    ),
    actions: [
      IconButton(onPressed: (){
  showSearch(context: context, delegate: CustomSearch());
      }, icon: Icon(Icons.search, color: Colors.black, size: 27,))
    ],
   ),
     drawer: Drawer(backgroundColor: Colors.green[400],
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(S.of(context).title26, style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18
            ),)),
           Column(
           
            children: [
              Column( 
              children: [
                 Row(
              children: [
              IconButton(onPressed: (){
                  
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> favorite()));
              }, icon:Icon(Icons.favorite)),
                SizedBox(width: 33,),
                Text(S.of(context).title25, style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18
            ),)
              ],
            ),SizedBox(height: 33,),
           
            Row(
              children: [
            IconButton(onPressed: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> contactNous()));
            }, icon: Icon(Icons.phone))
              ,SizedBox(width: 33,),
                Text(S.of(context).title23, style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17
            ),)
              ],
            ),
     SizedBox(height: 33,),
          
              ],
              ),
                Row(
              children: [
            IconButton(onPressed: () async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil("login", (route)=> false);
            }, icon: Icon(Icons.logout))
              ,SizedBox(width: 33,),
                Text(S.of(context).title24, style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17
            ),)
              ],
            )
            ],
           )
            
        ],

        
      ),
      
     ),
     body:Padding(
       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
       child: ListView.builder(itemCount: data.length,
        itemBuilder: (context, i){
        return Column(
          children: [
            ListTile(
              title: Text(data[i]['nom'], style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18
              ),),
              subtitle: Text(data[i]['Tel'], style: TextStyle(
                color: Colors.black,  fontSize: 16
              ),),
              // ${mypharm[i].distance.toStringAsFixed(2)} km"
              trailing: Text("${(data[i]['distance'] as num).toDouble().toStringAsFixed(2) }${S.of(context).title29}", style: TextStyle(
                color: Colors.green, fontSize: 16 , fontWeight: FontWeight.bold
              ),),
              onTap: (){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>maps(name: data[i]['nom'],numeroTel: data[i]['Tel'], lat: data[i]['lat'], long:data[i]['lng'],), ));
              },
              
            ),Divider(thickness: 4,)
          ],
        );
       }),
     ),
    );
  }
}

  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> secondsList = [];
    Future<void>  getData2() async{
    QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection("maPharmacie").get();
    List<Map<String, dynamic>> tempPharmacies = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data2 = doc.data() as Map<String, dynamic>;
      data2['distance'] = 0.0; // Initialiser la distance à 0.0
      data.add(data2);
    }
    
   
        
    }
    
   
  
List data3 = [];List data4 = [];

class CustomSearch extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
       IconButton(onPressed: (){
     query = '';
       }, icon: Icon(Icons.close, color: Colors.green,))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
  return IconButton(onPressed: (){
 Navigator.of(context).pop();
       }, icon: Icon(Icons.arrow_back, color: Colors.green,));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if(query==""){
      return ListView.builder(itemCount: data.length,
        itemBuilder: (context, i){
        return Column(
          children: [
            Card(
              child: ListTile(
                 title: Text(data[i]['nom'], style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18
              ),),
              subtitle: Text(data[i]['Tel'], style: TextStyle(
                color: Colors.black,  fontSize: 16
              ),),
              
                onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>maps(name: data[i]['nom'],numeroTel: data[i]['Tel'], lat: data[i]['lat'], long:data[i]['lng'],), ));
                },
                
              ),
            ),
          ],
        );
       });
    }else{
      secondsList = data.where((e)=> e.containsKey(query)).toList();
       print("############################################");
         print(secondsList);
      return 
      ListView.builder(itemCount: secondsList.length,
        itemBuilder: (context, i){
        return Column(
          children: [
            Card(
              child: ListTile(
                 title: Text(secondsList[i]['nom'], style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18
              ),),
              subtitle: Text(secondsList[i]['Tel'], style: TextStyle(
                color: Colors.black,  fontSize: 16
              ),),
              
                onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>maps(name: data[i]['nom'],numeroTel: data[i]['Tel'], lat: data[i]['lat'], long:data[i]['lng'],), ));
                },
                
              ),
            ),
          ],
        );
       });
    }
  }

}

