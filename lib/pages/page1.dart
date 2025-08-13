import 'package:fastdelivery/generated/l10n.dart';
import 'package:fastdelivery/pages/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';


class hommePage extends StatelessWidget {
  const hommePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            SizedBox(height: 13,),
            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: PopupMenuButton(icon: Icon(Icons.language, color: Colors.black, size: 28,),
                itemBuilder: (context)=>[
                PopupMenuItem(onTap: (){
                  Provider.of<languageProvider>(context, listen: false).ChangeLanguage("ar");
                },
                  child: Text(S.of(context).title7, style: TextStyle(
                  color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold
                ),)),
                 PopupMenuItem(
                  onTap: (){
                    Provider.of<languageProvider>(context, listen: false).ChangeLanguage("en");
                  },
                  child: Text(S.of(context).title8, style: TextStyle(
                  color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold
                ),))
              ]),
            ),
            Lottie.asset("Assets2/animation2.json", height: 400, width: 300),
            Text(S.of(context).title1,
             style: TextStyle(
              fontSize: 18,  color: Colors.black,fontWeight: FontWeight.bold, fontFamily: 'Roboto',
          
             ),), SizedBox(height: 144,),
         /*    InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> page2()));
              },
               child: Container(
                height: 50,width: 300,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12)
                ),child: Align(alignment: Alignment.center,
                  child: Text("Next", style: TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
                  ),)),
               ),
             )*/
          ],
        ),
      ),
    );
  }
}
