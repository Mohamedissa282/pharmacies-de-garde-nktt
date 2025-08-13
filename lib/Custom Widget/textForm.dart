import 'package:flutter/material.dart';

class textform extends StatelessWidget {
  final String name;
  final TextEditingController? mycontroller;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool obscureText ;
  final String? Function(String?)? validator;
  const textform({super.key, required this.name, this.mycontroller, this.suffixIcon, this.onTap, required this.obscureText, this.validator});

  @override
  Widget build(BuildContext context) {
    
    return  TextFormField(onTap:onTap ,obscureText:obscureText ,
      controller: mycontroller,
      validator: validator,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: name, hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.grey[200], filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),suffixIcon:suffixIcon ,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green, width: 2
                          ),
                          borderRadius: BorderRadius.circular(7)
                        )
                      ),
                    );
  }
}