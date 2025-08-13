import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fastdelivery/Custom%20Widget/myButton.dart';
import 'package:fastdelivery/Custom%20Widget/textForm.dart';
import 'package:fastdelivery/Pharmacie/listPharmacy.dart';
import 'package:fastdelivery/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController mycontroller = TextEditingController();
  TextEditingController mycontroller2 = TextEditingController();
  GlobalKey<FormState> valide = GlobalKey();
  bool obscure = true;
  bool saving = false;
Future<void> signInWithGoogle2() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      // L'utilisateur s'est connecté avec succès
      print('Connexion réussie : ${googleUser.email}');
    }
  } catch (error) {
    print('Erreur lors de la connexion : $error');
  }
}

  

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
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
   body: ModalProgressHUD(inAsyncCall: saving, child: 
  SafeArea(
     child: Column(
      children: [
        SizedBox(height: 11,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 11),
          child: Align(alignment: Alignment.topLeft,
            child: Text(S.of(context).title9, style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21
            ),),
          ),
        ), SizedBox(height: 36,),
        Expanded(child: SingleChildScrollView(
          child: Container(
           
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(16),  topRight: Radius.circular(16))
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  key:  valide,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 22,),
                         Text("${S.of(context).title11} 🙌", style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24
                          ),),
                        
                        Text(S.of(context).title12,style: TextStyle(
                          color: Colors.grey, fontSize: 15
                        ),),
                        SizedBox(height: 28,),
                       textform(name: S.of(context).title13, mycontroller:mycontroller ,obscureText: false,validator: validateEmail,
                  
                       ),
                       SizedBox(height: 21,),
                        textform(name: S.of(context).title14, mycontroller:mycontroller2 ,obscureText: obscure,
                        suffixIcon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
                        onTap: (){
                          change();
                        },validator: validatePassword,
                        
                        ),SizedBox(height: 16,),
                        InkWell(
                        onTap: () async{

                          if(mycontroller.text.isEmpty){
                            AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.info,
                                     animType: AnimType.rightSlide,
                                     
                                    desc:S.of(context).title31,
                                      descTextStyle: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14
                                    ),
                                     btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                             )..show();
                            return  ;

                          }
                          else{
                               await FirebaseAuth.instance.sendPasswordResetEmail(email: mycontroller.text);
                  AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.success,
                                     animType: AnimType.rightSlide,
                                     
                                    desc:S.of(context).title30,
                                    descTextStyle: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14
                                    ),
                                     btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                             )..show(); 
                          }
                        
                          
                        },
                          child:  Align(alignment: Alignment.topRight,
                          child: Text(S.of(context).title15, style: TextStyle(
                                color: Colors.black,fontWeight: FontWeight.bold, fontSize: 15
                              ),)), 
                        ),
                      
                         SizedBox(height: 26,),
                         InkWell(
                          onTap: () async{
               if(valide.currentState!.validate()){
                
                setState(() {
                  saving = true;
                });
                try {
                  
                                
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                 email:mycontroller.text,
                                password: mycontroller2.text
                         );
                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> listPharmacy()));
                         setState(() {
                  saving = false;
                });
                           } on FirebaseAuthException catch (e) {
                   if (e.code == 'user-not-found') {
                          AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.error,
                                     animType: AnimType.rightSlide,
                                     title: 'Erreur',
                                    desc: 'No user found for that email.',
                                     btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                             )..show(); 
                        print('No user found for that email.');
                               } else if (e.code == 'wrong-password') {
                                     AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.error,
                                     animType: AnimType.rightSlide,
                                     title: 'Erreur',
                                    desc: 'Wrong password provided for that user.',
                                     btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                             )..show(); 
                     print('Wrong password provided for that user.');
                              }
                               }
               }     
                               
                          },
                          child: myButton(name: S.of(context).title9)),
                          Align(alignment: Alignment.topRight,
                            child: TextButton(onPressed: (){
                                             Navigator.of(context).pushReplacementNamed('SignUp');
                            }, child: Text(S.of(context).title10)),
                          ),
                          SizedBox(height: 33,),
                        Row(
                          children: [
                            Expanded(child: Divider(thickness: 1,)),
                            Padding(
                              padding: const EdgeInsets.only(left: 11, right: 11),
                              child: Text(S.of(context).title18),
                            ),
                             Expanded(child: Divider(thickness: 1,)),
                          ],
                        ),SizedBox(height: 47,),
                        Align(alignment: Alignment.center,
                          child: InkWell(
                            onTap: (){
                              signInWithGoogle2();
                            },
                            child: Container(
                              
                              height: 55, width: 330,
                              decoration: BoxDecoration(
                                color: Colors.white,border: Border.all(color: Colors.green, width: 1)
                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                               
                                                Image.network("https://img.icons8.com/?size=512&id=17949&format=png", fit: BoxFit.cover,width: 40,),
                                                SizedBox(width: 12,),
                                                Text(S.of(context).title19, style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19
                                                ),)
                                              ],
                                              ),
                            ),
                          ),
                        ),
                               SizedBox(height: 58,),
                      
                      /*  Text(
                    "Bienvenue chez PharmacyGuard!",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color(0xFF2C3E50),
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(64, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),*/
                  
                  
                        SizedBox(height: 94,)
                            
                      ],
                    ),
                ),
              ),
              
            
          ),
        ))
      ],
     ),
   ),
  ),
    );
  }
}