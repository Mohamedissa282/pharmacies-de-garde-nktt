import 'package:fastdelivery/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class page2 extends StatelessWidget {
  const page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            SizedBox(height: 33,),
            Lottie.asset("Assets2/animation1.json", height: 400, width: 300),
            Text(S.of(context).titele2,
             style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold
             ),), SizedBox(height: 144,),
           /*  InkWell(
              onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=> page3()));
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