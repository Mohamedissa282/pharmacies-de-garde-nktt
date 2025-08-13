import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  final String name;
  const myButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return  Align(alignment: Alignment.center,
                        child: Container(
                          height: 50,width: 305,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.green
                          ),
                          child: Align(alignment: Alignment.center,
                            child: Text(name, style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold, fontSize: 17
                            ),),
                          ),
                          
                        ),
                      );
  }
}