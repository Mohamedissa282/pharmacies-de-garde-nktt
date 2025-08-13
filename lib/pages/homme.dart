import 'package:fastdelivery/generated/l10n.dart';
import 'package:fastdelivery/main.dart';
import 'package:fastdelivery/pages/page1.dart';
import 'package:fastdelivery/pages/page2.dart';
import 'package:fastdelivery/pages/page3.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class homme extends StatefulWidget {
  const homme({super.key});

  @override
  State<homme> createState() => _hommeState();
}

class _hommeState extends State<homme> {
  PageController controller = PageController();
bool lastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (i){
               setState(() {
                 lastpage = (i==2);
               });
            },
            children: [
              hommePage(),
              page2(),
               page3()
            ],
          ),

          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 52),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: isArabic() ? 0 : 13, right: isArabic() ? 13 : 0),
                  child: InkWell(
                    onTap: (){
  controller.jumpToPage(2);
                    },
                    child: Text(S.of(context).title4,style: TextStyle(
                      fontSize: isArabic() ? 21 : 19, fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
                SmoothPageIndicator(controller: controller, count: 3,effect: SwapEffect(
                   activeDotColor: Colors.green,
                   dotColor: Colors.blue
                ),),

                lastpage ?
                Padding(
                  padding:  EdgeInsets.only(right: isArabic() ? 0 : 13, left: isArabic()?13 : 0),
                  child: InkWell(
                      onTap: (){
Navigator.of(context).pushReplacementNamed('login');
                    },
                    child: Container(
                      height: 35, width: 70,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                      ),padding: EdgeInsets.all(4),
                      child: Align(alignment: Alignment.center,
                        child: Text(S.of(context).title5, style: TextStyle(
                          fontSize:isArabic() ? 21 : 19, fontWeight: FontWeight.bold, color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                ) :  Padding(
                  padding:  EdgeInsets.only(right: isArabic() ? 0 : 13 ,left: isArabic() ? 13 : 0),
                  child: InkWell(
                      onTap: (){
  controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                    child: Text(S.of(context).title6, style: TextStyle(
                      fontSize: isArabic() ? 21 : 19, fontWeight: FontWeight.bold
                    ),),
                  ),
                ) 
              ],
            ))
        ],
      ),
    );
  }
}