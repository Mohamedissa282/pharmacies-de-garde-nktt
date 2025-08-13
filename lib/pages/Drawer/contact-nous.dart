import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class contactNous extends StatelessWidget {
  const contactNous({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
 Future<void> sendSMS(String phoneNumber, String message) async {
  final Uri smsUri = Uri(
    scheme: 'sms',
    path: phoneNumber,
    queryParameters: <String, String>{
      'body': message,
    },
  );
  await launchUrl(smsUri);
}
Future<void> sendEmail(String emailAddress, String subject, String body) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: emailAddress,
    queryParameters: <String, String>{
      'subject': subject,
      'body': body,
    },
  );
  await launchUrl(emailUri);
}


    return Scaffold(backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
    ),
      body: SafeArea(child: 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGjDUKJspUWO0OYaxeqdV-es0xhtmPcf0WZg&s"),
          ),
          SizedBox(height: 22,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
      sendSMS("26705419", "Bonjour");
              }, icon: Icon(Icons.sms, size: 29,)),SizedBox(width: 26,),
              Text("SMS", style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold
              ),)
            ],
          ),SizedBox(height: 11,),
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
   makePhoneCall("26705419");
              }, icon: Icon(Icons.call, size: 29)),SizedBox(width: 26,),
              Text("Telephone", style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold
              ),)
            ],
          ),SizedBox(height: 11,),
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
    sendEmail("mohamedissa4730@gmail.com", "Question", "Comment installer l'application?");
              }, icon: Icon(Icons.email, size: 29)),SizedBox(width: 26,),
              Text("Email", style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold
              ),)
            ],
          )
        ],
      )),
    );
  }

}