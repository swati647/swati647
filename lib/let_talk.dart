import 'package:flutter/material.dart';
import 'package:rsa_app/franchise.dart';
import 'dart:io';

import 'package:rsa_app/thankyou.dart';

class LetTalk extends StatefulWidget {
  const LetTalk({Key? key}) : super(key: key);

  @override
  State<LetTalk> createState() => _LetTalkState();
}

class _LetTalkState extends State<LetTalk> {
  @override
 
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      resizeToAvoidBottomInset:false,  
      body: Container(
        margin: const EdgeInsets.only(top: 20),
           decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff252424), Color(0xff203e3c)],
        )),
        child: SingleChildScrollView(
            child: Column(
            children: [

              Container(margin: EdgeInsets.all(20), child: 
                Row(
                  children: [
                    Container(
                           alignment: Alignment.topLeft,
                      child: const Text(
                          'Let’s Talk',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                  const Spacer(),
                  IconButton(
                       icon: Icon(
                         Icons.cancel,
                         color: Colors.white.withOpacity(1),
                         size: 25,
                       ),
                        onPressed: () {
                   Navigator.of(context).pop();
              },
                       ),
                  
                  ],
                )),


              Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Name",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'Name',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                          ),
                ),
                alignment: Alignment.center,
              ),
             
              Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Phone Number",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                  decoration:InputDecoration(
                     border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                      ),
                       filled: true,
                      fillColor: const Color(0xff2e4141),                    
                      hintText: 'Phone Number',                      
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold)),
                ),
                alignment: Alignment.center,
              ),

               Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Email",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                          ),
                ),
                alignment: Alignment.center,
              ),

                Container(
                       alignment: Alignment.topLeft,
                  
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Choose Sport',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                Container(
                 child: Column(
                   children: [
                       Row(
                       children: [
                         Padding(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Wrap(
            // space between chips
            spacing: 10,
            // list of chips
            children: const [
              Chip(
                label: Text('Boxing'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Basketball'), labelStyle: TextStyle( color: Colors.white, ),
                // avatar: Icon(Icons.headphones),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Swimming'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Gym'),labelStyle: TextStyle( color: Colors.white, ),
               backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),  
            ]), ),
              ],
                     ),

             Row(
                       children: [
                         Padding(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Wrap(
            // space between chips
            spacing: 10,
            // list of chips
            children: const [
              Chip(
                label: Text('Soccer'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Taekwondo'), labelStyle: TextStyle( color: Colors.white, ),
                // avatar: Icon(Icons.headphones),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Skating'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Dance'),labelStyle: TextStyle( color: Colors.white, ),
               backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),  
            ]), ),
              ],
                     ),

             Row(
                       children: [
                         Padding(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Wrap(
            // space between chips
            spacing: 10,
            // list of chips
            children: const [
              Chip(
                label: Text('Cricket'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Zumba'), labelStyle: TextStyle( color: Colors.white, ),
                // avatar: Icon(Icons.headphones),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Karate'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('CLawn Tennis'),labelStyle: TextStyle( color: Colors.white, ),
               backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),  
            ]), ),
              ],
                     ),

                                  Row(
                       children: [
                         Padding(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Wrap(
            // space between chips
            spacing: 10,
            // list of chips
            children: const [
              Chip(
                label: Text('Squash'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Handball'), labelStyle: TextStyle( color: Colors.white, ),
                // avatar: Icon(Icons.headphones),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Aerobics'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Pilates'),labelStyle: TextStyle( color: Colors.white, ),
               backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),  
            ]), ),
              ],
                     ),

                                  Row(
                       children: [
                         Padding(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Wrap(
            // space between chips
            spacing: 10,
            // list of chips
            children: const [
              Chip(
                label: Text('Self-Defence'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Kick Boxing'), labelStyle: TextStyle( color: Colors.white, ),
                // avatar: Icon(Icons.headphones),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              
              Chip(
                label: Text('Muay Thai'),labelStyle: TextStyle( color: Colors.white, ),
               backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),  
            ]), ),
              ],
                     ),
                                  Row(
                       children: [
                         Padding(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Wrap(
            // space between chips
            spacing: 10,
            // list of chips
            children: const [
              Chip(
                label: Text('Steam/Sauna'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Table Tennis'), labelStyle: TextStyle( color: Colors.white, ),
                // avatar: Icon(Icons.headphones),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              Chip(
                label: Text('Chess'),labelStyle: TextStyle( color: Colors.white, ),
                backgroundColor: Color(0xff324444),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              
            ]), ),
              ],
                     ),
                //          Container(
                //            padding: EdgeInsets.only(left: 10),
                //             child:ButtonTheme(
                //                 // minWidth: 50.0,
                //                 height: 30.0,
                //                 child: MaterialButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Gym",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //          ),
                //            Container(
                //              padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 50.0,
                //                 height: 30.0,
                //                 child: MaterialButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Boxing",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //            ),
                //              Container(
                //                padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 50.0,
                //                 height: 30.0,
                //                 child: MaterialButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Basketball",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //              ),
                //                Container(
                //                  padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: MaterialButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Swimming",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //                ),
                //        ],
                //      ),
                //      Row(
                //        children: [
                //          Container(
                //            padding: EdgeInsets.only(left: 10),
                //             child:ButtonTheme(
                //                 // minWidth: 50.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Soccer",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //          ),
                //            Container(
                //              padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 50.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Taekwondo",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //            ),
                //              Container(
                //                padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 50.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Skating",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //              ),
                //                Container(
                //                  padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Dance",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //                ),
                //        ],
                //      ),
                //      Row(
                //        children: [
                //          Container(  padding: EdgeInsets.only(left: 10),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Cricket",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),),
                //            Container(
                //                padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Zumba",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //            ),
                //              Container(
                //                  padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Karate",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //              ),
                //                Container(
                //                    padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Lawn Tennis",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //                ),
                //        ],
                //      ),
                //      Row(children: [
                //          Container(
                //              padding: EdgeInsets.only(left: 10),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Squash",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //          ),
                //            Container(
                //                padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Handball",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //            ),
                //              Container(
                //                  padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Aerobics",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //              ),
                               
                //                Container(
                //                  padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Pilates",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //              ),
                //        ],),
                //      Row(
                //        children: [
                //          Container(
                //              padding: EdgeInsets.only(left: 10),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Self-Defence",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //          ),
                //            Container(
                //                padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Kick Boxing",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //            ),
                //              Container(  padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Muay Thai",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),),
                             
                //        ],
                //      ),
                //        Row(
                //        children: [
                //          Container(
                //              padding: EdgeInsets.only(left: 10),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Steam/Sauna",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //          ),
                //            Container(
                //                padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Table Tennis",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),
                //            ),
                //              Container(  padding: EdgeInsets.only(left: 5),
                //             child:ButtonTheme(
                //                 // minWidth: 20.0,
                //                 height: 30.0,
                //                 child: RaisedButton(
                //                     onPressed: () {
                //                                   Navigator.push(
                //                                     context,
                //                                     MaterialPageRoute(
                //                                           builder: (BuildContext context) => LetTalk()));
                //                               },
                //                     color: Color(0xff2e4141),
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius: BorderRadius.circular(20)),
                //                     child: const Text(
                //                                 "Chess",
                //                                 style: TextStyle(
                //                                   fontWeight: FontWeight.w400,
                //                                   fontSize: 15,
                //                                   color: Color(0xffffffff),
                //                                 ),
                //                               ),
                //                 ),
                //               ),),
                             
                      
                   ],
                 ),
                ),

                  Container(
                       alignment: Alignment.topLeft,
                  
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Message',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
         
                Container(
                height: 5 * 24.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'i Want to learn all these sports.',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15,  height: 2,
                          fontWeight: FontWeight.bold),
                          ),
                         maxLines: 5,
                ),
                alignment: Alignment.topLeft,
              ),
             
              const SizedBox(
                height: 10,
              ),

              ButtonTheme(
  minWidth: 300.0,
  height: 50.0,
  child: RaisedButton(
       onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                           builder: (BuildContext context) => Franchise()));
                 },
      color: Color(0xff324444),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
      child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
  ),
),
              
   SizedBox(height: 10,) ,          
            ],
          ),
          ),
      ),
    );
  }

}