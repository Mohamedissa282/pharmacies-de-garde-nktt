import 'package:fastdelivery/Pharmacie/item.dart';
import 'package:fastdelivery/pages/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class favorite extends StatelessWidget {
  const favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.green,
        
        title: Text("Favorite", style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold
        ),),
        actions: [
          Consumer<languageProvider>(builder: (context, add2, child){
            return Padding(
              padding: const EdgeInsets.only(right: 11),
              child: Container(height: 21, width: 19,
              decoration: BoxDecoration(
             color: Colors.red,
             borderRadius: BorderRadius.circular(20)
              ),
                child: Center(
                  child: Text("${add2.myListItem2.length}", style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            );
          })
        ],
      ),
      body: Consumer<languageProvider>(builder: (context, add, child){
        return  ListView.builder(itemCount:add.count2 ,
        itemBuilder: (context, i){
        return Consumer<languageProvider>(builder: (context, rmv, child){
          return Card(
          child: ListTile(
            title:Text(add.myListItem2[i].title, style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold
            ),) ,
            subtitle: Text(add.myListItem2[i].numero, style: TextStyle(
              fontSize: 15
            ),) ,trailing: IconButton(onPressed: (){
        rmv.RemoveItem(item(title: rmv.myListItem2[i].title, numero: rmv.myListItem2[i].numero, distance: 0.0, lat:0.0, long: 0.0));
            }, icon: Icon(Icons.delete)),
          ),
        );
        });
      });
      })
    );
  }
}