import 'package:flutter/material.dart';
import 'dart:io';

class Thankyou extends StatefulWidget {
  const Thankyou({Key? key}) : super(key: key);

  @override
  State<Thankyou> createState() => _ThankyouState();
}

class _ThankyouState extends State<Thankyou> {
  @override
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      resizeToAvoidBottomInset:false,   
      body: Container(
           decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff252424), Color(0xff203e3c)],
        )),
child: Column(
  children: [
            SizedBox(height: 250,),
    
               Container(
                 
                   padding: EdgeInsets.only(left: 10.0, right: 10),
                      width: 390,
                      height: 300,
                       child: Card(
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color(0xffc5deba),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                      alignment: Alignment.topRight,
               padding: EdgeInsets.only(left: 10,top: 10),     
               child: Container(
                 transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                 child:  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Color(0xff2e4040),
                      size: 25,
                    ),
                     onPressed: () {
                Navigator.of(context).pop();
              },
                    ))
                  ),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                     transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Column(
                                          
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Image.asset('assets/images/thankyou.png'),
                                            ),
                                             SizedBox(height: 25,),
                                            Container(
                                              child: Text('Thank you for showing your interest!'),
                                            ),
                                           
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
               ),
         
  ],
),
        
          ),
    );
  }

}