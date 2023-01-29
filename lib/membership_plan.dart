import 'package:flutter/material.dart';
import 'dart:io';
import 'package:rsa_app/thankyou.dart';

import 'let_talk.dart';

class MembershipPlan extends StatefulWidget {
  const MembershipPlan({Key? key}) : super(key: key);

  @override
  State<MembershipPlan> createState() => _MembershipPlanState();
}

class _MembershipPlanState extends State<MembershipPlan> {
  @override
 
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset:false,
     
        body: Container(
         decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff252424), Color(0xff203e3c)],
        )),
      
         child: SingleChildScrollView(
           child: Column(
              children: [
                Container(
                 child:Row(
                   children: [
                     Container(
                       alignment: Alignment.topLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 80),
                    child: Text(
                      'Membership Plan',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),),
                  Container(
                      // alignment: Alignment.topRight,
               padding: EdgeInsets.only(left: 150,top: 70),     
               child:  Positioned(
                // right: -2,
                // top: -9,
                child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white.withOpacity(1),
                      size: 25,
                    ),
                     onPressed: () {
                Navigator.of(context).pop();
              },
                    )),
                  ),
                   ],
                 ),      
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0,bottom: 20),
                    child: Text(
                      'Selaect a Membership Option',
                      style: TextStyle(fontSize: 18, color: Color(0xffc5deba)),
                    ),
                  ),
                ),
               
               Container(
                   padding: EdgeInsets.only(left: 10.0, right: 10),
                      width: 390,
                      height: 270,
                       child: Card(
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color(0xff2e4040),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset('assets/images/gold_membership_icon.png'),
                                        ),
                                       Container( 
                                         padding: EdgeInsets.only(left: 20.0),
                                         child:const Text(
                                          'Gold  \nMembership',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),),
                                        Container(
                                          padding: EdgeInsets.only(left: 20, bottom: 50),
                                          child: Text('3 months',  
                                          style: TextStyle(
                                            color: Color(0xffc5deba),
                                            // fontSize: 25,
                                          ),)
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          'Description & Price',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                     SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          'More Details',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 15, decoration:
                                                 TextDecoration.underline,
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.amber,
                                        )
                                      ],
                                    ),
                                     SizedBox(height: 10,),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.white,
                                    ),
                                    //  SizedBox(height: 10,),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                         child: const Text('\u{20B9}',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),)
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                          '699',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),
                                        ),),
                                        Container(
                                          padding: EdgeInsets.only(left: 90),
                                                 child:ButtonTheme(
                                                  minWidth: 130.0,
                                                  height: 30.0,
                                                  child: RaisedButton(
                                                      onPressed: () {
                                                                   Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                           builder: (BuildContext context) => LetTalk()));
                                                                },
                                                      color: Color(0xffc5deba),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5)),
                                                      child: const Text(
                                                                  "BUY",
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 20,
                                                                    color: Color(0xff2E4141),
                                                                  ),
                                                                ),
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
               ),
         
         
               Container(
                   padding: EdgeInsets.only(left: 10.0, right: 10),
                      width: 390,
                      height: 270,
                       child: Card(
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color(0xff2e4040),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset('assets/images/gold_membership_icon_1.png'),
                                        ),
                                       Container( 
                                         padding: EdgeInsets.only(left: 20.0),
                                         child:const Text(
                                          'Gold  \nMembership',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),),
                                        Container(
                                          padding: EdgeInsets.only(left: 20, bottom: 50),
                                          child: Text('3 months',  
                                          style: TextStyle(
                                            color: Color(0xffc5deba),
                                            // fontSize: 25,
                                          ),)
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          'Description & Price',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                     SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          'More Details',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 15, decoration:
                                                 TextDecoration.underline,
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.amber,
                                        )
                                      ],
                                    ),
                                     SizedBox(height: 10,),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.white,
                                    ),
                                    //  SizedBox(height: 10,),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                         child: const Text('\u{20B9}',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),)
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                          '699',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),
                                        ),),
                                        Container(
                                          padding: EdgeInsets.only(left: 90),
                                                 child:ButtonTheme(
                                                  minWidth: 130.0,
                                                  height: 30.0,
                                                  child: RaisedButton(
                                                      onPressed: () {
                                                                  //  Navigator.push(
                                                                  //     context,
                                                                  //     MaterialPageRoute(
                                                                  //          builder: (BuildContext context) => FootballPage()));
                                                                },
                                                      color: Color(0xffc5deba),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5)),
                                                      child: const Text(
                                                                  "BUY",
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 20,
                                                                    color: Color(0xff2E4141),
                                                                  ),
                                                                ),
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
               ),
         
               Container(
                   padding: EdgeInsets.only(left: 10.0, right: 10),
                      width: 390,
                      height: 270,
                       child: Card(
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color(0xff2e4040),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset('assets/images/gold_membership_icon.png'),
                                        ),
                                       Container( 
                                         padding: EdgeInsets.only(left: 20.0),
                                         child:const Text(
                                          'Gold  \nMembership',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),),
                                        Container(
                                          padding: EdgeInsets.only(left: 20, bottom: 50),
                                          child: Text('3 months',  
                                          style: TextStyle(
                                            color: Color(0xffc5deba),
                                            // fontSize: 25,
                                          ),)
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          'Description & Price',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                     SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          'More Details',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 15, decoration:
                                                 TextDecoration.underline,
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.amber,
                                        )
                                      ],
                                    ),
                                     SizedBox(height: 10,),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.white,
                                    ),
                                    //  SizedBox(height: 10,),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                         child: const Text('\u{20B9}',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),)
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                          '699',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 25,
                                          ),
                                        ),),
                                        Container(
                                          padding: EdgeInsets.only(left: 90),
                                                 child:ButtonTheme(
                                                  minWidth: 130.0,
                                                  height: 30.0,
                                                  child: RaisedButton(
                                                      onPressed: () {
                                                                  //  Navigator.push(
                                                                  //     context,
                                                                  //     MaterialPageRoute(
                                                                  //          builder: (BuildContext context) => FootballPage()));
                                                                },
                                                      color: Color(0xffc5deba),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5)),
                                                      child: const Text(
                                                                  "BUY",
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 20,
                                                                    color: Color(0xff2E4141),
                                                                  ),
                                                                ),
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
               ),
              ],
           ),
         ),
   ),    

      ),
      debugShowCheckedModeBanner: false,
    );
  }

}