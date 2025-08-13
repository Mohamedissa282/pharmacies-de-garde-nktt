import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BD extends StatefulWidget {
  const BD({super.key});

  @override
  State<BD> createState() => _BDState();
}

class _BDState extends State<BD> {
  List data =[];
    getData() async{
    QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection("maPharmacie").get();
    data.addAll(querySnapshot.docs);
        setState(() {
          
        });
    }
    void initState(){
      super.initState();
      getData();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
        title: Text("List Pharmacy"),
      ),
      body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("maPharmacie").snapshots(),
       builder: (context, snapshot) {
        if(snapshot.connectionState== ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
        }
          if(snapshot.hasError){
         Center(child: Text("Error:${snapshot.error}"),);
       }
     final docs = snapshot.data?.docs ?? [];
     return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, i){
      
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Card(
            child: ListTile(
              title: Text(docs[i]['nom'], style: TextStyle(
                color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold
              ),),
              subtitle: Text(docs[i]['Tel'], style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold
              ),),
              onTap: () {
  
            
              },
            ),
          ),
        );
         
     });
       }
    ));
  }
}

