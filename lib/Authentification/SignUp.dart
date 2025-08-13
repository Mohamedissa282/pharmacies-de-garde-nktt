import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fastdelivery/Custom%20Widget/myButton.dart';
import 'package:fastdelivery/Custom%20Widget/textForm.dart';
import 'package:fastdelivery/Pharmacie/listPharmacy.dart';
import 'package:fastdelivery/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SingnUp extends StatefulWidget {
  const SingnUp({super.key});

  @override
  State<SingnUp> createState() => _SingnUpState();
}

class _SingnUpState extends State<SingnUp> {
  TextEditingController mycontroller = TextEditingController();
  TextEditingController mycontroller2 = TextEditingController();
  GlobalKey<FormState> valide = GlobalKey();
  bool obscure = true;
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).title20;
    }
    String emailExpress = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(emailExpress);
    if (!regExp.hasMatch(value)) {
      return S.of(context).title21;
    }
    return null;
  }
   String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).title22;
    }}
  void change(){
    setState(() {
      obscure = !obscure;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.green,
   body: SafeArea(
     child: Column(
      children: [
        SizedBox(height: 11,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 11),
          child: Align(alignment: Alignment.topLeft,
            child: Text(S.of(context).title10, style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21
            ),),
          ),
        ), SizedBox(height: 36,),
        Expanded(child: SingleChildScrollView(
          child: Container(
           height: 999,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(16),  topRight: Radius.circular(16))
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  key: valide,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 22,),
                         Text("${S.of(context).title11} 🙌", style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24
                          ),),
                        
                        Text(S.of(context).title0,style: TextStyle(
                          color: Colors.grey, fontSize: 15
                        ),),
                        SizedBox(height: 28,),
                       textform(name: S.of(context).title13, mycontroller:mycontroller ,obscureText: false, 
                      validator: validateEmail,
                       ),
                       SizedBox(height: 21,),
                        textform(name: S.of(context).title14, mycontroller:mycontroller2 ,obscureText: obscure,
                        suffixIcon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
                        onTap: (){
                          change();
                        },validator: validatePassword,
                        ),SizedBox(height: 16,),
                       
                         SizedBox(height: 26,),
                         InkWell(
                          onTap: () async{
                    if(valide.currentState!.validate()){
                         try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                         email: mycontroller.text,
                         password: mycontroller2.text
                     );
                               } on FirebaseAuthException catch (e) {
                       if (e.code == 'weak-password') {
                          AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.error,
                                     animType: AnimType.rightSlide,
                                     title: 'Erreur',
                                    desc: 'The password provided is too weak.',
                                     btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                             )..show();  
                       print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {


                      AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.error,
                                     animType: AnimType.rightSlide,
                                     title: 'Erreur',
                                    desc: 'The account already exists for that email.',
                                     btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                             )..show(); 
                        print('The account already exists for that email.');
                  }
                   Navigator.of(context).pushReplacementNamed('pharmacyList');
                             } catch (e) {
                                 print(e);
                               }
                    }
                          },
                          child: myButton(name: S.of(context).title10)),
                           Align(alignment: Alignment.topRight,
                            child: TextButton(onPressed: (){
                                             Navigator.of(context).pushReplacementNamed('login');
                            }, child: Text(S.of(context).title9)),
                          ),
                          
                       
                        
                      
                  
                  
                        
                            
                      ],
                    ),
                ),
              ),
              
            
          ),
        ))
      ],
     ),
   ),
    );
  }
}